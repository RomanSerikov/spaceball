module Admin
  class UsersController < BaseController
    before_action :set_user, only: %i[show edit update]

    def index
      @users = User.all
    end

    def show; end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:success] = 'User was successfully updated'
        redirect_to [:admin, @user]
      else
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :captain, :team_id)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
