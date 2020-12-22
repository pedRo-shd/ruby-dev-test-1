require 'rails_helper'

RSpec.describe Subfolder, type: :model do
  before(:each) do
    Subfolder.create(name: 'Subfolder_X', folder: folder)
  end
  let(:folder) { create(:folder, name: 'Contrato_X') }
  let(:folder_two) { create(:folder, name: 'Contrato_A') }

  it 'Name attribute must not be valid if name already exists' do
    subfolder = Subfolder.new(name: 'Subfolder_X', folder: folder)

    expect(subfolder).to_not be_valid
    expect(subfolder.errors[:name]).to include('has already been taken')
  end

  it 'Name attribute be valid if name not exists' do
    subfolder = Subfolder.new(name: 'Subfolder_Y', folder: folder)

    expect(subfolder).to be_valid
  end

  context "when already have that subfolder name in another folder" do
    it "Name attribute must be valid" do
      subfolder = Subfolder.new(name: 'Subfolder_X', folder: folder_two)
      expect(subfolder).to be_valid
    end
  end
end
