class QuestionType < ApplicationRecord
  validates :name, :display_name, presence: true
  validates :name, uniqueness: true
end
