class SurveysController < ApplicationController
  before_action :set_survey, only: %i[update destroy show edit]
  def create
    Survey.create(
      label: params[:survey][:label]
    )

    redirect_to surveys_path
  end

  def update
    @survey.update(
      label: params[:survey][:label]      
    )

    redirect_to surveys_path
  end

  def destroy
    @survey.destroy
  end

  def show
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
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end
end
