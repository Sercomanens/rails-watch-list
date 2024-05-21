class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[list:id])
    @movie = Movie.find(params[movie:id])

    @bookmark.list = @list
    @bookmark.movie = @movie


    if @bookmark.save
      redirect_to bookmarks_path(@bookmark)
    else
      render :new
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end
end
