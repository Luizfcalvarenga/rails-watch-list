class List < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, :image_url, presence: true
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks

end
