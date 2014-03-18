class User < ActiveRecord::Base
  has_many  :posts
  has_many  :comments
  has_many  :comments, through: :posts


  # validates :username,  presence: true,
  #                       length: { minimum: 2, maximum: 30}
  # validates :email,     presence: true,
  #                       unique:   true,
  #                       #add regex to confirm email
  # validates :password,  presence: true,
  #                       length: { minimum: 6 }
end
