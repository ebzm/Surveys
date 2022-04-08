class SurveysController < ApplicationController
  before_action :require_authentication, except: %i[index]
  before_action :set_survey, only: %i[update destroy show edit]
  before_action :authorize_survey
  

  def create
    Survey.create(
      label: params[:survey][:label]
    )
    flash[:success] = "Survey created!"

    redirect_to surveys_path
  end

  def update
    @survey.update(
      label: params[:survey][:label]      
    )
    flash[:success] = "Survey updated!"

    redirect_to surveys_path
  end

  def destroy
    @survey.destroy
    flash[:success] = "Survey deleted!"
    redirect_to surveys_path
  end

  def show
    @question_group = QuestionGroup.where(survey_id: @survey.id)
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

  def authorize_survey
    authorize(@survey || Survey)
  end

end
