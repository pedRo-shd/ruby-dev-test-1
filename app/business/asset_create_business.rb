class AssetCreateBusiness
  def initialize(options)
    @folder = options.fetch(:folder, nil)
    @file = options.fetch(:file)
  end

  def save
    ActiveRecord::Base.transaction do
      asset.save
      asset_file_attach
    end
  end

  private

  attr_accessor :folder, :file

  delegate :original_filename, to: :file
  delegate :id, to: :folder, allow_nil: true, prefix: true

  def asset
    @asset ||=
      Folders::Asset.new(name: original_filename, parent_id: folder_id)
  end

  def asset_file_attach
    asset.file.attach file
  end
end
