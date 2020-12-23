class Folder < ApplicationRecord
  has_many :subfolders, lambda {
    order(:name)
  }, class_name: 'Folders::Subfolder', foreign_key: :parent_id, dependent: :destroy

  has_many :assets, lambda {
    order(:name)
  }, class_name: 'Folders::Asset', foreign_key: :parent_id, dependent: :destroy

  belongs_to :parent, class_name: 'Folder', optional: true

  validates :name, presence: true
  validates :name, uniqueness: true, if: -> { parent_id.nil? }
end
