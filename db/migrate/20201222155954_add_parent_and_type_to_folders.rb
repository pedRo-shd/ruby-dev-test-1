class AddParentAndTypeToFolders < ActiveRecord::Migration[6.1]
  def change
    add_column :folders, :parent_id, :integer
    add_column :folders, :type, :string
  end
end
