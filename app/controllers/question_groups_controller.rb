# frozen_string_literal: true

class QuestionGroupsController < ApplicationController
  before_action :require_authentication
  before_action :set_questiongroup, only: %i[destroy show edit update]
  before_action :set_survey
  before_action :authorize_questiongroup

  def create
    question_group = @survey.question_groups.build questiongroup_params

    if question_group.save
      redirect_to survey_path(@survey)
    else
      render 'question_groups/new'
    end
  end

  def update
    @questiongroup.update(
      label: params[:question_group][:label]
    )
    flash[:success] = 'Question group updated!'

    redirect_to survey_path(@survey)
  end

  def destroy
    @questiongroup.destroy
    flash[:success] = 'Question group deleted!'
    redirect_to survey_path(@survey)
  end

  def show
    @questions = @questiongroup.questions
    @group = @questiongroup.id
  end

  def new
    @questiongroup = QuestionGroup.new
  end

  def edit; end

  private

  def questiongroup_params
    params.require(:question_group).permit(:label, :survey_id)
  end

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_questiongroup
    @questiongroup = QuestionGroup.find(params[:id])
  end

  def authorize_questiongroup
    authorize(@questiongroup || QuestionGroup)
  end
end
