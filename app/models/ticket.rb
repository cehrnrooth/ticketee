class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  has_many :assets
  accepts_nested_attributes_for :assets
  
  attr_accessible :description, :title, :assets_attributes
  
  validates_presence_of :title
  
  validates :description, :presence => true,
                          :length => {:minimum => 10}
end
