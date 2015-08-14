class GalleryLanguage < ActiveRecord::Base
  belongs_to :gallery, inverse_of: :gallery_languages

  validates :slug,
  			presence: true,
  			uniqueness: true
  			
  validates :name,
  			presence: true,
  			uniqueness: true

  validates :description,
  			presence: true

  validates :language,
  			presence: true
end
