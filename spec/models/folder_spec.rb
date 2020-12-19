require 'rails_helper'

RSpec.describe Folder, type: :model do
  before(:each) do
    Folder.create(name: 'Contrato_X')
  end

  it 'Name attribute must not be valid if name already exists' do
    folder = Folder.new(name: 'Contrato_X')

    expect(folder).to_not be_valid
    expect(folder.errors[:name]).to include('has already been taken')
  end

  it 'Name attribute be valid if name not exists' do
    folder = Folder.new(name: 'Contrato_Y')

    expect(folder).to be_valid
  end
end
