
require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')

get('/') do
  @board = Supply.board
  Deck.setup
  Player.all.each {|player| player.draw_hand(5)}
  @player = Player.all.sample
  @player.player_num.to_i+1>Player.all.length ? (@next_player=1):(@next_player=@player.player_num.to_i+1)
  erb(:index)
end

post('/:id') do
  @board = Supply.board
  @player = Player.find_player(params[:id].to_i)
  last_player = Player.find_player(params[:last_player].to_i)
  last_player.discard_hand
  last_player.draw_hand(5)
  @player.player_num.to_i+1>Player.all.length ? (@next_player=1):(@next_player=@player.player_num.to_i+1)
  erb(:index)
end

get('/cards') do
  
end

get('/kill')do
  Supply.destroy_all
  Player.destroy_all
  Deck.destroy_all
  Card.destroy_all
end
