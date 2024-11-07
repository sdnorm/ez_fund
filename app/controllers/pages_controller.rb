class PagesController < ApplicationController
  allow_unauthenticated_access

  def index
    puts "Current session: #{Current.session.inspect}"
  end
end
