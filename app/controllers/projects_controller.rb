class ProjectsController < ApplicationController
  before_filter :require_login, except: [:show] 

  def index
    @projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])
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
  end

  def update
  end

  def destroy
  end

  def project_params
    params.require(:project).permit(:title, :file_data)
  end
end
