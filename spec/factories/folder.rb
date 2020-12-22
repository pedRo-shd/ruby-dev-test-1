FactoryBot.define do
  factory :folder do
    name { FFaker::Name.unique.name }
  end
end
