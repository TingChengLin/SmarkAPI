class KlassesController < ApplicationController
  def status
    klasses = Klass.page(params[:page]).per(params[:per])
    k_profiles = klasses.map {|k| k.profile}
    render :json => k_profiles
  end
end
