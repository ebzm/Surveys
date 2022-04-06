class AnswersController < ApplicationController
  before_action :set_answer, only: %i[destroy]
  before_action :set_question

  def create
    @answer = @question.answers.build answer_params

    if @answer.save
      flash[:success] = "Answer created!"
      redirect_to question_path(@question)
    else
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = "You can vote again!"

    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:answer_val, :user_id)
  end

  def set_question
    @question = Question.find params[:question_id]
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
