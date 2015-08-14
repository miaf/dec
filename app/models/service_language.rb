class ServiceLanguage < ActiveRecord::Base
	belongs_to :service, dependent: :destroy, inverse_of: :service_languages
	# belongs_to :user, through: :service
	# belongs_to :language, dependent: :destroy
	validates :slug,
						presence: true,
						uniqueness: true,
						length: {in: 1..30}
	validates :language,
						presence: true,
						length: {is: 2}
	validates :description,
						presence: true
	validates :content,
						presence: true
end
