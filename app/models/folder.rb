class Folder < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :subfolders, -> { order(:name) }, dependent: :destroy
end
