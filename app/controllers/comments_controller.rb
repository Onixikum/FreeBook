class CommentsController < ApplicationController
  before_action :correct_author, only: [:edit, :update]
  before_action :comment_del,    only: :destroy

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

    def author_comment
      @comment = Comment.find(params[:id])
      @comment_user = @comment.user
    end

    def correct_author
      author_comment
      redirect_to(root_url) unless current_user?(@comment_user)
    end

    def comment_del
      author_comment
      redirect_to(root_url) unless current_user?(@comment_user) || current_user.admin?
    end
end
