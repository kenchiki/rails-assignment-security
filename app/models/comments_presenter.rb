class CommentsPresenter
  attr_reader :blog, :entry
  attr_accessor :comment

  def initialize(args)
    @params = args[:params]
    set_path_models
  end

  private

  def set_path_models
    @blog = Blog.find(@params[:blog_id])
    @entry = blog.entries_find(@params[:entry_id])
    @comment = find_path_comment
  end

  def find_path_comment
    return entry.comments_find(@params[:comment_id]) if @params[:comment_id]
    return entry.comments_find(@params[:id]) if @params[:id]
    Comment.new
  end
end
