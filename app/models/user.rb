class User < ActiveRecord::Base
  extend OmniauthCallbacks

  has_and_belongs_to_many :bookmarks
  has_and_belongs_to_many :tags

  has_many :votes
  has_many :authorizations

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  before_save :ensure_authentication_token



  def self.find_or_create_from_facebook_profile(profile)
    uid = profile["id"]
    email = profile["email"]
    if uid && email
      if @user = User.find_by_email(email)
        if authorization = @user.authorizations.find_by_provider(:facebook)
        else
          @user.authorizations << Authorization.new(:provider => :facebook, :uid => uid)
        end
      else
        @user = User.create(:email => email, :password => Devise.friendly_token[0, 20])
        @user.authorizations << Authorization.new(:provider => :facebook, :uid => uid)
      end
      @user
    else
      false
    end
  end

  def facebook
    authorizations.find_by_provider(:facebook)
  end

  def evernote
    authorizations.find_by_provider(:evernote)
  end

  def subscribe(tag_names)
    tag_names.each do |tag_name|
      tag = Tag.find_by_name(tag_name)
      if tag && !self.tags.include?(tag)
        self.tags << tag
        self.subscribe_count += 1
        self.save
      end
    end
    self.tags.map &lambda { |t| t.profile }
  end

  def bind_evernote(token)
    if auth = authorizations.find_by_provider("evernote")
      auth.update_attribute(:token, token)
    else
      self.authorizations << Authorization.new(:provider => "evernote", :token => token)
    end
  end

end
