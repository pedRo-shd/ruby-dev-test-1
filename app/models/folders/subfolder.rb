module Folders
  class Subfolder < Folder
    validates :name, uniqueness: true, if: proc {
      SubfoldersQueries.new(name: name, parent_id: parent_id).exists?
    }
  end
end
