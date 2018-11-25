# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "thing_#{n}"
  end

  factory :column do
    name
    board
  end
end
