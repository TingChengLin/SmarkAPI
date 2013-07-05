class WelcomeController < ApplicationController
  before_filter :token_auth!
  def index
  end

  def show
  end
end
