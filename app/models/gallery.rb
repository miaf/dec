class Gallery < ActiveRecord::Base
  belongs_to :service, inverse_of: :galleries
  has_many :gallery_languages, inverse_of: :gallery
  
end
