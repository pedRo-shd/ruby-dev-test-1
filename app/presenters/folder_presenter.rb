class FolderPresenter
  def render_partial(view, folder)
    return render_partial_folders(view, folder) if folder.instance_of?(Folder)

    render_partial_assets(view, folder)
  end

  def render_partial_folders(view, folder)
    view.render partial: 'shared/folders', locals: {
      folder: folder
    }
  end

  def render_partial_assets(view, asset)
    view.render partial: 'shared/assets', locals: {
      asset: asset
    }
  end
end
