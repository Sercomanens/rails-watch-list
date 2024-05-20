class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  validates :comment, presence: true, length: { minimum: 6 }
  validate :unique_movie_list_combination

  private

  def unique_movie_list_combination
    existing_bookmark = Bookmark.find_by(movie_id: movie_id, list_id: list_id)
    if existing_bookmark && existing_bookmark != self
      errors.add(:base, 'Bookmark for this movie and list combination already exists')
    end
  end
end
