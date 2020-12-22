 require 'rails_helper'
RSpec.describe "/folders", type: :request do
  let(:valid_attributes) do
    { name: 'Contrato_Y' }
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Folder.create! valid_attributes
      get folders_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_folder_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      folder = Folder.create! valid_attributes
      get edit_folder_url(folder)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Folder" do
        expect {
          post folders_url, params: { folder: valid_attributes }
        }.to change(Folder, :count).by(1)
      end

      it "redirects to the created folder" do
        post folders_url, params: { folder: valid_attributes }
        expect(response).to redirect_to(folders_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Folder" do
        expect {
          post folders_url, params: { folder: invalid_attributes }
        }.to change(Folder, :count).by(0)
      end
    end

    context "when invalid parameters and json request" do
      it "has 422 status code" do
        post folders_url, params: { folder: invalid_attributes }, as: :json
        json_response = JSON.parse response.body
        expect(response.status).to eql 422
        expect(json_response['errors']['name'].first).to eql "can't be blank"
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Contrato_H' }
      }

      it "updates the requested folder" do
        folder = Folder.create! valid_attributes
        patch folder_url(folder), params: { folder: new_attributes }
        folder.reload
        expect(folder.name).to eql(new_attributes[:name])
      end

      it "redirects to the folders index" do
        folder = Folder.create! valid_attributes
        patch folder_url(folder), params: { folder: new_attributes }
        folder.reload
        expect(response).to redirect_to(folders_url)
      end
    end

    context "with invalid parameters" do
      it "with request json return status 422 and message error" do
        folder = Folder.create! valid_attributes
        patch folder_url(folder), params: { folder: invalid_attributes }
        expect(response).to be_successful
      end
    end

    context "when invalid parameters and json request" do
      it "has 422 status code" do
        post folders_url, params: { folder: invalid_attributes }, as: :json
        json_response = JSON.parse response.body
        expect(response.status).to eql 422
        expect(json_response['errors']['name'].first).to eql "can't be blank"
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested folder" do
      folder = Folder.create! valid_attributes
      expect {
        delete folder_url(folder)
      }.to change(Folder, :count).by(-1)
    end

    it "redirects to the folders list" do
      folder = Folder.create! valid_attributes
      delete folder_url(folder)
      expect(response).to redirect_to(folders_url)
    end

    context "when Folder has Folders::Subfolders" do
      let(:attributes_subfolder) do
        { name: 'Subfolder_A', parent_id: folder_a.id }
      end

      let(:folder_a) { create(:folder, name: 'Contrato_A') }

      it "must remove folder and subfolders" do
        Folders::Subfolder.create! attributes_subfolder
        expect(Folder.all.size).to eql(2)
        expect {
          delete folder_url(folder_a)
        }.to change(Folder, :count).by(-2)
      end
    end
  end
end
