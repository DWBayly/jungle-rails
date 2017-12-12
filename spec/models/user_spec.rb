require 'rails_helper'
require 'user'

RSpec.describe User, type: :model do
  subject {described_class.new}
  describe 'Validations ' do
    it "is valid with valid attributes" do
      puts subject.errors.full_messages
      subject.email = "dbayly@uvic.ca"
      subject.first_name = "David"
      subject.last_name = "Bayly"
      subject.password = "something"
      subject.password_confirmation = "something"
      expect(subject).to be_valid
      puts subject.errors.full_messages
    end
    it "is not valid without valid attributes" do
      expect(subject).to_not be_valid
      puts subject.errors.full_messages
    end
    it "Has password and password_confirmation must be equal" do
      subject.email = "dbayly@uvic.ca"
      subject.first_name = "David"
      subject.last_name = "Bayly"
      subject.password = "something"
      subject.password_confirmation = "somethingELSE"
      expect(subject).to_not be_valid
      puts subject.errors.full_messages
    end
    it "has password Length is 4 or greater" do
      subject.email = "dbayly@uvic.ca"
      subject.first_name = "David"
      subject.last_name = "Bayly"
      subject.password = "som"
      subject.password_confirmation = "som"
      expect(subject).to_not be_valid
      puts subject.errors.full_messages
    end
    it "Has a unique email" do
      @x = User.new(email: "dbayly@uvic.ca",first_name: "Imposter",last_name:"Bayly",password_confirmation:"faker",password:"faker")
      expect(@x.save).to be(true)
      subject.email = "DBAYLY@uvic.ca"
      subject.first_name = "David"
      subject.last_name = "Bayly"
      subject.password = "something"
      subject.password_confirmation = "something"
      expect(subject).to_not be_valid
      puts subject.errors.full_messages
    end
  end
  describe '.authenticate_with_credentials' do
    it "Logs in a user successfully" do
      subject.email = "dbayly@uvic.ca"
      subject.first_name = "David"
      subject.last_name = "Bayly"
      subject.password = "something"
      subject.password_confirmation = "something"
      expect(subject.save).to be(true)
      @user = User.authenticate_with_credentials(subject.email,subject.password)
      expect(@user).to_not be(nil)
      puts @user.errors.full_messages


    end
    it "Does not log in a user with invalid credentials" do
      @user = User.authenticate_with_credentials("test@test.com","broken")
      expect(@user).to be(nil)
    end
  end
  describe 'edge cases' do
    it  "Check to strip spaces before email address" do
      puts subject.errors.full_messages
      subject.email = "   dbayly@uvic.ca"
      subject.first_name = "David"
      subject.last_name = "Bayly"
      subject.password = "something"
      subject.password_confirmation = "something"
      expect(subject).to be_valid
      expect(subject.email == "dbayly@uvic.ca").to be(true)
      puts subject.errors.full_messages
    end
    it  "Check to see if cass sensitivity matters" do
      puts subject.errors.full_messages
      subject.email = "   dbayly@uvic.ca"
      subject.first_name = "David"
      subject.last_name = "Bayly"
      subject.password = "something"
      subject.password_confirmation = "something"
      expect(subject.save).to be(true)
      @user = User.authenticate_with_credentials("DbAyLy@UvIc.Ca","something")
      expect(@user).to_not be(nil)
    end
  end
end
