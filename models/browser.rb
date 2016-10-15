require 'open-uri'
require 'nokogiri'

class Browser
  def initialize(url)
    @url = url
  end

  attr_reader :url

  def open_ingredient(ingredient)
    return Nokogiri::HTML(open(@url + ingredient), nil, 'utf-8')
  end

  def open_url(url)
    return Nokogiri::HTML(open(url), nil, 'utf-8')
  end
end
