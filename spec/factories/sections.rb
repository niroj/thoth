FactoryGirl.define do
  factory :section do
    section_type "H1"
    association :webpage, factory: :webpage, strategy: :create
    content "MyText"
  end
end
