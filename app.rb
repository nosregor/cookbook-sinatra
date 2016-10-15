require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require 'open-uri'
require 'nokogiri'

require_relative "models/cookbook"
require_relative "models/recipe"
require_relative "models/jamie_oliver"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file = File.open('data/recipes.csv')
#@recipes = Cookbook.new(csv_file).recipes.each_slice(3)
COOKBOOK = Cookbook.new(csv_file)
# require_relative 'cookbook'    # You need to create this file!
# require_relative 'controller'  # You need to create this file!


# controller = Controller.new(cookbook)


# get '/' do  # <- Router part
#   'Hello world! Proramming at Le Wagon is awesome!'
#   # [...]   #
#   # [...]   # <- Controller part
#   # [...]   #

# end

get '/' do
  #csv_file = File.join(__dir__, 'data/recipes.csv')
  #csv_file = File.open('data/recipes.csv')
  #@recipes = Cookbook.new(csv_file).recipes.each_slice(3)
  # I want to disply all recipes
  @recipes = COOKBOOK.recipes.each_slice(3)
  #@recipes = cookbook.all
  erb :index
end

get '/web_search' do
  # 1. ask user what ingredient he is searching for
  @search_term = params[:q]
  # 2. Scrape JamieOliver for that ingredient
  @search_results = JamieOliver.new.search(@search_term).each_slice(3)  # ARRAY of recipe objects
  erb :web_search
end

get '/add_recipe' do
  # recipe = Recipe.new(params)
  # COOKBOOK.add_recipe(recipe)
  # redirect to('/')
  erb :add_recipe
end



post '/import_recipe' do
 # params
 #  {"name"=>"Apple crumble",
 # "description"=>"“You can",
 # "cooking_time"=>" 50M",
 # "difficulty"=>"super easy",
 # "tested"=>"false"}
  recipe = Recipe.new(params)
  COOKBOOK.add_recipe(recipe)
  redirect to('/')
end



