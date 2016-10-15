require_relative 'browser'
require_relative 'recipe'

class JamieOliver < Browser
  def initialize
    super("http://www.jamieoliver.com/search/?s=")
  end

  def search(ingredient)
    # 1. empty array to store all recipes
    search_results = [] # Array of instances
    page = open_ingredient(ingredient)
    page.css(".recipe a").each do |recipe|
      name          = recipe.css("h2").inner_text
      cooking_time  = recipe.css(".time").inner_text
      difficulty    = recipe.css(".difficulty").inner_text
      description   = open_url(recipe["href"]).css(".recipe-intro").inner_text.gsub(/[“|”]/, '').strip

      # Recipe args
      attributes = {
        name: name,
        description: description,
        cooking_time: cooking_time,
        difficulty: difficulty,
        tested: false
      }

      search_results << Recipe.new(attributes)
    end
    search_results
  end
end




# require_relative 'models/recipe'
# require 'open-uri'
# require 'nokogiri'


# class JamieOliver

#  def search(ingredient)
#     # HTML request - this is the page we're going to scrape
#     base_url = 'http://www.jamieoliver.com'
#     search_url = "#{base_url}/search/?s=#{ingredient}"

#     html_file = open(search_url)
#     # this is where we tranform our http response into a nokogiri object
#     html_doc = Nokogiri::HTML(html_file, nil, 'utf-8')
#     puts "Scraping from Jamie Oliver for - #{ingredient}"

#     # this is an empty array where we will store all the recipes
#     search_results = [] # Array of instances

#     nodes = html_doc.css('.recipe')
#     puts "There are #{nodes.size} recipes"

#     # HERE WE LOOP THROUGH EACH RECIPE BLOCK
#     nodes.each do |node|
#       # Recipes info
#       name = node.css('h2').text
#       url = node.css('a').attr('href')
#       difficulty = node.css('.difficulty').text
#       cooking_time = node.css('.time').text

#       show_url = node.css('a').attr('href').value
#       show_doc = Nokogiri::HTML(open(show_url), nil, 'utf-8')
#       description = show_doc.css('.recipe-intro').inner_text.gsub(/[“|”]/, '').strip

#       #puts "#{name} - #{description}"

#       ## HASHES
#       recipe_args = {
#         name: name,
#         cooking_time: cooking_time,
#         #url: url,
#         difficulty: difficulty,
#         description: description
#       }
#       ## ARRAYS
#       # recipe = Recipe.new(name, nil)
#       # recipe.cooking_time = cooking_time
#       # recipe.url = url
#       # recipe.difficulty = difficulty
#       # search_results << recipe

#       search_results << store_recipe(recipe_args)
#     end
#     search_results
#   end

#   private

#   def store_recipe(args = {})
#     recipe = Recipe.new(args)
#     #recipe.cooking_time = args[:cooking_time]
#     #recipe.url = args[:url]
#     #recipe.difficulty = args[:difficulty]
#     recipe
#   end


#   def get_description(url)
#     html = Nokogiri::HTML(open(url))
#     html.search('.recipe-intro').text.strip
#   end

# end
