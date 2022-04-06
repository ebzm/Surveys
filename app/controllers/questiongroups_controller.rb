class QuestiongroupsController < ApplicationController
  before_action :set_questiongroup, only: %i[update destroy show edit]
  def create
    @questiongroup = Questiongroup.create(questiongroup_params)
    flash[:success] = "Question group created!"

    redirect_to "/surveys/#{@questiongroup[:survey_id]}"
  end

  def update
    @questiongroup.update(questiongroup_params)
    flash[:success] = "Question group udated!"

    redirect_to "/surveys/#{@questiongroup[:survey_id]}"
  end

  def destroy
    @questiongroup.destroy
    flash[:success] = "Question group deleted!"

    redirect_to "/surveys/#{@questiongroup[:survey_id]}"
  end

  def show
    @questions = Question.where(questiongroup_id: @questiongroup.id)
    @group = @questiongroup.id
  end

  def new
    @questiongroup = Questiongroup.new
  end

  def edit
  end

  private

  def questiongroup_params
    params.require(:questiongroup).permit(:label, :survey_id)
  end

  def set_questiongroup
    @questiongroup = Questiongroup.find(params[:id])
  end
end
