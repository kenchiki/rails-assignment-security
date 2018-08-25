class EntriesPresenter
  attr_reader :blog, :comment
  attr_accessor :entry

  def initialize(args)
    @params = args[:params]
    set_path_models
  end

  def blog_entries_new(entry_params)
    @entry = blog_entries.new(entry_params)
  end

  private

  def set_path_models
    @blog = Blog.find(@params[:blog_id])
    @entry = find_path_entry
    @comment = Comment.new
  end

  def find_path_entry
    return blog.entries_find(@params[:id]) if @params[:id]
    Entry.new
  end
end
