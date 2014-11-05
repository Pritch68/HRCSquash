class Event < ActiveRecord::Base
  
  after_initialize :defaults
  
  validates_presence_of :title, :startdate, :enddate
  
  scope :upcoming, lambda { where("enddate >= ? and startdate <= ?", DateTime.now, DateTime.now+21).order("startdate") }
  
  def defaults
    self.startdate ||= DateTime.now.change({hour: 18})
    self.enddate ||= DateTime.now.change({hour: 22})
  end
  
end
