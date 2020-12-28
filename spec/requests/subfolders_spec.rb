 require 'rails_helper'

RSpec.describe "/subfolders", type: :request do
  let(:folder) do
    create(:folder, name: 'Contrato_A', parents_path: [folders_path])
  end

  let(:folder_two) do
    create(:folder, name: 'Contrato_B')
  end

  let(:valid_attributes) do
    { name: 'Subfolder_A', parent_id: folder.id }
  end

  let(:invalid_attributes) do
    { name: nil, parent_id: folder.id }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Folders::Subfolder.create! valid_attributes
      get index_subfolders_path(folder.id)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      subfolder = Folders::Subfolder.create! valid_attributes
      get subfolder_url(subfolder)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_subfolders_path(folder.id)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      subfolder = Folders::Subfolder.create! valid_attributes
      get edit_subfolder_url(subfolder)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Subfolder" do
        expect {
          post "/#{folder.id}/subfolders", params: valid_attributes
        }.to change(Folders::Subfolder, :count).by(1)
      end

      it "redirects to the subfolders index" do
        post "/#{folder.id}/subfolders", params: valid_attributes
        expect(response).to redirect_to(index_subfolders_path(folder.id))
      end

      it "creates a new Subfolder with parents path" do
        post "/#{folder.id}/subfolders", params: valid_attributes
        subfolder_last = Folders::Subfolder.last
        expect(
          subfolder_last.parents_path
        ).to eql(
          {
            'Contrato_A' => '/1/subfolders/index',
            'Subfolder_A' => '/2/subfolders/index'
          }
        )
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'new' template)" do
        post "/#{folder.id}/subfolders", params: invalid_attributes
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'Subfolder_H', parent_id: folder.id }
      }

      it "updates the requested subfolder" do
        subfolder = Folders::Subfolder.create! valid_attributes
        patch subfolder_url(subfolder), params: new_attributes
        subfolder.reload
        expect(subfolder.name).to eql(new_attributes[:name])
      end

      it "redirects to the subfolder" do
        subfolder = Folders::Subfolder.create! valid_attributes
        patch subfolder_url(subfolder), params: valid_attributes
        subfolder.reload
        expect(response).to redirect_to(index_subfolders_path(folder.id))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        subfolder = Folders::Subfolder.create! valid_attributes
        patch subfolder_url(subfolder), params: invalid_attributes
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested subfolder" do
      subfolder = Folders::Subfolder.create! valid_attributes
      expect {
        delete subfolder_url(subfolder)
      }.to change(Folders::Subfolder, :count).by(-1)
    end
  #
    it "redirects to the subfolders list" do
      subfolder = Folders::Subfolder.create! valid_attributes
      delete subfolder_url(subfolder)
      expect(response).to redirect_to(index_subfolders_path(folder.id))
    end
  end
end
