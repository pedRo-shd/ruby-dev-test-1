class Folder < ApplicationRecord
  validates :name, presence: true
  has_many :subfolders, foreign_key: :parent_id
  belongs_to :parent, optional: true
  has_many :subfolders, -> { order(:name) }
end
