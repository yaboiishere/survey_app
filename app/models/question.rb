class Question < ApplicationRecord
  validates :question, :question_types_id, presence: true
  validates :survey_id, uniqueness: { scope: :question, message: 'already exists' }
  validate :validate_options_for_closed_answer
  serialize :options, Array

  attribute :answer, :string
  belongs_to :survey, required: true
  belongs_to :question_type, foreign_key: :question_types_id, primary_key: 'name', required: true

  has_many :answers, dependent: :destroy

  private

  def validate_options_for_closed_answer
    if question_types_id == 'closed_answer'
      if !options.is_a?(Array) || options.length != 4 || options.any? { |option| !option.is_a?(String) || option.blank? }
        errors.add(:options, 'Options must be an exactly 4 non-empty fields for closed answer questions.')
      end
    elsif options != []
      errors.add(:options, 'Options should not be present for non-closed answer questions.')
    end
  end
end
