class SurveysController < ApplicationController
  def create
    Survey.create(
      label: params[:survey][:label]
    )
  end

  def update
    @survey = Survey.find(params[:id])
    @survey.update(
      label: params[:survey][:label]      
    )
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
  end

  def show
    @survey = Survey.find(params[:id])
    @questiongroup = Questiongroup.where(survey_id: @survey.id)
  end 
  
  def index
    @surveys = Survey.all
  end 
end
