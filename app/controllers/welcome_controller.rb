class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    render :text => "Smark!"
  end
end