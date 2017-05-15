
require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')

get('/') do
  #@player = player 1
  erb(:index)
end
post('/:id') do
  #@player = player.find
  erb(:index)
end
