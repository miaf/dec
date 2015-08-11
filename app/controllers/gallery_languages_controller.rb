class GalleryLanguagesController < ApplicationController
	before_action :load_gallery, only: [:create]
	
	def create
		@gallery_language = @gallery.gallery_languages.new(g_l_params)
		if @gallery_language.save
			flash[:notice] = "Successfully added"
			return redirect_to @gallery_language
		else
			redirect_to gallery_path(@gallery), error: "Failure"
		end
	end
	def show
		@gallery_language = GalleryLanguage.find(params[:id])
	end

	private
	def load_gallery
		@gallery = Gallery.find(params[:gallery_language][:gallery_id])
	end
	def g_l_params
		params.require(:gallery_language).permit(:slug, :description, :language)
	end
end
