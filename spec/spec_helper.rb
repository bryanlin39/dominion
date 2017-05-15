ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
set(:root, Dir.pwd())

require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('./app')

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.after(:each) do
    Card.all().each() do |card|
      card.destroy()
    end
    Deck.all().each() do |deck|
      deck.destroy()
    end
    Player.all().each() do |player|
      player.destroy()
    end
    Supply.all().each() do |supply|
      supply.destroy()
    end
  end
end
