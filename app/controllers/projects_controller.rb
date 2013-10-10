class ProjectsController < ApplicationController
  before_filter :require_login, except: [:show] 

  def index
    @projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])
    redirect_to :root, alert: "You do not have permission to view this project!" unless @project.viewable?(current_user)
  end

  def new
    @project = current_user.projects.new
  end

  def create
    if @project = current_user.projects.create(project_params)
      redirect_to @project, notice: "Project created successfully!"
    else
      redirect_to :root, alert: "Failed to create new project!"
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice: "Updated project successfully!"
    else
      redirect_to :root, alert: "Failed to update project!"
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    if @project.destroy
      redirect_to :root, notice: "Deleted project!"
    else
      redirect_to :root, alert: "Failed to delete project!"
    end
  end

  def project_params
    params.require(:project).permit(:title, :file_data, :public)
  end
end
