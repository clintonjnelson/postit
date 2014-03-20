class User < ActiveRecord::Base
  has_secure_password  validations: false
  has_many  :posts
  has_many  :comments
  has_many  :comments, through: :posts


  # HOLD ON VALIDATIONS FOR NOW
  validates :username,  presence:     true,
                        length:     { minimum: 2, maximum: 30}
  validates :email,     presence:     true,
                        uniqueness:   true#,
  #                       #add regex to confirm email

  #This is a virtual attribute that works with password digest
  validates :password,  presence:     true,
                        length:     { minimum: 6 },
                        on: :create
  #                       confirmation: true

  private
  # def format_email(email)
  #   email.downcase
  # end
end
