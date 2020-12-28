class UploadFilesController < ApplicationController
  def new
    @folder = folder if params[:id].present?
    @asset = Folders::Asset.new
  end

  def create
    raise "File can't be blank" if params[:file].blank?
    return upload_and_redirect_to_folders if asset_without_parent?
    return upload_and_redirect_to_subfolders if folder.instance_of?(Folder)
    return upload_and_redirect_to_subfolder if parent?
  end

  def destroy
    return destroy_and_redirect_to_folders unless parent?

    send("destroy_and_redirect_to_#{interpreted_object}")
  end

  private

  delegate :parent, :parent_id, to: :folder, allow_nil: true

  def parent?
    return false if parent_id.blank?

    true
  end

  def interpreted_object
    return 'folder' if parent.instance_of?(Folder)
    return 'subfolder' if parent.instance_of?(Folders::Subfolder)
  end

  def destroy_and_redirect_to_folders
    folder.file.purge
    folder.destroy
    redirect_to folders_path
  end

  def destroy_and_redirect_to_folder
    parent_id = folder.parent_id
    folder.file.purge
    folder.destroy
    redirect_to index_subfolders_path(parent_id)
  end

  def destroy_and_redirect_to_subfolder
    parent_id = folder.parent_id
    folder.file.purge
    folder.destroy
    redirect_to subfolder_path(parent_id)
  end

  def upload_and_redirect_to_folders
    asset_create_business.save
    redirect_to folders_path
  end

  def asset_without_parent?
    return true if params[:id].blank?

    false
  end

  def upload_and_redirect_to_subfolder
    asset_create_business.save
    redirect_to subfolder_path(folder)
  end

  def upload_and_redirect_to_subfolders
    asset_create_business.save
    redirect_to index_subfolders_path(folder)
  end

  def asset_create_business
    @asset_create_business ||= AssetCreateBusiness.new(
      folder: folder_params,
      file: params[:file]
    )
  end

  def folder_params
    return if params[:id].blank?

    folder
  end

  def folder
    @folder ||= Folder.find params[:id]
  end
end
