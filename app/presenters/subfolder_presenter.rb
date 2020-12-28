class SubfolderPresenter
  def render_partial(view, folder)
    return render_partial_subfolders(view, folder) if folder.instance_of?(Folders::Subfolder)

    render_partial_assets(view, folder)
  end

  def render_partial_subfolders(view, folder)
    view.render partial: 'shared/subfolders', locals: {
      folder: folder
    }
  end

  def render_partial_assets(view, asset)
    view.render partial: 'shared/assets', locals: {
      asset: asset
    }
  end

  def render_partial_breadcrumb_root(view)
    view.render partial: 'shared/breadcrumbs/folders'
  end

  def render_partial_breadcrumb_subfolder(view, parents_path)
    view.render partial: 'shared/breadcrumbs/subfolders', locals: {
      parents_path: parents_path
    }
  end
end
