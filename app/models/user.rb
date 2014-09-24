class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  after_initialize :defaults
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates_presence_of :name
	validates_uniqueness_of :name, :email, :case_sensitive => false
  
  has_many :homescores, :class_name => "Score", :foreign_key => "player1_id"
	has_many :visitingscores, :class_name => "Score", :foreign_key => "player2_id"
  has_many :news_posts
    	
  scope :ranked, -> { order("users.points DESC, users.name") }
  scope :active, -> { where("deleted = false") }
	scope :possible_opponents, lambda {|uid| select("id,name").where("id != ?", uid).order("name")}
	
  def defaults
    self.points ||= 1000
    self.lastchange ||= 0
    self.admin = false if self.admin.nil?
    self.deleted = false if self.deleted.nil?
  end
  
	def self.stats pid
		total_matches = Score.where("player1_id = ? or player2_id = ?",pid,pid).count
		wins = Score.where("player1_id = ? and matchscore < 3",pid).count + Score.where("player2_id = ? and matchscore > 2",pid).count
		return { :matches => total_matches, :wins => wins }
	end
  
end
