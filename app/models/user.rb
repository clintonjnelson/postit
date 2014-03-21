class User < ActiveRecord::Base
  include SharedMethods

  has_secure_password  validations: false
  has_many  :posts
  has_many  :comments
  has_many  :comments, through: :posts
  has_many  :votes,         as: :votable


  # HOLD ON VALIDATIONS FOR NOW
  validates :username,  presence:     true,
                        length:     { minimum: 2, maximum: 30}
  validates :email,     presence:     true,
                        uniqueness:   true#,
  #                       #add regex to confirm email

  #This is a virtual attribute that works with password digest
  validates :password,  presence:     true,
                        length:     { minimum: 6 },
                        confirmation: true,
                        on: :create
  validates :password,  presence:     true,
                        length:     { minimum: 6 },
                        confirmation: true,
                        on: :update,
                        allow_blank: true
end
