# frozen_string_literal: true

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    @question = questions(:one)
    @answer = Answer.new(
      question: @question,
      answer: 'Example Answer',
      count: 2
    )
  end

  test 'should be valid with valid attributes' do
    assert @answer.valid?
  end

  test 'should not be valid without an answer' do
    @answer.answer = nil
    assert_not @answer.valid?
  end

  test 'should not be valid without a question_id' do
    @answer.question = nil
    assert_not @answer.valid?
  end

  test 'should validate uniqueness of answer within the same question' do
    @answer.save
    duplicate_answer = @answer.dup
    assert_not duplicate_answer.valid?
    assert_equal ['has already been taken'], duplicate_answer.errors[:answer]
  end

  test 'should be valid with the same answer in different questions' do
    @answer.save
    new_question = questions(:two)
    new_answer = Answer.new(
      question: new_question,
      answer: @answer.answer,
      count: 3
    )
    assert new_answer.valid?
  end

  test 'should be valid with a count greater than 0' do
    @answer.count = 1
    assert @answer.valid?

    @answer.count = 0
    assert_not @answer.valid?

    @answer.count = -1
    assert_not @answer.valid?
  end

  test 'should belong to a question' do
    assert_instance_of Question, @answer.question
  end
end