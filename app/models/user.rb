# == Schema Information
# Schema version: 20110420044048
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :relationships, :foreign_key => "cheqer_id",
                           :dependent => :destroy
  has_many :cheqeds, :through => :relationships
  has_many :reverse_relationships, :foreign_key => "cheqed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :cheqers, :through => :reverse_relationships, :source => :cheqer
  has_many :matches, :through => :relationships #Added for matching

  email_regex = /\A[\w+\-.]+@rpi.edu/i

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }

  validates :email, :presence   => true,
                    :format     => { :with => email_regex},
                    :uniqueness => { :case_sensitive => false }

  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :minimum => 6} 

  before_save :encrypt_password

  #Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def cheqed?(cheqed)
    relationships.find_by_cheqed_id(cheqed)
  end

  def cheq!(cheqed)
    relationships.create!(:cheqed_id => cheqed.id, :match => false)
  end

  def uncheq!(cheqed)
    relationships.find_by_cheqed_id(cheqed).destroy
  end

#--------------Matching Part-----------------
  def match?(cheqed)
    relationships.find_by_cheqed_id(cheqed)
  end

  def match!(cheqed)
    m = relationships.find_by_cheqed_id(cheqed)
    if( m!= nil)
      m.update_attributes(:match => true)
    end
  end

  def unmatch!(cheqed)
    m = relationships.find_by_cheqed_id(cheqed)
    m.update_attributes(:match => false)
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
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