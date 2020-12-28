require 'rails_helper'

RSpec.describe FoldersQuery do
  let(:folders_query_all) do
    described_class.new.all
  end

   before(:each) do
     @folder_one = create(:folder, name: 'Contrato_One')
     @folder_two = create(:folder, name: 'Contrato_Two')
     @subfolder_one = Folders::Subfolder.create!(name: 'Subfolder_One', parent_id: @folder_one.id)
   end

  it "returns only folders" do
    expect(folders_query_all.size).to eql(2)
    expect(folders_query_all.first.name).to eql(@folder_one.name)
    expect(folders_query_all.first.parent_id).to eql(nil)
    expect(folders_query_all.last.name).to eql(@folder_one.name)
    expect(folders_query_all.last.parent_id).to eql(nil)
  end

  context "when query by parent" do
    let(:folder_one) do
      create(:folder, name: 'Contrato_A')
    end

    let(:folder_two) do
      create(:folder, name: 'Contrato_B')
    end

    let(:by_parent_one) do
      described_class.new(parent_id: folder_one.id).by_parent
    end

    let(:by_parent_two) do
      described_class.new(parent_id: folder_two.id).by_parent
    end

     before(:each) do
       @subfolder_one = Folders::Subfolder.create!(name: 'Subfolder_A', parent_id: folder_one.id)
       @subfolder_two = Folders::Subfolder.create!(name: 'Subfolder_B', parent_id: folder_one.id)
       @subfolder_three = Folders::Subfolder.create!(name: 'Subfolder_A', parent_id: folder_two.id)
     end

    it "returns subfolders of the folder_one" do
      expect(by_parent_one.size).to eql(2)
      expect(by_parent_one[0].name).to eql(@subfolder_one.name)
      expect(by_parent_one[1].name).to eql(@subfolder_two.name)
      expect(by_parent_one.first.parent_id).to eql(@subfolder_one.parent_id)
      expect(by_parent_one.last.parent_id).to eql(@subfolder_two.parent_id)
    end

    it "returns subfolders of the two" do
      expect(by_parent_two.size).to eql(1)
      expect(by_parent_two.first.name).to eql(@subfolder_three.name)
      expect(by_parent_two.first.parent_id).to eql(@subfolder_three.parent_id)
    end
  end
end
