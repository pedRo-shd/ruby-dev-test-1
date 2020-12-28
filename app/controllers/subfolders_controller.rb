class SubfoldersController < ApplicationController
  before_action :set_subfolder, only: %i[show edit update destroy]
  before_action :parent, only: %i[index new create]
  before_action :subfolders, only: %i[index]
  before_action :presenter, only: %i[index]

  def index; end

  def show
    render :show, locals:
    {
      parent_relation_subfolders: parent_relation_subfolders,
      presenter: presenter
    }
  end

  def new
    @subfolder = Folders::Subfolder.new
    respond_with @subfolder, location: -> { new_subfolders_path(@parent.id, @subfolder) }
  end

  def edit; end

  def create
    @subfolder = Folders::Subfolder.new(params_subfolder)
    @subfolder.save
    respond_with @subfolder, location: -> { index_subfolders_path(@parent.id) }
  end

  def update
    @parent = @subfolder.parent
    @subfolder.update(name: params[:name])
    respond_with @subfolder, location: -> { index_subfolders_path(@parent.id) }
  end

  def destroy
    @parent = @subfolder.parent
    @subfolder.destroy
    respond_with @subfolder, location: -> { index_subfolders_path(@parent.id) }
  end

  private

  def set_subfolder
    @subfolder = Folders::Subfolder.find(params[:id])
  end

  def params_subfolder
    { name: params[:name], parent_id: params[:parent_id] }
  end

  def parent
    @parent = Folder.find params[:parent_id]
  end

  def subfolders
    @subfolders = FoldersQuery.new(parent_id: parent.id).by_parent
  end

  def parent_relation_subfolders
    return [] if params[:id].blank?

    @parent_relation_subfolders ||=
      ParentRelationQuery.new(parent_id: params[:id]).subfolders
  end

  def presenter
    @presenter ||= ::SubfolderPresenter.new
  end
end
