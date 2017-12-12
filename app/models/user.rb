class User < ActiveRecord::Base
  has_secure_password
  before_validation :strip_whitespace
  validates :email, uniqueness: true
  validates :email, uniqueness: {case_sensitive: false}
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :password ,length: {minimum: 4}
 def self.authenticate_with_credentials (email,pass)
     user = User.where("lower(email) =?",email.downcase).first
     if user && user.authenticate(pass)
        user
      else
        nil
      end
  end
  private
  def strip_whitespace
    self.email = self.email.strip unless self.email.nil?
  end
end