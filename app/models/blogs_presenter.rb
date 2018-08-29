class BlogsPresenter
  attr_accessor :blog

  def initialize(args)
    @params = args[:params]
    set_path_models
  end

  def blog_new(blog_params)
    @blog = Blog.new(blog_params)
  end

  private

  def set_path_models
    @blog = find_path_blog
  end

  def find_path_blog
    return Blog.where("id = #{@params[:id]}").first if @params[:id]
    Blog.new
  end
end
