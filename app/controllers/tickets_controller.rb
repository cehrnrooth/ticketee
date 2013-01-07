class TicketsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_project
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]
  
  def new
    @ticket = @project.tickets.build
  end
  
  def create
    @ticket = @project.tickets.build(params[:ticket])
    @ticket.user = current_user
    if @ticket.save
      flash[:notice] = "Ticket created!"
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket could not be created"
      render :action => 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = "Ticket updated"
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket could not be deleted"
      render :action => 'edit'
    end
  end
  
  def destroy
    @ticket.destroy
    redirect_to @project
  end
  
private
  def find_project
    @project = Project.find(params[:project_id])
  end
  
  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end
  
end
