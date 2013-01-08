class TicketsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_project
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]
  before_filter :authorize_create!, :only => [:new, :create]
  before_filter :authorize_update!, :only => [:edit, :update]
  before_filter :authorize_delete!, :only => [:destroy]
  
  def new
    @ticket = @project.tickets.build
    @ticket.assets.build
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
    @project = Project.for(current_user).find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking for could not be found"
    redirect_to root_path
  end
  
  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end
  
  def authorize_create!
    if !current_user.admin? && cannot?("create tickets".to_sym, @project)
      flash[:alert] = "You cannot create tickets on this project"
      redirect_to @project
    end
  end
  
  def authorize_update!
    if !current_user.admin? && cannot?(:"edit tickets", @project)
      flash[:alert] = "You do not have permission to update tickets"
      redirect_to @project
    end
  end
  
  def authorize_delete!
    if !current_user.admin? && cannot?(:"delete tickets", @project)
      flash[:alert] = "You do not have permission to delete this ticket"
      redirect_to @project
    end
  end
  
end
