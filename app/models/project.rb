class Project < ActiveRecord::Base
  attr_accessible :name
  
  validates_presence_of :name
  
  has_many :tickets, :dependent => :delete_all #use :destroy if nested resource as it's own depedents or callbacks
  
end
