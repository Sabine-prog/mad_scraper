require 'nokogiri'
require 'open-uri'

# Method wich parses the page of one deputy and returns the email address
def get_deputy_email(page_deputy_url)

  email_address = ""
  
  # Open the page
  page_deputy = Nokogiri::HTML(URI.open(page_deputy_url))
  # Parse the deputy page to find the email address
  page_deputy.xpath('//*[@class="deputes-liste-attributs"]//dd[4]//li[2]').each do |item|
    email_address = item.text.delete_prefix("Mél : ")
  end

  return email_address

end

# Method wich parses the page of the "Assemblée Nationale" and registers identity and email addresses of the deputies
def get_deputies
  # Variables initialization
  identity = []
  hash_deputy = Hash.new
  array_deputies = Array.new

  page_root_url = "https://www2.assemblee-nationale.fr"
 
  # Open the page
  page = Nokogiri::HTML(URI.open(page_root_url + "/deputes/liste/alphabetique"))

  # Parse the page to get the the deputies' identities
  page.xpath('//*[@class="clearfix col-container"]//a').each do |link|
    # Extracts first_name and laste_name
    identity = link.text.delete_prefix("M. ").delete_prefix("Mme ").split(" ")
    # Gets email of each deputy
    dep_emmail_addr = get_deputy_email(page_root_url + link['href'])
    # Fills hash for each deputy
    hash_deputy = {"first_name" => identity[0], "last_name" => identity[1], "email" => dep_emmail_addr}
    #puts hash_deputy
    # Fills the array of deputies
    array_deputies << hash_deputy
  end
  puts "Nombre de députés : #{array_deputies.length}"
  return array_deputies
end

#Methods Calls
#puts get_deputies
#puts get_deputy_email("https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")