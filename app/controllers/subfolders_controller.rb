class SubfoldersController < ApplicationController
  before_action :set_subfolder, only: %i[show edit update destroy]
  before_action :folder, only: %i[index new create]

  respond_to :html

  def index
    @subfolders = Subfolder.all
    respond_with @subfolder, location: -> { index_subfolders_path(@folder.id) }
  end

  def show
    respond_with @subfolder
  end

  def new
    @subfolder = Subfolder.new
    respond_with @subfolder, location: -> { new_subfolders_path(@folder, @subfolder) }
  end

  def edit; end

  def create
    @subfolder = Subfolder.new(params_subfolder)
    @subfolder.save
    respond_with @subfolder, location: -> { index_subfolders_path(@folder.id) }
  end

  def update
    @folder = @subfolder.folder
    @subfolder.update(name: params[:name])
    respond_with @subfolder, location: -> { index_subfolders_path(@folder.id) }
  end

  def destroy
    @subfolder.destroy
    respond_with @subfolder, location: -> { "/#{@subfolder.folder.id}/subfolders" }
  end

  private

  def set_subfolder
    @subfolder = Subfolder.find(params[:id])
  end

  def params_subfolder
    { name: params[:name], folder_id: params[:folder_id] }
  end

  def folder
    @folder = Folder.find params[:folder_id]
  end
end
