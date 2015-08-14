class GalleriesController < ApplicationController
	# before_action :load_service, only: [:create]
	# before_action :load_current_user, only: [:create]

	def index
		@galleries = Gallery.all
	end
	def create
		@gallery = Gallery.new(user_id: params[:gallery][:user_id])
		if @gallery.save
			flash[:notice] = "Your gallery has been created"
			redirect_to @gallery
		else
			redirect_to root_path, error: "the service was not created"
		end
	end
	def show
		@gallery = Gallery.find(params[:id])
		@gallery_language = GalleryLanguage.new(gallery_id: @gallery.id)
	end

	def your_galleries
		@galleries =  current_user.galleries
		@gallery_languages = nil# current_user.galleries.gallery_languages.build
		if @galleries
			for gallery in @galleries
				@gallery_languages << gallery.gallery_languages
			end
		else
			redirect_to user_path(current_user), error: "You have no gallery."
		end
		# @gallery = Gallery.find(params[:id])
		# if @gallery.service.user == current_user
		# 	@gallery_languages = @gallery.gallery_languages.build
		# else
		# 	
		# end
	end

	private
	def load_service
		@service = Service.find(params[:gallery][:service_id])
	end

	def load_current_user
		@user = User.find(params[:gallery][:user_id])
	end
end
