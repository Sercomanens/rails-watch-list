class BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy
  before_action :set_list, only: [:new, :create, :add_movie, :create_movie]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  def add_movie
    @movie = Movie.new
  end

  def create_movie
    @movie = Movie.new(movie_params)
    if @movie.save
      @bookmark = Bookmark.new(movie: @movie, list: @list, comment: params[:comment])
      if @bookmark.save
        redirect_to list_path(@list)
      else
        render :add_movie, status: :unprocessable_entity
      end
    else
      render :add_movie, status: :unprocessable_entity
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def movie_params
    params.require(:movie).permit(:title, :overview, :poster)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
