module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user || guest_user
    end

    private

    def find_verified_user
      if session = Session.find_by(id: cookies.signed[:session_id])
        session.user
      end
    end

    def guest_user
      # Generate a unique guest identifier for the connection
      guest_id = cookies[:guest_user_id] || SecureRandom.uuid
      cookies[:guest_user_id] ||= guest_id
      "GuestUser-#{guest_id}"
    end
  end
end
