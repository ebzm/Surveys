class QuestionGroupsController < ApplicationController
  before_action :require_authentication
  before_action :set_questiongroup, only: %i[update destroy show edit]
  before_action :authorize_questiongroup
  
  def create
    @questiongroup = QuestionGroup.create(questiongroup_params)
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
    @questions = Question.where(question_group_id: @questiongroup.id)
    @group = @questiongroup.id
  end

  def new
    @questiongroup = QuestionGroup.new
  end

  def edit
  end

  private

  def questiongroup_params
    params.require(:question_group).permit(:label, :survey_id)
  end

  def set_questiongroup
    @questiongroup = QuestionGroup.find(params[:id])
  end

  def authorize_questiongroup
    authorize(@questiongroup || QuestionGroup)
  end
end
