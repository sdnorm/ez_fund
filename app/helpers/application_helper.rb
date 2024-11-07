module ApplicationHelper
  def signed_in?
    Current.session.present?
  end

  def current_user
    Current.session&.user
  end
end
