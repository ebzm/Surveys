class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update destroy edit]
  def create
    @question = Question.create(question_params)

    redirect_to "/questiongroups/#{@question[:questiongroup_id]}"
  end

  def update
    @question.update(question_params)

    redirect_to "/questiongroups/#{@question[:questiongroup_id]}"
  end

  def destroy
    @question.destroy
  end

  def new
    @question = Question.new
  end

  def edit
  end

  private

  def question_params
    params.require(:question).permit(:questiontype, :questiongroup_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
