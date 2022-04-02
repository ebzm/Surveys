class QuestionsController < ApplicationController
  def create
    @question = Question.create(question_params)

    redirect_to "/questiongroups/#{@question[:questiongroup_id]}"
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)

    redirect_to "/questiongroups/#{@question[:questiongroup_id]}"
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:questiontype, :questiongroup_id)
  end
end
