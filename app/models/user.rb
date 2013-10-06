# encoding: utf-8
class User < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me,
    :confirmed_at, :doorkeeper_access_token, :doorkeeper_uid, :image, :mobile, :login,
    :is_auth_for_mobile, :reset_password_token_for_mobile, :reset_password_sent_at_for_mobile,
    :sex, :province_id, :city_id, :community_id, :consignees_attributes

  attr_accessible :role, :as => "admin"
  attr_accessor :image_data, :login, :current_password, :in_password

  # relationships .............................................................
  has_many :rates, dependent: :destroy

  has_many :favors
  has_many :consignees

  # constants definition ......................................................
  # validations ...............................................................
  validates :name, presence: true, length:
    {minimum: 6, maximum: 12, message: '长度为6-12个字符！不能包含空格'}
  validates :name, :uniqueness=>{:message => "用户已经注册"}
  #validates :mobile, :presence => true#, :uniqueness => true#, :numericality => { :only_integer => true }
  # validates :password, :presence => { :message => "请输入密码" }
  # validates_confirmation_of :password, :message => "重复密码"

  validates :current_password, :presence => true, :user_attribute => true#, :if => :in_password
  validates :password, presence: true, allow_blank: false, length:
    {minimum: 6, maximum: 12, message: '长度为6-12个字符！不能包含空格'}#, :if => :in_password
  validates :password, confirmation: true#, :if => :in_password
  validates :password_confirmation, presence: true#, :if => :in_password

  # callbacks .................................................................
  # scopes ....................................................................

  # additional config .........................................................
  rolify
  mount_uploader :image, UserImageUploader
  accepts_nested_attributes_for :consignees, :allow_destroy => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable,:omniauthable, :authentication_keys =>[ :login ]
  #, :token_authenticatable

  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
  # Setup accessible (or protected) attributes for your model

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value OR lower(mobile) =:value ", { :value => login }]).first
    else
      where(conditions).first
    end
  end

  def role
    self.roles.pluck(:name).first
  end

  def role=(value)
    self.remove_role role
    self.add_role value
  end

  ROLES = [{ :admin => "超级管理员" }, { :editor => "编辑" }]

  def self.find_or_create_for_doorkeeper_oauth(oauth_data)
    # User.find_or_initialize_by_doorkeeper_uid(oauth_data.uid).tap do |user|
      # user.email = oauth_data.info.email
    # end
    user = User.where(:doorkeeper_uid => oauth_data.uid).first
    # p user
    if user.nil?
      user = User.create! :email => oauth_data.info.email, :password => 'woaixuexi', :password_confirmation => 'woaixuexi', :confirmed_at => DateTime.now,:doorkeeper_access_token => oauth_data.credentials.token,:doorkeeper_uid => oauth_data.uid
    else
      user = User.update(user.id,:doorkeeper_access_token => oauth_data.credentials.token)
    end
    return user
  end

  def self.generate_password_token
    [*'a'..'z',*'1'..'9'].sample(4).join
  end

  def read_notifications
    Notification.where(:receiver => self.id, :is_read => true)
  end

  def not_read_notifications
     Notification.where(:receiver => self.id, :is_read => false )
  end

  def own_sent_notifications
    Notification.where(:sender => self.id)
  end

  def is_auth?(mobile)
    user = User.where(:id => self.id, :mobile => mobile).order("created_at DESC").first
    user.nil? ? false : user.is_auth_for_mobile
  end
end
