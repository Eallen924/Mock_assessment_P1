class User < ActiveRecord::Base
  validates :name, :length => { :minimum => 3, :message => "must be at least 3 characters, fool!" }
  validates :entered_password, :length => { :minimum => 6 }, :allow_blank => true
  validates :email, :uniqueness => true, :format => /.+@.+\..+/ # imperfect, but okay

  has_many :skills, :through => :proficiencies
  has_many :proficiencies

  attr_accessor :entered_password, :entered_password_confirmation, :old_password

  validate :validate_updated_password, :on => :update
  after_validation :set_new_password

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    # @entered_password = pass
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil # either invalid email or wrong password
  end

  def validate_updated_password
    if old_password || entered_password || entered_password_confirmation
      errors.add(:old_password, "Current password does not match") unless password == old_password
      errors.add(:entered_password, "New Password Does Not Match") unless entered_password == entered_password_confirmation
    end
  end

  def set_new_password
    self.password = entered_password if entered_password && entered_password.length > 0
  end
end
