class AdsController < ApplicationController
  
  def index
    @ads = Ad.find(:all)
  end
  
  def show
    @ad = Ad.find(params[:id])
  end
  
  def new
    @ad = Ad.new
  end
  
  def create
    @ad = Ad.new(params[:ad])
    @ad.save
    redirect_to "/ads/#{ @ad.id }"
  end
  
  def edit
    @ad = Ad.find(params[:id])
  end
  
  def update
    @ad = Ad.find(params[:id])
    @ad.update_attributes(params[:ad])
    redirect_to "/ads/#{ @ad.id }"
  end
end
