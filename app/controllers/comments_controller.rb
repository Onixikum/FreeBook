class CommentsController < ApplicationController

  def new
    book_id = params[:book_id]
    @book = Book.find(book_id)
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "The comment is successfully added"
      redirect_to (book_path(@comment.book_id))
    else
      book_id = params[:comment][:book_id]
      @book = Book.find(book_id)
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment updated"
      redirect_to @comment.book
    else
      render 'edit'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment deleted"
    redirect_to root_url
  end

  private

    def comment_params
      params.require(:comment).permit(:book_id, :user_id, :content)
    end
end
