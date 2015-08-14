class GalleryLanguagesController < ApplicationController
	before_action :load_gallery, only: [:create]

	def index
		@gallery_languages = GalleryLanguage.where(language: I18n.locale)
	end
	
	def create
		@gallery_language = @gallery.gallery_languages.new(g_l_params)
		if @gallery_language.save
			flash[:notice] = "Successfully added"
			return redirect_to @gallery_language
		else
			redirect_to gallery_path(@gallery), error: "Failure"# root_path
		end
	end
	def show
		@gallery_language = GalleryLanguage.find_by_slug(params[:id])
	end
	def your_gallery
		@gallery = Gallery.includes(:gallery_languages).where(galleries: {user_id: current_user.id}).first
		# gallery = Gallery.find_by_user_id(params[:user_id])
		if @gallery
			@gallery
		else
			redirect_to user_path(current_user), alert: "Unable to find the gallery."
		end
	end

	private
	def load_gallery
		@gallery = Gallery.find(params[:gallery_language][:gallery_id])
	end
	def g_l_params
		params.require(:gallery_language).permit(:slug, :description, :language, :name)
	end
end
