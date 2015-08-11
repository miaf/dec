class LanguagesController < ApplicationController
	def index
		@language = Language.new
	end
	def create
		@language = Language.new(language_params)
		if @language.save
			flash[:notice] = "The language was added"
			redirect_to action: :index
		else
			render :index, error: "The language was not added"
		end
	end

	private
	def language_params
		params.require(:language).permit(:code, :name)
	end
end
