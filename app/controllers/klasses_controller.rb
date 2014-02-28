class KlassesController < ApplicationController
  def status
    klasses = Klass.page(param[:page]).per(param[:per])
    k_profiles = klasses.map {|k| k.profile}
    render :json => k_profiles
  end
end
