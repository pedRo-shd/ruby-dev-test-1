class Folder < ApplicationRecord
  has_many :subfolders, foreign_key: :parent_id
  belongs_to :parent, optional: true
  has_many :subfolders, -> { order(:name) }

  validates :name, presence: true
  validates :name, uniqueness: true, if: -> { parent_id.nil? }
end
