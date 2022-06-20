# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :require_authentication
    before_action :set_user, only: %i[edit update destroy]
    before_action :authorize_user

    def index
      @users = User.order(created_at: :desc)
    end

    def edit; end

    def destroy
      @user.destroy
      flash[:success] = 'User deleted!'
      redirect_to admin_user_path
    end

    def update
      if @user.update user_params
        flash[:succes] = 'User updated!'
        redirect_to admin_user_path
      else
        render :edit
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :account_type)
    end

    def authorize_user
      authorize([:admin, (@user || User)])
    end
  end
end
