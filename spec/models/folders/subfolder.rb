require 'rails_helper'

RSpec.describe Folders::Subfolder, type: :model do
  before(:each) do
    described_class.create(name: 'Subfolder_X', parent_id: folder.id)
  end
  let(:folder) { create(:folder, name: 'Contrato_X') }
  let(:folder_two) { create(:folder, name: 'Contrato_A') }

  it 'Name attribute must not be valid if name already exists' do
    subfolder = described_class.new(name: 'Subfolder_X', parent_id: folder.id)

    expect(subfolder).to_not be_valid
    expect(subfolder.errors[:name]).to include('has already been taken')
  end

  it 'Name attribute be valid if name not exists' do
    subfolder = described_class.new(name: 'Subfolder_Y', parent_id: folder.id)

    expect(subfolder).to be_valid
  end

  context "when already have that subfolder name in another folder" do
    it "Name attribute must be valid" do
      subfolder = described_class.new(name: 'Subfolder_X', parent_id: folder_two.id)
      expect(subfolder).to be_valid
    end
  end

  context "when create subfolder of the parent subfolder" do
    it "must create subfolder of the parent subfolder id" do
      parent_subfolder = described_class.create(name: 'Subfolder_A', parent_id: folder.id)
      subfolder = described_class.new(name: 'Subfolder_X', parent_id: parent_subfolder.id)
      expect(subfolder).to be_valid
    end
  end
end
