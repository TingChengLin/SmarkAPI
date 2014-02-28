class KlassesController < ApplicationController
  def ongoing
    klasses = Klass.where("deadline > ?", Time.now).page(params[:page]).per(params[:per])
    k_profiles = klasses.map {|k| k.profile}
    render :json => k_profiles
  end

  def archived
    klasses = Klass.where("deadline < ?", Time.now).page(params[:page]).per(params[:per])
    k_profiles = klasses.map {|k| k.profile}
    render :json => k_profiles    
  end
end
