class User < ActiveRecord::Base
  include SluggableCjn

  sluggable_column :username

  has_secure_password  validations: false
  has_many  :posts
  has_many  :comments
  has_many  :comments, through: :posts
  has_many  :votes,         as: :votable


  validates :username,  presence:     true,
                        length:     { minimum: 2, maximum: 30},
                        case_sensitive: false,
                        uniqueness: true
  validates :email,     presence:     true,
                        uniqueness:   true#,
                        #add regex to confirm email
  validates :phone,     length: { minimum: 10, maximum: 10},
                        numericality: { only_integer: true },
                        allow_blank: true
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

  #validate_inclusion_of :timezone, in:

  def two_factor_auth?
    !self.phone.empty?
  end

  def generate_twofactor_pin!
    self.update_column(:pin, Random.new.rand(10**6).to_s.ljust(6, '79'))
  end

  def remove_twofactor_pin!
    self.update_column(:pin, nil)
  end
end
