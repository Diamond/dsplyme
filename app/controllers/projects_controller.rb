class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    if @project = Project.create(project_params)
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
