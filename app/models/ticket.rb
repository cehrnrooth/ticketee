class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  attr_accessible :description, :title
  
  validates_presence_of :title
  
  validates :description, :presence => true,
                          :length => {:minimum => 10}
end
