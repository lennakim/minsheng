# encoding: utf-8
class User < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at
  attr_accessible :role, :as => "admin"
  # relationships .............................................................
  has_many :rates, dependent: :destroy

  # constants definition ......................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................

  # additional config .........................................................
  rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable,:omniauthable
  #, :token_authenticatable

  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
  # Setup accessible (or protected) attributes for your model

  def role
    self.roles.pluck(:name).first
  end

  def role=(value)
    self.remove_role role
    self.add_role value
  end

  ROLES = [{ :admin => "超级管理员" }, { :editor => "编辑" }]

  def self.find_or_create_for_doorkeeper_oauth(oauth_data)
    User.find_or_initialize_by_doorkeeper_uid(oauth_data.uid).tap do |user|
      user.email = oauth_data.info.email
    end
  end

  def update_doorkeeper_credentials(oauth_data)
    self.doorkeeper_access_token = oauth_data.credentials.token 
  end

end
