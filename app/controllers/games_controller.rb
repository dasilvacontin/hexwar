class GamesController < ApplicationController
  skip_filter :check_admin
  
  #
  # GET /games
  #
  def index
    @games = current_player.games.find(:all)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  #
  # GET /games/1
  #
  def show
    begin
      if current_player.admin
        @game = Game.find(params[:id])
      else
        @game = current_player.games.find(params[:id])
      end

      @current_player_team = @game.get_players_team(current_player)

      respond_to do |format|
        format.html # show.html.erb
      end

    rescue ActiveRecord::RecordNotFound => e
      flash[:notice] = "Unable to find game #{params[:id]}!"
      redirect_to games_path
    end
  end

  #
  # GET /games/new
  #
  def new
    @maps = Map.find(:all)
    @game = Game.new
    map_id = params[:map] ? params[:map] : @maps[0].id
    @game.map_id = map_id
    
    friend_list = facebook_rest.rest_call('friends_getAppUsers');
    @players = Player.find(:all, :conditions => ["id <> #{@current_player.id} AND uid IN (?)", friend_list])

    @game.game_players = [GamePlayer.new({:team => 'red', :player => @current_player}),
                          GamePlayer.new({:team=>'green'})];
    @game.game_players << GamePlayer.new({:team=>'white'}) if @game.map.number_of_players >= 3
    @game.game_players << GamePlayer.new({:team=>'blue'}) if @game.map.number_of_players == 4

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # # GET /games/1/edit
  # def edit
  #   @game = Game.find(params[:id])
  #   redirect_to(@game) 
  # end

  #
  # POST /games
  #
  def create
    @players = Player.find(:all, :conditions => ["id <> #{@current_player.id}"])
    available_for_random = []
    @players.each do |player|
      if player.available_for_random
        available_for_random << player
      end
    end

    params[:game][:game_players_attributes].each_pair do |idx,game_player|
      # Random player?
      if game_player[:player_id].blank?
        params[:game][:game_players_attributes][idx][:player_id] = available_for_random[rand(available_for_random.length)].id
      end
    end
    
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save && @game.create_new_turn('red', { current_unit_data:@game.map.unit_data })
        # Create the first game turn
        format.html { redirect_to(games_url, :notice => 'Game was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # # PUT /games/1
  # # PUT /games/1.xml
  # def update
  #   @game = Game.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @game.update_attributes(params[:game])
  #       format.html { redirect_to(games_url, :notice => 'Game was successfully updated.') }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  #
  # DELETE /games/1
  #
  def destroy
    if @current_player.admin
      @game = Game.find(params[:id])
    else
      @game = @current_player.games.find(params[:id])
    end
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
    end
  end
  
  #
  # GET /games/end_turn?id=1
  #
  def end_turn
    if @current_player.admin
      @game = Game.find(params[:id])
    else
      @game = @current_player.games.find(params[:id], :readonly => false)
    end

    unless params[:game_winner].blank?
      @game.save_current_turn(params[:game_turn])
      @game.game_winner = params[:game_winner]
      @game.save
    else
      @game.end_turn(@current_player, params[:game_turn])
    end

    respond_to do |format|
      format.json { render :json => true }
    end
  end
  
  # 
  # GET /games/is_it_my_turn?player_id=1
  #
  def is_it_my_turn
    turn_notifications = @current_player.turn_notifications.find(:all)

    respond_to do |format|
      format.json { render :json => turn_notifications }
    end
    
    @current_player.turn_notifications.destroy_all()
  end
  
  #
  # GET /games/get_turn?id=1
  #
  def get_turn
    if @current_player.admin
      @game = Game.find(params[:id])
    else
      @game = @current_player.games.find(params[:id])
    end

    @game.clear_notifications(@current_player)
    
    respond_to do |format|
      format.json { render :json => @game.current_turn }
    end
  end
end
