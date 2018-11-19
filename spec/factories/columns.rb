# frozen_string_literal: true

FactoryBot.define do
  factory :column do
    name { 'MyString' }
    board
  end
end
