class PokedexesController < ApplicationController
  before_action :set_pokedex, only: [:show, :edit, :update, :destroy]

  # GET /pokedexes
  # GET /pokedexes.json
  def index

    #@pokedexes = Pokedexe.all
    per_page = 5
    if params[:page].present?
      params[:page] = params[:page].to_i
    else
      params[:page] = 1
    end
    @pokedexes = Pokedex.paginate(:page => params[:page], :per_page => per_page)
    @row_number = ((params[:page] - 1) * per_page) + 1
  end

  # GET /pokedexes/1
  # GET /pokedexes/1.json
  def show
   
  end

  # GET /pokedexes/new
  def new
    @pokedex = Pokedex.new
  end

  # GET /pokedexes/1/edit
  def edit
  end

  # POST /pokedexes
  # POST /pokedexes.json
  def create
    @pokedex = Pokedex.new(pokedex_params)
    # require 'pry'
    # binding.pry
    if @pokedex.save
      redirect_to @pokedex,  notice: 'Pokedexe was successfully created.'
    else
      flash[:danger] = "Gagal Euy"
      render :new
    end
  end

  # PATCH/PUT /pokedexes/1
  # PATCH/PUT /pokedexes/1.json
  def update
    if @pokedex.update(pokedex_params)
      redirect_to @pokedex, notice: 'Pokedexe was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pokedexes/1
  # DELETE /pokedexes/1.json
  def destroy
    @pokedex.destroy
    redirect_to pokedexes_url, notice: 'Pokedexe was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokedex
      @pokedex = Pokedex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokedex_params
      params.require(:pokedex).permit(:name, :base_health_point, :base_attack, :base_defence, :base_speed, :element_type, :image_url)
    end
end
