class Question < ApplicationRecord
  serialize :options, Array

  belongs_to :survey
  has_one :question_types

  after_initialize do |question|
    question.options = [] unless question.options
  end
end
