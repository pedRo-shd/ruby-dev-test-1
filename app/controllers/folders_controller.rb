class FoldersController < ApplicationController
  before_action :set_folder, only: %i[show edit update destroy]
  before_action :folders, only: %i[index]

  def index
    render :index, locals: { presenter: presenter }
  end

  def new
    @folder = Folder.new
  end

  def edit; end

  def create
    @folder = Folder.new(folder_params)
    @folder.save
    respond_with @folder, location: -> { folders_path }
  end

  def update
    @folder.update(folder_params)
    respond_with @folder, location: -> { folders_path }
  end

  def destroy
    @folder.destroy
    respond_with @folder
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name)
  end

  def folders
    @folders = FoldersQuery.new.all
  end

  def presenter
    @presenter ||= ::FolderPresenter.new
  end
end
