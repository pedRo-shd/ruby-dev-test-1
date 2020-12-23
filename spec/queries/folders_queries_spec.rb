require 'rails_helper'

RSpec.describe FoldersQuery do
  let(:folders_Query_all) do
    described_class.new.all
  end

   before(:each) do
     @folder_one = create(:folder, name: 'Contrato_One')
     @folder_two = create(:folder, name: 'Contrato_Two')
     @subfolder_one = Folders::Subfolder.create!(name: 'Subfolder_One', parent_id: @folder_one.id)
   end

  it "returns only folders" do
    expect(folders_Query_all.size).to eql(2)
    expect(folders_Query_all.first.name).to eql(@folder_one.name)
    expect(folders_Query_all.first.parent_id).to eql(nil)
    expect(folders_Query_all.last.name).to eql(@folder_two.name)
    expect(folders_Query_all.last.parent_id).to eql(nil)
  end
end
