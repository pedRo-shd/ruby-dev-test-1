module Folders
  class Subfolder < Folder
    validates :name, uniqueness: true, if: proc {
      FoldersQuery.new(name: name, parent_id: parent_id).exists?
    }
  end
end
