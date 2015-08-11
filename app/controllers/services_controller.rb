class ServicesController < ApplicationController
	def index
		@services = Service.all
	end
	def your_services
		# @services = Service.join(:service_languages)#where("user_id = ?", current_user.id)
		# @service = current_user.services.build
		@service = Service.new(user_id: current_user.id)
	end
	def new
		@service = current_user.services.build
	end
	def create
		@service = current_user.services.build
		if @service.save
			flash[:notice] = "Your service has been created"
			redirect_to @service
		else
			redirect_to action: :your_services, error: "the service was not created"
		end
	end
	def show
		@service = current_user.services.find(params[:id])
		@service_language = @service.service_languages.build
		@gallery = Gallery.new(service_id: @service.id)
	end

	private
	def load_current_user
		# @current_user = 
	end
end
