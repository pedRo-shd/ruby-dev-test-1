# frozen_string_literal: true

class FoldersQuery
  attr_reader :folder_object, :params

  def initialize(params = {}, folder_object = Folder)
    @folder_object = folder_object
    @params = params
  end

  def all
    folder_object.where('parent_id IS NULL').order(type: :asc)
  end

  def exists?
    folder_object.where(params).exists?
  end

  def by_parent
    folder_object.where(params).order(type: :desc)
  end
end
