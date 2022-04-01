class QuestiongroupsController < ApplicationController
  def create
    Questiongroup.create(
      label: params[:questiongroup][:label]
      survey_id: params[:questiongroup][:survey_id]
    )
  end

  def update
    @questiongroup = Questiongroup.find(params[:id])
    @questiongroup.update(
      label: params[:questiongroup][:label]      
    )
  end

  def destroy
    @questiongroup = Questiongroup.find(params[:id])
    @questiongroup.destroy
  end

  def show
    @questiongroup = Questiongroup.find(params[:id])
  end

  def index
    @questiongroups = Questiongroup.all
  end
end
