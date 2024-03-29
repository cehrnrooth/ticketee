class Ticket < ActiveRecord::Base
  searcher do
    label :tag, :from => :tags, :field => :name
    label :state, :from => :state, :field => :name
  end
  
  belongs_to :project
  belongs_to :user
  belongs_to :state
  
  has_many :assets
  accepts_nested_attributes_for :assets
  
  has_many :comments
  has_and_belongs_to_many :tags
  
  attr_accessible :description, :title, :assets_attributes
  
  validates_presence_of :title
  
  validates :description, :presence => true,
                          :length => {:minimum => 10}
  
  def tag!(tags)
    tags = tags.split(" ").map do |tag|
      Tag.find_or_create_by_name(tag)
    end
    
    self.tags << tags
  end
  
end
