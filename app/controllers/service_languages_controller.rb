class ServiceLanguagesController < ApplicationController
	before_action :load_service, only: [:create]
	def index
		@service_languages = ServiceLanguage.where(language: I18n.locale)
	end
	def create
		@service_language = @service.service_languages.new(s_l_params)
		if @service_language.save
			flash[:notice] = "Successfully added"
			return redirect_to @service_language
		else
			redirect_to service_path(@service), error: "Failure"
		end
	end
	def show
		@service_language = ServiceLanguage.find_by_slug(params[:slug])
	end
	def details
		@service_language = ServiceLanguage.find_by_slug(params[:slug])
	end
	def edit
		@service_language = ServiceLanguage.find_by_slug(params[:id])
		# if @service_language
		# 	redirect_to 
	end
	def update
		@service_language = ServiceLanguage.find(params[:id])
		if @service_language.update(s_l_params)
			flash[:notice] = "Success"
			redirect_to @service_language
		else
			render :edit, error: "Failure"
		end
	end
	def read_more
		@service_language = ServiceLanguage.find_by_slug(params[:slug])
	end
	# def your_services
	# 	@services = ServiceLanguage.find(params[])
	# end

	private
	def load_service
		@service = Service.find(params[:service_language][:service_id])
	end
	def s_l_params
		params.require(:service_language).permit(:slug, :language, :description, :content)
	end
end
