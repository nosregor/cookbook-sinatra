class Recipe
  def initialize(args = {})
    # STATE
    @name = args[:name]
    @description = args[:description]
    # New features:
    @cooking_time = args[:cooking_time]
    @difficulty = args[:difficulty]
    @tested = false#@args[:tested] || false
  end

  attr_reader :name, :description, :cooking_time, :difficulty
  attr_accessor :tested

  def tested?
    @tested
  end

  def mark_as_tested
    @tested = true
  end
end


# class Recipe
#   attr_reader :name
#   attr_accessor :url, :description, :cooking_time, :difficulty

#   # def initialize(name, description)
#   #   # STATE:
#   #   @name = name
#   #   @description = description

#   #   # New features:
#   #   # - cooking time
#   #   # - prep time
#   #   # - tested?
#   #   @url = nil
#   #   @tested = false
#   #   @cooking_time = nil
#   #   @difficulty = nil
#   # end

#   def initialize(args = {})
#     # STATE:
#     @name = args[:name]
#     @description = args[:description]

#     # New features:
#     # - cooking time
#     # - prep time
#     # - tested?
#     #@url = nil
#     @tested = false
#     @cooking_time = args[:cooking_time]
#     @difficulty = args[:difficulty]
#   end


#   # def valid?
#   #   if @name == nil || @name == ""
#   #     return false
#   #   elsif @description.length < 4
#   #     return false
#   #   elsif @difficulty < 1 || @difficulty > 5
#   #     return false
#   #   else
#   #     return true
#   #   end
#   # end

#   def tested?
#     return @tested
#   end

#   def mark_as_tested
#     @tested = true
#   end

# end
