require 'test_helper'

class QuestionTypeTest < ActiveSupport::TestCase
  class QuestionTypeTest < ActiveSupport::TestCase
    def setup
      # Using the 'unknown' question_type
      @question_type = QuestionType.new(
        name: 'unknown',
        display_name: 'Unknown Type'
      )
    end

    test 'should be valid with valid attributes' do
      assert @question_type.valid?
    end

    test 'should not be valid without a name' do
      @question_type.name = nil
      assert_not @question_type.valid?
    end

    test 'should not be valid without a display_name' do
      @question_type.display_name = nil
      assert_not @question_type.valid?
    end

    test 'name should be unique' do
      @question_type.save
      duplicate_type = QuestionType.new(
        name: 'unknown',
        display_name: 'Unknown Type Duplicate'
      )
      assert_not duplicate_type.valid?
    end
  end
end