module Folders
  class Asset < Folder
    has_one_attached :file
  end
end
