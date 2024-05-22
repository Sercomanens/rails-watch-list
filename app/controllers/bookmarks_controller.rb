class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def new
    @bookmark = Bookmark.new
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    respond_to do |format|
      if @bookmark.save
        format.turbo_stream
        format.html { redirect_to bookmarks_path, notice: 'Bookmark was successfully created.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@bookmark, partial: 'bookmarks/form', locals: { bookmark: @bookmark }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

    def destroy
      @bookmark = Bookmark.find(params[:id])
      @bookmark.destroy
      redirect_to bookmarks_path, notice: 'Bookmark was successfully deleted.'
    end


  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :list_id, :comment, :description)
  end
end
