require 'test_helper'
class GameControllerTest < ActionDispatch::IntegrationTest
  def self.seed
    seed = Rails.application.load_seed
  end 

  def self.sample_params_normal
      params = {
        :answer=>"mobil",
        :respon=>"",
        :points=>"0",
        :lanjut=>"true",
        :words=>["macan", "anjing", "kucing", "buaya", "burung", "kulkas", "kursi", "meja", "mobil", "yogyakarta"].to_s.gsub(" ", ""),
        :word=>"mobil"
      }
      return params
  end

  def self.sample_params_wrong
      params = {
        :answer=>"roti",
        :respon=>"",
        :points=>"0",
        :lanjut=>"true",
        :words=>"false json",
        :word=>"mobil"
      }
      return params
  end

  test "get blank params response" do
    params = {}
    data = GameControllerTest.seed
    response = Game.new(params).start_game
    assert_equal ["macan", "anjing", "kucing", "buaya", "burung", "kulkas", "kursi", "meja", "mobil", "yogyakarta"].to_s.gsub(" ", ""), response[:words]
    p "response of blank params true"
  end

  test "get sample_normal params response" do
    params = GameControllerTest.sample_params_normal
    data = GameControllerTest.seed
    response = Game.new(params).start_game
    assert_equal ["macan", "anjing", "kucing", "buaya", "burung", "kulkas", "kursi", "meja", "yogyakarta"].to_s.gsub(" ", ""), response[:words]
    p "response of sample_normal params true"
  end

  test "get sample_b params response" do
    params = GameControllerTest.sample_params_wrong
    data = GameControllerTest.seed
    response = Game.new(params).start_game
    assert_equal ["macan", "anjing", "kucing", "buaya", "burung", "kulkas", "kursi", "meja", "mobil", "yogyakarta"].to_s.gsub(" ", ""), response[:words]
    p "response of sample_wrong params true"
  end

end
