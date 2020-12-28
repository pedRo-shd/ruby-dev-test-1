module Folders
  class SubfolderAfterCreateBusiness
    include Rails.application.routes.url_helpers

    def initialize(options)
      @name = options.fetch(:name)
      @subfolder = options.fetch(:subfolder)
    end

    def save
      subfolder.update(parents_path: complete_parents_path)
    end

    private

    attr_accessor :name, :subfolder

    delegate :name, :parent, to: :subfolder
    delegate :parents_path, to: :parent

    def complete_parents_path
      parents_path.merge(data)
    end

    def data
      {
        name => index_subfolders_path(subfolder.id)
      }
    end
  end
end
