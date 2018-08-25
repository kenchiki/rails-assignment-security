class BlogsController < ApplicationController
  attr_reader :presenter
  before_action :set_presenter
  delegate :blog, to: :presenter, prefix: true

  def create
    presenter.blog = Blog.new(blog_params)
    render :new and return unless presenter_blog.save
    redirect_to presenter_blog, notice: 'Blog was successfully created.'
  end

  def update
    render :edit and return unless presenter_blog.update(blog_params)
    redirect_to presenter_blog, notice: 'Blog was successfully updated.'
  end

  def destroy
    presenter_blog.destroy!
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  private

  def set_presenter
    @presenter = BlogsPresenter.new(params: params)
  end

  def blog_params
    params.require(:blog).permit(:title)
  end
end
