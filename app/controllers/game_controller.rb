class GameController < ApplicationController
    def index
        @response = Game.new(params).start_game
        render 'index', layout: false and return
    end
end
