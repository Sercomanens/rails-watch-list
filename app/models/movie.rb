class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  # validates :overview, presence: true
  has_one_attached :poster
end
