class Service < ActiveRecord::Base
  belongs_to :user, inverse_of: :services
  has_many :service_languages, inverse_of: :service
  has_one :gallery, inverse_of: :service
end
