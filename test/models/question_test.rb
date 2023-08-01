require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @survey = surveys(:one)
  end

  test 'should be valid with valid attributes' do
    question = Question.new(
      question: 'Example Question 123',
      survey_id: @survey.id,
      question_types_id: 'open_answer'
    )
    assert question.valid?
  end

  test 'should not be valid without a question' do
    question = Question.new(
      survey_id: @survey.id,
      question_types_id: 'closed_answer'
    )
    assert_not question.valid?
  end

  test 'should not be valid without a survey_id' do
    question = Question.new(
      question: 'Example Question',
      question_types_id: 'true_false'
    )
    assert_not question.valid?
  end

  test 'should not be valid without a question_types_id' do
    question = Question.new(
      question: 'Example Question',
      survey_id: @survey.id
    )
    assert_not question.valid?
  end

  test 'should not be valid without exactly 4 options as strings for closed_answer' do
    question = Question.new(
      question: 'Example Question',
      survey_id: @survey.id,
      question_types_id: 'closed_answer',
      options: ['Option 1', 'Option 2', 'Option 3']
    )
    assert_not question.valid?
  end

  test 'should be valid with exactly 4 options as strings for closed_answer' do
    question = Question.new(
      question: 'Example Closed Question',
      survey_id: @survey.id,
      question_types_id: 'closed_answer',
      options: ['Option 1', 'Option 2', 'Option 3', 'Option 4']
    )
    assert question.valid?
  end
end
