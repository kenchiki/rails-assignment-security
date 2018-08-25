class EntriesController < ApplicationController
  before_action :set_presenter
  attr_reader :presenter
  delegate :blog, :entry, to: :presenter, prefix: true

  def create
    presenter.entry = presenter_blog.entries_new(entry_params)
    render :new and return unless presenter_entry.save
    redirect_to blog_entry_path(presenter_blog, presenter_entry), notice: 'Entry was successfully created.'
  end

  def update
    return render :edit unless presenter_entry.update(entry_params)
    redirect_to blog_entry_path(presenter_blog, presenter_entry), notice: 'Entry was successfully updated.'
  end

  def destroy
    presenter_entry.destroy!
    redirect_to presenter_blog, notice: 'Entry was successfully destroyed.'
  end

  private

  def set_presenter
    @presenter = EntriesPresenter.new(params: params)
  end

  def entry_params
    params.require(:entry).permit(:title, :body)
  end
end
