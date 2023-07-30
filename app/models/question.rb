class Question < ApplicationRecord
  validates :question, :question_types_id, presence: true
  validates :survey_id, uniqueness: { scope: :question, message: 'already exists' }
  serialize :options, Array

  belongs_to :survey
  belongs_to :question_type, foreign_key: :question_types_id, primary_key: "name", required: true

  has_many :answers, dependent: :destroy

  after_initialize do |question|
    question.options = [] unless question.options
  end
end
