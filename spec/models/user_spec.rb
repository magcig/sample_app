require 'spec_helper'

describe User do
  before(:each) do
    @attributes = {
      :name => "Example User",
      :email => "user@example.com"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attributes)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attributes.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attributes.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are toot long" do
    long_name = "a" * 51
    long_name_user = User.new(@attributes.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attributes.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo]
    addresses.each do |address|
      invalid_email_user = User.new(@attributes.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    # Put a user with given email address into the database.
    User.create!(@attributes)
    user_with_duplicate_email = User.new(@attributes)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attributes[:email].upcase
    User.create!(@attributes.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attributes)
    user_with_duplicate_email.should_not be_valid
  end
end
