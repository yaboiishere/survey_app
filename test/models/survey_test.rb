require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  def setup
    @user = users(:one) # Using the fixture users(:one)
    @survey = Survey.new(
      title: 'Example Survey',
      user: @user
    )
  end

  test 'should be valid with valid attributes' do
    # Create at least one valid question and associate it with the survey
    @survey.questions.build(question: 'Sample Question', question_types_id: 'open_answer')

    assert @survey.valid?
  end

  test 'should not be valid without a title' do
    @survey.title = nil
    assert_not @survey.valid?
  end

  test 'should not be valid without questions' do
    @survey.questions = [] # Empty questions array
    assert_not @survey.valid?
  end

  test 'should be able to save nested questions' do
    assert_difference('Question.count', 3) do
      @survey.questions_attributes = [
        { question: 'Question 1', question_types_id: 'open_answer' },
        { question: 'Question 2', question_types_id: 'closed_answer', options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'] },
        { question: 'Question 3', question_types_id: 'true_false' }
      ]
      assert @survey.save
    end
  end

  test 'should be able to destroy nested questions individually' do
    question1 = questions(:one) # Using the fixture questions(:one)
    question2 = questions(:two) # Using the fixture questions(:two)
    question3 = questions(:three) # Using the fixture questions(:three)

    @survey.questions << question1
    @survey.questions << question2
    @survey.questions << question3

    assert_difference('Question.count', -1) do
      @survey.questions_attributes = [
        { id: question1.id, _destroy: '1' }
      ]
      assert @survey.save
    end

    assert_nil Question.find_by(id: question1.id)
    assert_not_nil Question.find_by(id: question2.id)
    assert_not_nil Question.find_by(id: question3.id)
  end

  test 'should not be able to destroy all nested questions at once' do
    question1 = questions(:one) # Using the fixture questions(:one)
    question2 = questions(:two) # Using the fixture questions(:two)
    question3 = questions(:three) # Using the fixture questions(:three)

    @survey.questions << question1
    @survey.questions << question2
    @survey.questions << question3

    assert_no_difference('Question.count') do
      @survey.questions_attributes = [
        { id: question1.id, _destroy: '1' },
        { id: question2.id, _destroy: '1' },
        { id: question3.id, _destroy: '1' }
      ]
      assert_not @survey.save
    end

    assert_not_nil Question.find_by(id: question1.id)
    assert_not_nil Question.find_by(id: question2.id)
    assert_not_nil Question.find_by(id: question3.id)
  end

  test 'should be able to update nested questions' do
    question1 = questions(:one) # Using the fixture questions(:one)

    @survey.questions << question1

    assert_difference('Question.count', 0) do
      @survey.questions_attributes = [
        { id: question1.id, question: 'Updated Question 1', question_types_id: 'open_answer' }
      ]
      assert @survey.save
    end

    assert_equal 'Updated Question 1', Question.find_by(id: question1.id).question
  end
end
