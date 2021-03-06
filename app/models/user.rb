class User < ActiveRecord::Base 
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_many :comments, :through => :microposts, :dependent => :destroy

  has_many :microposts, :dependent => :destroy

  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy

  has_many :following, :through => :relationships, :source => :followed

  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy

  has_many :followers, :through => :reverse_relationships, :source => :follower

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence   => true,
                    :length     => { :maximum => 50 }
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  before_save :encrypt_password, :set_token

  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    crypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user :nil
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
   #same as:  self.relationships.create!(:followed_id => followed_id)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  def feed
    #This is for showing only the user's microposts'.
    #Micropost.where("user_id = ?", id)
    
    #This is the modified , to show microposts from followed
    Micropost.from_users_followed_by(self)
  end
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  private
  
    def set_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join) if new_record?
    end

    def encrypt_password
      self.salt = make_salt if new_record?
      self.crypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end

