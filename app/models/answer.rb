class Answer < ApplicationRecord
  belongs_to :question

  validates :answer, :question_id, presence: true
  # validates :answer, uniqueness: { scope: :question_id }

end
