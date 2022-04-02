class SurveysController < ApplicationController
  def create
    Survey.create(
      label: params[:survey][:label]
    )

    redirect_to surveys_path
  end

  def update
    @survey = Survey.find(params[:id])
    @survey.update(
      label: params[:survey][:label]      
    )

    redirect_to surveys_path
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
  end

  def show
    @survey = Survey.find(params[:id])
    @questiongroup = Questiongroup.where(survey_id: @survey.id)
    @group = @survey.id
  end 
  
  def index
    @surveys = Survey.all
  end 

  def new
    @survey = Survey.new
  end

  def edit
    @survey = Survey.find(params[:id])
  end
end
