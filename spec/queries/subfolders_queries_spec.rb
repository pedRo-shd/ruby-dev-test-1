require 'rails_helper'

RSpec.describe SubfoldersQueries do
  let(:folder_one) do
    create(:folder, name: 'Contrato_One')
  end

  let(:folder_two) do
    create(:folder, name: 'Contrato_Two')
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
    expect(by_parent_one.first.name).to eql(@subfolder_one.name)
    expect(by_parent_one.last.name).to eql(@subfolder_two.name)
    expect(by_parent_one.first.parent_id).to eql(@subfolder_one.parent_id)
    expect(by_parent_one.first.parent_id).to eql(@subfolder_two.parent_id)
  end

  it "returns subfolders of the two" do
    expect(by_parent_two.size).to eql(1)
    expect(by_parent_two.first.name).to eql(@subfolder_three.name)
    expect(by_parent_two.first.parent_id).to eql(@subfolder_three.parent_id)
  end
end
