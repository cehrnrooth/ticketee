class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :thing, :polymorphic => true
  
  attr_accessible :action, :user, :thing #:thing_id, :thing_type, :user_id, 
end
