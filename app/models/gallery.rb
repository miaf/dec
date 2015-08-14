class Gallery < ActiveRecord::Base
  belongs_to :user, inverse_of: :gallery
  has_many :gallery_languages, inverse_of: :gallery
  # belongs_to :user,through: :service

end
