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

  def index
    @klasses = Klass.order("id DESC").page(params[:page]).per(params[:per])
    @klass = Klass.new
  end

  def create
    @klass = Klass.new(params[:klass])
    @klass.save

    redirect_to :action => :index
  end
end
