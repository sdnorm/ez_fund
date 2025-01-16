module Settings
  class ProfilesController < BaseController
    def show
      @user = current_user
      authorize @user
    end

    def update
      @user = current_user
      authorize @user

      if @user.update(user_params)
        redirect_to settings_profile_path, notice: "Profile updated successfully."
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
  end
end
