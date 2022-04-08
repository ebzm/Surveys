class QuestionsController < ApplicationController
  before_action :require_authentication
  before_action :set_question, only: %i[destroy show edit update]
  before_action :set_question_group
  before_action :set_survey
  before_action :question_params, only: %i[create, update]
  before_action :authorize_question
  
  def create
    question = @question_group.questions.build question_params
    if question.save
      flash[:success] = "Question created!"
      redirect_to survey_question_group_path(@survey, @question_group)
    else
      render 'questions/new'
    end
  end

  def new
    @question = Question.new
  end

  def update
    @question.update(
      questiontype: params[:question][:questiontype]      
    )
    flash[:success] = "Question updated!"

    redirect_to survey_question_group_path(@survey, @question_group)
  end
  
  def edit
  end

  def destroy
    @question.destroy
    flash[:success] = "Question deleted!"
    redirect_to survey_question_group_path(@survey, @question_group)
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers
  end

  private

  def question_params
    params.require(:question).permit(:questiontype)
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_question_group
    @question_group = QuestionGroup.find(params[:question_group_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def authorize_question
    authorize(@question || Question)
  end
end
