class Folder < ApplicationRecord
  has_many :subfolders, -> { order(:name) }, class_name: 'Folders::Subfolder', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Folder', optional: true

  validates :name, presence: true
  validates :name, uniqueness: true, if: -> { parent_id.nil? }
end
