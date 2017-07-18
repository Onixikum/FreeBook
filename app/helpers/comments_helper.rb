module CommentsHelper

  def i_author?(comment)
    comment.user == current_user
  end

end
