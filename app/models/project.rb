class Project < ActiveRecord::Base
  attr_accessible :name
  
  validates_presence_of :name
  
  has_many :permissions, :as => :thing
  scope :readable_by, lambda { |user| 
    joins(:permissions).where(:permissions => {:action => 'view', :user_id => user.id})
    }
  
  has_many :tickets, :dependent => :delete_all #use :destroy if nested resource as it's own depedents or callbacks
  
  def self.for(user)
    user.admin? ? Project : Project.readable_by(user)
  end
  
end
