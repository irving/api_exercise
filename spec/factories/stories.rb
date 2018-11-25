FactoryBot.define do
  factory :story do
    name { "the name" }
    description { "the description" }
    column
    due_date { Time.zone.now + 10.days }
    status { "open" }
  end
end
