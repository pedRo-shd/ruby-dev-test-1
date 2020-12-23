module Folders
  class Subfolder < Folder
    validates :name, uniqueness: true, if: proc {
      SubfoldersQuery.new(name: name, parent_id: parent_id).exists?
    }
  end
end
