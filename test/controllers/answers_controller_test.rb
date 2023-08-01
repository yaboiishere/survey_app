require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @user = users(:one)
    @survey = surveys(:two)
    @question1 = questions(:six)
    @question2 = questions(:seven)
  end

  test 'should create answers while if all questions are answered' do
    sign_in @user

    assert_difference('Answer.count', 2) do
      post :create, params: {
        survey_id: @survey.id,
        survey: {
          questions_attributes: {
            '0' => { question_id: @survey.questions.first.id, answer: 'Answer 1' },
            '1' => { question_id: @survey.questions.second.id, answer: 'Answer 2' }
          }
        }
      }
    end

    assert_redirected_to root_path
    assert_equal 'Survey completed!', flash[:notice]
  end

  test 'should render surveys/fill_out template with status :unprocessable_entity if not all questions are answered' do
    sign_in @user

    assert_no_difference('Answer.count') do
      post :create, params: {
        survey_id: @survey.id,
        survey: {
          questions_attributes: {
            '0' => { question_id: @question1.id, answer: 'Answer 1' },
            '1' => { question_id: @question2.id, answer: nil } # Missing answer for question2
          }
        }
      }
    end

    assert_template 'surveys/fill_out'
    assert_response :unprocessable_entity
  end
end
