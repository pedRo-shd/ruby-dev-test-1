class FolderAfterCreateBusiness
  include Rails.application.routes.url_helpers

  def initialize(options)
    @name = options.fetch(:name)
    @folder = options.fetch(:folder)
  end

  def save
    folder.update(parents_path: data)
  end

  private

  attr_accessor :name, :folder

  def data
    {
      name => index_subfolders_path(folder.id)
    }
  end
end
