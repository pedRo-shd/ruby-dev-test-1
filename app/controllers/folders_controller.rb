class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  # GET /folders
  # GET /folders.json
  def index
    @folders = Folder.all
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
  end

  # GET /folders/new
  def new
    @folder = Folder.new
  end

  # GET /folders/1/edit
  def edit
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params)
    @folder.save
    respond_with @folder
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    @folder.update(folder_params)
    respond_with @folder
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder.destroy
    respond_with @folder
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def folder_params
      params.require(:folder).permit(:name)
    end
end
