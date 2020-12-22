class Subfolder < ApplicationRecord
  belongs_to :folder
  validates :name, presence: true
  validates :name, uniqueness: true, if: proc {
    SubfoldersQuery.new(name: name, folder_id: folder_id).exists?
  }
end
