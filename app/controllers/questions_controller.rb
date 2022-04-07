class QuestionsController < ApplicationController
  before_action :require_authentication
  before_action :set_question, only: %i[update destroy edit show]
  before_action :authorize_question
  
  def create
    @question = Question.create(question_params)
    flash[:success] = "Question created!"

    redirect_to "/questiongroups/#{@question[:questiongroup_id]}"
  end

  def update
    @question.update(question_params)
    flash[:success] = "Question updated!"

    redirect_to "/questiongroups/#{@question[:questiongroup_id]}"
  end

  def destroy
    @question.destroy
    flash[:success] = "Question deleted!"

    redirect_to "/questiongroups/#{@question[:questiongroup_id]}"
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers
  end

  private

  def question_params
    params.require(:question).permit(:questiontype, :questiongroup_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def authorize_question
    authorize(@question || Question)
  end
end
