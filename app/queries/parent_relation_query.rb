# frozen_string_literal: true

class ParentRelationQuery
  attr_reader :parent_relation, :params

  def initialize(params = {}, parent_relation = Folder.includes(:subfolders, :assets))
    @parent_relation = parent_relation
    @params = params
  end

  def subfolders
    active_record_relation = parent_relation.where(params).order(type: :desc)
    return [] if active_record_relation.blank?

    active_record_relation
  end
end
