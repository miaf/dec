class SessionsController < ApplicationController
	def new
		# @user = User.new
	end
	def create
		user = User.authenticate(params[:login_name], params[:password])
		if user
			if user.email_confirmed
				session[:user_id] = "#{user.id}#{user.login_name}"
				redirect_to [user]#, notice: 'Logged in!'
			else
				flash[:error] = "Please activate your account."
			end
		else
			flash.now.alert = "Invalid login or password"
			render 'new'
		end
	end

	# HTTP get
	def forgot_password
		# @user = User.new
	end
	def send_password_reset_instructions
	  login_name_or_email = params[:email_or_login_name]

	  if login_name_or_email.present?
		  if login_name_or_email.rindex('@')
		    user = User.find_by_email(login_name_or_email)
		  else
		    user = User.find_by_login_name(login_name_or_email)
		  end
		else
			flash[:error] = "Please enter either your email either your login name"
			return render action: 'forgot_password'
		end

	  if user
	    user.password_reset_token = SecureRandom.urlsafe_base64
	    user.password_expires_after = 24.hours.from_now
	    user.save
	    UserMailer.reset_password_email(user).deliver
	    flash[:notice] = 'Password instructions have been mailed to you. Please check your inbox.'
	    return redirect_to root_path
	  else
			flash[:error] = "No found!"
			flash.now[:error] = 'Unknown user. Please check your username and password.'
	    # @user = User.new
	    # put the previous value back.
	    # @user.login_name = params[:email_or_login_name]
	    # @user.errors[:email_or_login_name] = 'is not a registered user.'
	    return render :action => "forgot_password"
	  end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: "logged out!"
	end

	# The user has landed on the password reset page, they need to enter a new password.
	# HTTP get
	def password_reset
	  token = params.first[0]
	  @user = User.find_by_confirm_token(token)

	  if @user.nil?
	    flash[:error] = 'You have not requested a password reset.'
	    return redirect_to :root	    
	  end

	  if @user.password_expires_after < DateTime.now
	    clear_password_reset(@user)
	    @user.save
	    flash[:error] = 'Password reset has expired. Please request a new password reset.'
	    redirect_to :forgot_password
	  end
	end
	
	# The user has entered a new password. Need to verify and save.
	# HTTP put
	def new_password
	  username = params[:user][:username]
	  @user = User.find_by_username(username)

	  if verify_new_password(params[:user])
	    @user.update(params[:user])
	    @user.password = @user.new_password

	    if @user.valid?
	      clear_password_reset(@user)
	      @user.save
	      flash[:notice] = 'Your password has been reset. Please sign in with your new password.'
	      redirect_to :sign_in
	    else
	      render :action => "password_reset"
	    end
	  else
	    @user.errors[:new_password] = 'Cannot be blank and must match the password verification.'
	    render :action => "password_reset"
	  end
	end

end
