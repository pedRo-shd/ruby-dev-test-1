# frozen_string_literal: true

class ParentRelationQueries
  attr_reader :parent_relation, :params

  def initialize(params = {}, parent_relation = Folders::Subfolder.includes(:subfolders))
    @parent_relation = parent_relation
    @params = params
  end

  def subfolders
    active_record_relation = parent_relation.where(params)
    return [] if active_record_relation.blank?

    active_record_relation
  end
end
