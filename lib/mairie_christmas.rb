require 'pry'
require 'nokogiri'
require 'open-uri'

# Method wich parses the page of one townhall and returns the email address
def get_townhall_email(townhall_url)
  # Open the page
  page = Nokogiri::HTML(URI.open(townhall_url))

  # Parse the townhall page to find the email address
  array_info = page.xpath('//*[@class="txt-primary tr-last"]//td[2]').map {|element| element = element.text}
  email_addr = array_info.select {|element| element.include?"@"}

  return email_addr[0]
end

# Method wich parses the page of the "Val d'Oise department" and associates each town name with its email address
def get_townhall_urls
  
  page_url = "https://www.annuaire-des-mairies.com/"
  # Open the page
  page = Nokogiri::HTML(URI.open(page_url + "val-d-oise.html"))

  hash_townhall = Hash.new
  array_townhalls = Array.new

  counter = 1
  # Parse the page to find all towns URL
  page.xpath('//table//table//table//a').each do |link|
    town_name = link.text
    townhall_url = page_url + link['href'].delete_prefix!("./")
    # Email of the current townhall
    townhall_email = get_townhall_email(townhall_url)

    # Fills the Hash for the current townhall
    hash_townhall = Hash[town_name, townhall_email]
    # Fills the array of townhalls
    array_townhalls << hash_townhall

    #print "#{counter}. "
    #puts "#{town_name} : URL = #{townhall_url}, email = #{townhall_email}"
    counter = counter + 1
  end

  # Returns the array of townhalls
  return (array_townhalls)
end

# Calls the methods
#get_townhall_email("https://www.annuaire-des-mairies.com/95/avernes.html")
#puts get_townhall_urls


=begin
def get_department_urls
  page_url = "http://annuaire-des-mairies.com/"
  # Open the page
  page = Nokogiri::HTML(URI.open(page_url))

  counter = 1
  # Parse the page to find departments URL
  page.xpath('//tbody//a').each do |link_dep|
    dep_url = page_url + link_dep['href']
    print "#{counter}. "
    puts dep_url
    counter = counter + 1
  end

end
=end

