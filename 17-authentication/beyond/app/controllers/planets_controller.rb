class PlanetsController < ApplicationController
  def index 
    @planets = Planet.all
    # render :index
  end 


  def new
    @planet = Planet.new
    
    # render :new
  end

  def create
    planet = Planet.create(planet_params)

    # if planet is valid
      # then redirect to planet path
    # else if planet is not valid
      # then go back to the new page
      # display the error

    if planet.valid?
      redirect_to planet_path(planet)
    else
      # display error
      flash[:my_errors] = planet.errors.full_messages
      redirect_to new_planet_path
    end
    
    
  end
  
  def show 
    @planet = Planet.find(params[:id])

    cookies[:test_cookie] = "sweet test"

    if cookies[:view_count]
      cookies[:view_count] = cookies[:view_count].to_i + 1
    else 
      cookies[:view_count] = 1
    end 
  end 
  
  def edit 
    @planet = Planet.find(params[:id])
    
    # render :edit
  end 

  
  def update 
    @planet = Planet.find(params[:id])
    @planet.update(planet_params)
    
    redirect_to planet_path(@planet)
  end 
  
  
  def destroy 
    @planet = Planet.find(params[:id])
    @planet.destroy 

    redirect_to planets_path
  end 

  private

  def planet_params
    params.require(:planet).permit(:name, :size)
  end

end
