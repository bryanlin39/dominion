
require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')

get('/') do
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
end
