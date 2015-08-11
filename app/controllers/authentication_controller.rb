class AuthenticationController < ApplicationController
	def log_in
		@user = User.new
	end
end
