class Folder < ApplicationRecord
  has_many :subfolders, lambda {
    order(type: :desc)
  }, class_name: 'Folders::Subfolder', foreign_key: :parent_id, dependent: :destroy

  has_many :assets, lambda {
    order(type: :desc)
  }, class_name: 'Folders::Asset', foreign_key: :parent_id, dependent: :destroy

  belongs_to :parent, class_name: 'Folder', optional: true

  validates :name, presence: true
  validates :name, uniqueness: true, if: -> { parent_id.nil? }

  after_create :build_parents_path

  private

  def build_parents_path
    return build_parents_path_to_folder if instance_of?(Folder)
    return build_parents_path_to_subfolder if instance_of?(Folders::Subfolder)
  end

  def build_parents_path_to_folder
    FolderAfterCreateBusiness.new(
      name: name,
      folder: self
    ).save
  end

  def build_parents_path_to_subfolder
    Folders::SubfolderAfterCreateBusiness.new(
      name: name,
      subfolder: self
    ).save
  end
end
