require_relative 'browser'

class Marmiton < Browser
  def initialize
    super("http://www.marmiton.org/recettes/recherche.aspx?s=")
  end

  def search(ingredient)
    search_results = [] # Array of instances
    page = open_ingredient(ingredient)
    page.css(".recette_classique").each do |recipe|
      name = recipe.css(".m_titre_resultat > a")[0]["title"].strip
      description = recipe.css(".m_texte_resultat").inner_text
      cooking_time = get_time(recipe.css(".m_detail_time"))
      difficulty = recipe.css('.m_detail_recette').text.split("-")[2].gsub("\s", "")

      attributes = {
        name: name,
        description: description,
        cooking_time: cooking_time,
        difficulty: difficulty,
        tested: false
      }
      search_results << Recipe.new(attributes)
      #recipes << { name: name, description: description, cooking_time: cooking_time, difficulty: difficulty }
    end
    search_results
  end

  def get_time(doc)
    total = 0
    doc.each do |e|
      time = e.inner_text.gsub(/[^\w?\s?]/, "").strip.split(" ")
      case time[1]
      when "h"
        total += time[0].to_i * 60
      else
        total += time[0].to_i
      end
    end
    return "#{total}M"
  end
end
