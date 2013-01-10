class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_ticket
  
  def create
    if can?(:"change states", @ticket.project) || current_user.admin?
      nil
    else
      params[:comment].delete(:state_id)
    end
    
    @comment = @ticket.comments.build(params[:comment].merge(:user => current_user))
    if @comment.save
      if can?(:tag, @ticket.project) || current_user.admin?
        @ticket.tag!(params[:tags])
      end
      
      flash[:notice] = "Comment created"
      redirect_to [@ticket.project, @ticket]
    else
      @state = State.all
      flash[:alert] = "Comment could not be created"
      render :template => 'tickets/show'
    end
  end
  
private

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
