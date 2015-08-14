class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.registration_confirmation(@user).deliver
			redirect_to root_path, notice: "Registration has been sent! Please confirm your email address."
		else
			flash[:alert] = "The action was not performed. Please try again."
			render 'new'
		end
	end

	def confirm_email
		user = User.find_by_confirm_token(params[:confirm_token])
		if user
			user.email_activate
			flash[:succes] = "Your email address has been approved! We will reply to you."
			redirect_to root_url
		else
			flash[:error] = "Error: User does not exist."
			redirect_to root_path
		end
	end

	def show
		current_user = User.find(params[:id])
		if !current_user.gallery
			@gallery = Gallery.new(user_id: current_user.id)
		end
	end

	private
	def user_params
		params.require(:user).permit(User.user_params)
	end
end
