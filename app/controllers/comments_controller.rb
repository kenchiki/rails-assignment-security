class CommentsController < ApplicationController
  before_action :set_presenter
  attr_reader :presenter
  delegate :blog, :entry, :comment, to: :presenter, prefix: true

  def approve
    presenter_comment.approved!
    redirect_to blog_entry_path(presenter_blog, presenter_entry), notice: 'Comment was successfully approved.'
  end

  def create
    presenter.comment = presenter_entry.comments_new(comment_params)
    unless presenter_comment.save
      render template: 'entries/show' and return
    end

    redirect_to blog_entry_path(presenter_blog, presenter_entry), notice: 'Comment was successfully created.'
  end

  def destroy
    presenter_comment.destroy!
    redirect_to blog_entry_path(presenter_blog, presenter_entry), notice: 'Comment was successfully destroyed.'
  end

  private

  def set_presenter
    @presenter = CommentsPresenter.new(params: params)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
