class User < ActiveRecord::Base

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
         :recoverable, :rememberable, :trackable, :validatable
end
