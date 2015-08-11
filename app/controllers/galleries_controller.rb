class GalleriesController < ApplicationController
	before_action :load_service, only: [:create]
	def index
		@galleries = Gallery.all
	end
	def create
		@gallery = Gallery.new(service_id: params[:gallery][:service_id])
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

	private
	def load_service
		@service = Service.find(params[:gallery][:service_id])
	end
end
