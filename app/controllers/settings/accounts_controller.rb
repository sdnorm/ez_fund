module Settings
  class AccountsController < Settings::BaseController
    before_action :authenticate_user!

    def show
      @user = current_user
      authorize [ :settings, @user ], :show?
    end
  end
end
