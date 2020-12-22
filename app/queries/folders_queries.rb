# frozen_string_literal: true

class FoldersQueries
  attr_reader :folde_object, :params

  def initialize(params = {}, folde_object = Folder)
    @folde_object = folde_object
    @params = params
  end

  def all
    folde_object.where('parent_id IS NULL')
  end
end
