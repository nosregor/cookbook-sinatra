require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file)
    # STATE
    @csv_file = csv_file
    @recipes = []
    load_csv
  end

  attr_reader :recipes
  # All the behavior we want the class CookBook to do
  # C: add all the recipes
  def add_recipe(recipe)
    @recipes << recipe
    write_csv
  end

  # R: display all recipes in the cook book
  def load_csv
    # read each line frmo csv and append to recipes collection
    CSV.foreach(@csv_file) do |row|
      # puts "#{row[0]} | #{row[1]}"
      @recipes << Recipe.new(name: row[0], description: row[1], cooking_time: row[2], difficulty: row[3], tested: row[4])
    end
  end

  def all
    @recipes
  end

  def find(index)
    return @recipes[index]
  end

  def save
    write_csv
  end

  # D: delete the recipe in the CookBook
  def remove_recipe(index)
    @recipes.delete_at(index)
    write_csv
  end


  private
  # U: update a recipe from the cookbook
  def write_csv
    # header = "name, description"
    CSV.open(@csv_file, 'wb') do |csv|
      # csv << header
      @recipes.each do |row|
        csv << [row.name, row.description, row.cooking_time, row.difficulty, row.tested]
      end
    end
  end
end


# require 'csv'
# require_relative 'recipe'
# # require "pry-byebug"

# class Cookbook # Repository, Fake Database
#   attr_reader :recipes

#   def initialize(csv_file) # csv_file is a String (file path)
#     @csv_file = csv_file
#     @recipes = []  # IMPORTANT: Array of `Recipe` instances.
#     load_csv
#   end

#   def all
#     @recipes
#   end

#   def find(index)
#     return @recipes[index]
#   end

  # def add_recipe(recipe) # recipe is a  `Recipe` instance
  #   # adds a new recipe to the cookbook
  #   print recipe
  #   @recipes << recipe
  #   save_to_csv
  # end

#   def remove_recipe(recipe_id)
#     # removes a recipe from the cookbook
#     @recipes.delete_at(recipe_id)
#     save_to_csv
#   end

#   def save
#     save_to_csv
#   end


  # private
  # # everything we want ....
  # def save_to_csv
  #   ## WITH HASHES
  #   csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

  #   CSV.open(@csv_file, 'wb', csv_options) do |csv|
  #     # For each recipe
  #     # Write a CSV line
  #     @recipes.each do |recipe|
  #       # recipe is a `Recipe` instance
  #       csv << [recipe.name, recipe.description, recipe.difficulty] # I have readers on name and description in `Recipe` class
  #     end
  #   end

  #   # ## WITH ARRAYS
  #   # CSV.open(@csv_file, 'wb') do |csv|
  #   #   # For each recipe
  #   #   # Write a CSV line
  #   #   @recipes.each do |recipe|
  #   #     # recipe is a `Recipe` instance
  #   #     csv << [recipe.name, recipe.description, recipe.tested?, recipe.cooking_time, recipe.difficulty]
  #   #   end
  #   # end
  # end

#   def load_csv
#     return unless File.exist?(@csv_file)

#     # WITH HASHES
#     csv_options = { col_sep: ',', quote_char: '"' }

#     CSV.foreach(@csv_file, csv_options) do |row|
#       # binding.pry  # for debugging
#       # create instance of recipe to store in recipes array
#       attributes = {
#         name: row[0],
#         description: row[1],
#         tested: row[2],
#         cooking_time: row[3],
#         difficulty: row[4]
#       }
#       @recipes << Recipe.new(attributes)


#     # # WITH ARRAYS
#     # CSV.foreach(@csv_file) do |row|
#     #   # Type of row? Array.
#     #   # column 1 of CSV (index 0) -> name
#     #   # column 2 of CSV (index 1) -> description
#     #   name = row[0]
#     #   description = row[1]
#     #   recipe = Recipe.new(name, description)
#     #   if row[2] == "true"
#     #     recipe.mark_as_tested
#     #   end
#     #   recipe.cooking_time = row[3]
#     #   recipe.difficulty = row[4]

#     #   @recipes << recipe

#     end
#   end
# end
