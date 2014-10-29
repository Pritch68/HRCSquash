class NewsPost < ActiveRecord::Base
   
  belongs_to :user
  
  validates_presence_of :title
  
  scope :recent, -> { order("created_at DESC") }
  
end
