class Comment < ActiveRecord::Base
  attr_accessible :text, :ticket_id, :user, :state_id #:user_id

  validates :text, :presence => true
  
  belongs_to :user
  belongs_to :state
  belongs_to :ticket
  belongs_to :previous_state, :class_name => 'State'
  
  delegate :project, :to => :ticket
  
  before_create :set_previous_state
  after_create :set_ticket_state
  
private

  def set_ticket_state
    self.ticket.state = self.state
    self.ticket.save!
  end
  
  def set_previous_state
    self.previous_state = ticket.state
  end
  
end
