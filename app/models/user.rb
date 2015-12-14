class User < ActiveRecord::Base

  has_many :holidays
  #creating self joins between columns for ttf and engineers
  has_many :subordinates, class_name: "User", foreign_key: :ttf_id
  belongs_to :ttf, class_name: "User"

  #creating relationships between sttf and ttf
  has_many :ttfs, class_name: "User", foreign_key: :sttf_id
  belongs_to :sttf, class_name: "User"

  def self.names
    all.map(&:name)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

end
