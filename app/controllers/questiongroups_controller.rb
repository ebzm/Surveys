class QuestiongroupsController < ApplicationController
  def create
    @questiongroup = Questiongroup.create(questiongroup_params)

    redirect_to "/surveys/#{@questiongroup[:survey_id]}"
  end

  def update
    @questiongroup = Questiongroup.find(params[:id])
    @questiongroup.update(questiongroup_params)

    redirect_to "/surveys/#{@questiongroup[:survey_id]}"
  end

  def destroy
    @questiongroup = Questiongroup.find(params[:id])
    @questiongroup.destroy
  end

  def show
    @questiongroup = Questiongroup.find(params[:id])
    @questions = Question.where(questiongroup_id: @questiongroup.id)
    @group = @questiongroup.id
  end

  def new
    @questiongroup = Questiongroup.new
  end

  def edit
    @questiongroup = Questiongroup.find(params[:id])
  end

  private

  def questiongroup_params
    params.require(:questiongroup).permit(:label, :survey_id)
  end
end
