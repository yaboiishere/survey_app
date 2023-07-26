class QuestionType < ApplicationRecord
  validates :name, :display_name, presence: true
end
