require 'rails_helper'

RSpec.describe "UploadFiles", type: :request do
  include ActionDispatch::TestProcess

  let(:folder) { create(:folder, name: 'Contrato_A') }

  let(:subfolder) do
    Folders::Subfolder.create(name: 'Contrato_A', parent_id: folder.id)
  end

  let(:file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'curriculo.pdf'), 'application/pdf') }

  describe "POST /create" do
    context "when upload file into a folder" do
      it "returns to subfolders" do
        post upload_files_path(id: folder.id), params: { file: file }
        expect(response).to redirect_to(index_subfolders_path(folder))
      end

      it "must create file attachment to folder" do
        expect {
          post upload_files_path(id: folder.id), params: { file: file }
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end

      it "must create object Asset" do
        post upload_files_path(id: folder.id), params: { file: file }
        expect(Folder.last.class.name).to eql('Folders::Asset')
      end

      it "Asset must belongs to the folder id passed in the params" do
        post upload_files_path(id: folder.id), params: { file: file }
        expect(Folder.last.parent_id).to eql(folder.id)
      end
    end

    context "when upload file into a subfolder" do
      it "returns to subfolder" do
        post upload_files_path(id: subfolder.id), params: { file: file }
        expect(response).to redirect_to(subfolder_path(subfolder))
      end

      it "must create file attachment to subfolder" do
        expect {
          post upload_files_path(id: subfolder.id), params: { file: file }
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end

      it "must create object Asset" do
        post upload_files_path(id: subfolder.id), params: { file: file }
        expect(Folder.last.class.name).to eql('Folders::Asset')
      end

      it "Asset must belongs to the subfolder id passed in the params" do
        post upload_files_path(id: subfolder.id), params: { file: file }
        expect(Folder.last.parent_id).to eql(subfolder.id)
      end
    end

    context "when upload file fromt root path without belongs to any folder or subfolder" do
      it "returns to root path" do
        post upload_files_path, params: { file: file }
        expect(response).to redirect_to(folders_path)
      end

      it "must create file attachment" do
        expect {
          post upload_files_path, params: { file: file }
        }.to change(ActiveStorage::Attachment, :count).by(1)
      end
    end
  end

  describe "DELETE /destroy" do
    before(:each) do
      asset
      asset.file.attach file
    end

    let(:asset) { Folders::Asset.create(name: file.original_filename) }

    context "when folder is type Asset from without parent id" do
      it "returns to folders index" do
        delete upload_file_path(id: asset)
        expect(response).to redirect_to(folders_path)
      end

      it "destroys the requested folder" do
        expect {
          delete upload_file_path(id: asset)
        }.to change(Folders::Asset, :count).by(-1)
      end

      it "destroys the requested file" do
        expect {
          delete upload_file_path(id: asset)
        }.to change(ActiveStorage::Attachment, :count).by(-1)
      end
    end

    context "when folder is type Asset with parent id folder" do
      before(:each) do
        asset.update(parent_id: folder.id)
      end

      it "returns to folder" do
        delete upload_file_path(id: asset)
        expect(response).to redirect_to(index_subfolders_path(folder))
      end

      it "destroys the requested folder" do
        expect {
          delete upload_file_path(id: asset)
        }.to change(Folders::Asset, :count).by(-1)
      end

      it "destroys the requested file" do
        expect {
          delete upload_file_path(id: asset)
        }.to change(ActiveStorage::Attachment, :count).by(-1)
      end
    end

    context "when folder is type Asset with parent id subfolder" do
      before(:each) do
        asset.update(parent_id: subfolder.id)
      end

      it "returns to subfolder" do
        delete upload_file_path(id: asset)
        expect(response).to redirect_to(subfolder_path(subfolder))
      end

      it "destroys the requested folder" do
        expect {
          delete upload_file_path(id: asset)
        }.to change(Folders::Asset, :count).by(-1)
      end

      it "destroys the requested file" do
        expect {
          delete upload_file_path(id: asset)
        }.to change(ActiveStorage::Attachment, :count).by(-1)
      end
    end
  end
end
