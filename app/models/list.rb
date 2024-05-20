class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks

  validates :name, presence: true, uniqueness: true

  before_destroy :destroy_saved_movies

  private

  def destroy_saved_movies
    movies.each(&:destroy)
  end
end
