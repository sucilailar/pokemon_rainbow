class PokemonBattleLogsController < ApplicationController
  before_action :set_pokemon_battle_log, only: [:show, :edit, :update, :destroy]

  # GET /pokemon_battle_logs
  # GET /pokemon_battle_logs.json
  # def initialize(attacker, defender, skill, params, pokemon_battle)
  #   @attacker = attacker
  #   @defender = defender
  #   @skill = skill
  #   @params = params
  #   # @damage = damage
  #   @pokemon_battle = pokemon_battle
  # end 

  def index
    @pokemon_battle_logs = PokemonBattleLog.where(pokemon_battle_id: params[:pokemon_battle_id])
    @pokemon_battle = Pokemon.all
  end

  # GET /pokemon_battle_logs/1
  # GET /pokemon_battle_logs/1.json
  def show
    @pokemon_battle_logs = PokemonBattleLog.where(pokemon_battle_id: @pokemon_battle)
  end

  # GET /pokemon_battle_logs/new
  def new
    @pokemon_battle_log = PokemonBattleLog.new
  end

  # GET /pokemon_battle_logs/1/edit
  def edit
  end

  # POST /pokemon_battle_logs
  # POST /pokemon_battle_logs.json
  def create
    #harus tau attacker dan defender nya siapa
    #menerima parameter dari controller pokemon battle
    @pokemon_battle_log = PokemonBattleLog.new(pokemon_battle_log_params)
    #ambil parameter 
    respond_to do |format|
      if @pokemon_battle_log.save
        format.html { redirect_to @pokemon_battle_log, notice: 'Pokemon battle log was successfully created.' }
        format.json { render :show, status: :created, location: @pokemon_battle_log }
      else
        format.html { render :new }
        format.json { render json: @pokemon_battle_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokemon_battle_logs/1
  # PATCH/PUT /pokemon_battle_logs/1.json
  def update
    respond_to do |format|
      if @pokemon_battle_log.update(pokemon_battle_log_params)
        format.html { redirect_to @pokemon_battle_log, notice: 'Pokemon battle log was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokemon_battle_log }
      else
        format.html { render :edit }
        format.json { render json: @pokemon_battle_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemon_battle_logs/1
  # DELETE /pokemon_battle_logs/1.json
  def destroy
    @pokemon_battle_log.destroy
    respond_to do |format|
      format.html { redirect_to pokemon_battle_logs_url, notice: 'Pokemon battle log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_battle_log
      @pokemon_battle_log = PokemonBattleLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_battle_log_params
      params.require(:pokemon_battle_log).permit(:pokemon_battle_id, :turn, :skill_id, :damage, :attacker_id, :attacker_current_health_point, :defender_id, :defender_current_health_point, :action_type)
    end
end
