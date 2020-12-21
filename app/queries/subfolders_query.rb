# frozen_string_literal: true

class SubfoldersQuery
  attr_reader :subfolder_relation_object, :params

  def initialize(params = {}, subfolder_relation_object = Subfolder.joins(:folder))
    @subfolder_relation_object = subfolder_relation_object
    @params = params
  end

  def exists?
    subfolder_relation_object.where(params).exists?
  end
end
