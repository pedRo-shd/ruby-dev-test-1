# frozen_string_literal: true

class SubfoldersQueries
  attr_reader :subfolder_object, :params

  def initialize(params = {}, subfolder_object = Folders::Subfolder)
    @subfolder_object = subfolder_object
    @params = params
  end

  def exists?
    subfolder_object.where(params).exists?
  end
end
