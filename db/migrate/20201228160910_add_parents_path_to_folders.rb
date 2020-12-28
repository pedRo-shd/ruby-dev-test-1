class AddParentsPathToFolders < ActiveRecord::Migration[6.1]
  def change
    add_column :folders, :parents_path, :json
  end
end
