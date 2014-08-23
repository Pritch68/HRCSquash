class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates_presence_of :name
	validates_uniqueness_of :name, :email, :case_sensitive => false
  
  has_many :homescores, :class_name => "Score", :foreign_key => "player1_id"
	has_many :visitingscores, :class_name => "Score", :foreign_key => "player2_id"
  
end
