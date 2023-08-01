require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: 'test@example.com',
      password: 'password'
    )
  end

  test 'should be valid with valid attributes' do
    assert @user.valid?
  end

  test 'should not be valid without an email' do
    @user.email = nil
    assert_not @user.valid?
  end

  test 'should not be valid without a password' do
    @user.password = nil
    assert_not @user.valid?
  end

  test 'email should be unique' do
    @user.save
    duplicate_user = User.new(
      email: 'test@example.com',
      password: 'password123'
    )
    assert_not duplicate_user.valid?
  end

  test 'email should be in a valid format' do
    invalid_emails = ['testexample.com', 'test@', 'test.com']
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect} should be invalid"
    end
  end

  test 'password should have a minimum length' do
    @user.password = 'abc' # Set password less than 6 characters
    assert_not @user.valid?
  end

  test 'password should be encrypted and stored securely' do
    password = 'password123'
    @user.password = password
    @user.save

    assert_not_equal password, @user.encrypted_password
    assert @user.valid_password?(password)
  end
end