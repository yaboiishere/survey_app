class Question < ApplicationRecord
  serialize :options, Array

  belongs_to :survey, required: true

  after_initialize do |question|
    question.options = [] unless question.options
  end
end
