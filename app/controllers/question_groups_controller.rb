class QuestionGroupsController < ApplicationController
  before_action :require_authentication
  before_action :set_question_group, only: %i[destroy show edit update]
  before_action :set_survey
  before_action :authorize_question_group
  
  def create
    question_group = @survey.question_groups.build question_group_params

    if question_group.save
      redirect_to survey_path(@survey)
    else
      render 'question_groups/new'
    end
  end

  def update
    @question_group.update(
      label: params[:question_group][:label]      
    )
    flash[:success] = "Question group updated!"

    redirect_to survey_path(@survey)
  end

  def destroy
    @question_group.destroy
    flash[:success] = "Question group deleted!"
    redirect_to survey_path(@survey)
  end

  def show
    @questions = @question_group.questions
    @group = @question_group.id
  end

  def new
    @question_group = QuestionGroup.new
  end

  def edit
  end

  private

  def question_group_params
    params.require(:question_group).permit(:label, :survey_id)
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_question_group
    @question_group = QuestionGroup.find(params[:id])
  end

  def authorize_question_group
    authorize(@question_group || QuestionGroup)
  end
end
