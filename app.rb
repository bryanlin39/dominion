
require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')

get('/') do

  act1 = Card.create({:name=>'action1', :card_type=>'action'})
  Supply.create({:card_id=>act1.id, :amount=>1})
  Player.create({:player_num=>1})
  Player.create({:player_num=>2})
  Player.create({:player_num=>3})
  @board = Supply.board
  @player = Player.all.sample
  #shuffle and draw
  @player.player_num.to_i+1>Player.all.length ? (@next_player=1):(@next_player=@player.player_num.to_i+1)
  erb(:index)
end

post('/:id') do
  @board = Supply.board
  @player = Player.custom_find(starter)
  #discard and shuffle/draw
  @player.player_num.to_i+1>Player.all.length ? (@next_player=1):(@next_player=@player.player_num.to_i+1)
  erb(:index)
end

get('/kill')do
  Supply.destroy_all
  Player.destroy_all
  Deck.destroy_all
  Card.destroy_all
  erb(:index)
end
