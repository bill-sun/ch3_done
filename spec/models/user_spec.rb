# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @attr = { :name => "Example User",
              :email => "user@example.com",
              :password => "foobar", #7.1.1 Password Validations
              :password_confirmation => "foobar" #7.1.1 Password Validations
            }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  # validate the presence of name(6.2.1)
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
    # no_name_user.valid?.should_not == true # this is equivilent with should_nt be_valid
  end

  # validate the presence of email addresses(6.2.1)
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid # equivalent with expect(actual).to_not be_valid
  end

  # 6.2.2 Length Validation
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    # long_name_user.should_not be_valid #obsoleted
    expect(long_name_user).to_not be_valid
  end

  # 6.2.3 Format Validation
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      expect(valid_email_user).to be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      expect(invalid_email_user).to_not be_valid
    end
  end

  # 6.2.4 Uniqueness Validation
  it "should reject duplicate email addresses" do
    # Put a user with given email address into the database.
    # User.create!(@attr)
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    expect(user_with_duplicate_email).to_not be_valid
  end

  # Following from 7.1.1 Password Validations
  describe "password validations" do

    it "should require a password" do
      expect(User.new(@attr.merge(:password => "", :password_confirmation => ""))).
        to_not be_valid
    end

    it "should require a matching password confirmation" do
      expect(User.new(@attr.merge(:password_confirmation => "invalid"))).
        to_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      expect(User.new(hash)).to_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      expect(User.new(hash)).to_not be_valid
    end
  end
  
  # 7.1.1 Password Validations
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    it "should have an encrypted password attribute" do
      expect(@user).to respond_to(:encrypted_password)
    end
    # 7.1.3 An Active Record Callback
    it "should set the encrypted password" do
      expect(@user.encrypted_password).to_not be_blank
    end

    # 7.2.1 A Secure Password Test
	describe "has_password? method" do
	  it "should be true if the passwords match" do
		expect(@user.has_password?(@attr[:password])).to be_truthy
	  end

	  it "should be false if the passwords don't match" do
		expect(@user.has_password?("invalid")).to be_falsey
	  end
	end

	describe "authenticate method" do
	  it "should return nil on email/password mismatch" do
		wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
		expect(wrong_password_user).to be_nil
	  end

	  it "should return nil for an email address with no user" do
		nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
		expect(nonexistent_user).to be_nil
	  end

	  it "should return the user on email/password match" do
		matching_user = User.authenticate(@attr[:email], @attr[:password])
		matching_user.should == @user
	  end
	end    
  end

  it "should require a name"
end
