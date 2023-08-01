require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @user = users(:one)
    @survey = surveys(:one)

    @survey_params = {
      survey: {
        title: 'New Survey',
        user_id: @user.id,
        questions_attributes: [
          { question: 'Question 1', question_types_id: 'open_answer' },
          { question: 'Question 2', question_types_id: 'closed_answer', options: ['Option 1', 'Option 2', 'Option 3', 'Option 4'] }
        ]
      }
    }
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  test 'should show survey' do
    sign_in @user
    get :show, params: { id: @survey[:id] }

    assert_response :success
  end

  test 'should get fill_out without authentication' do
    get :fill_out, params: { survey_id: @survey[:id] }
    assert_response :success
  end

  test 'should get fill_out with authentication' do
    sign_in @user
    get :fill_out, params: { survey_id: @survey[:id] }
    assert_response :success
  end

  test 'should get new' do
    sign_in @user
    get :new
    assert_response :success
  end

  test 'should create survey with questions' do
    sign_in @user

    assert_difference({ 'Survey.count' => 1, 'Question.count' => 2 },) do
      post :create, params: @survey_params
    end

    assert_redirected_to survey_url(assigns(:survey))
  end

  test 'should not create survey without questions' do
    sign_in @user

    assert_no_difference(['Survey.count', 'Question.count']) do
      post :create, params: {
        survey: {
          title: 'Empty Survey',
          user_id: @user.id
        }
      }
    end

    assert_template :new
  end

  test 'should get edit' do
    sign_in @user
    get :edit, params: { id: @survey }
    assert_response :success
  end

  test 'should update survey' do
    sign_in @user
    patch :update, params: { id: @survey, survey: { title: 'Updated Survey' } }
    assert_redirected_to survey_url(assigns(:survey))
    @survey.reload
    assert_equal 'Updated Survey', @survey.title
  end

  test 'should destroy survey' do
    sign_in @user
    assert_difference('Survey.count', -1) do
      delete :destroy, params: { id: @survey }
    end
    assert_redirected_to surveys_url
  end
end
