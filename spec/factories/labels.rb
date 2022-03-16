FactoryBot.define do
  factory :label do
    name { "label" }
  end

  factory :label2, class: Label do
    name { 'label2' }
  end

end