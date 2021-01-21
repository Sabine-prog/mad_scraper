require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"


def dark_trader
  # Hash {"Symbol", price}
  hash_cc = Hash.new

  # Array of hash_crypto
  array_cc = Array.new

  # Open the page
  page = Nokogiri::HTML(URI.open(PAGE_URL))


  # Parse the all views : keeps symbols as keys and prices as values for the hash
  array_cc_symbols = page.xpath('//*[@class="cmc-table-row"]//td[3]/div').map{|element| element = element.text}
  #puts "Tableau des symboles : #{array_cc_symbols}"
  array_cc_prices = page.xpath('//*[@class="cmc-table-row"]//td[5]/div').map{|element| element = element.text.delete("$,").to_f}
  #puts "Tableau des prix : #{array_cc_prices}"

  # Controls that the array sizes are the same
  if array_cc_symbols.size == array_cc_prices.size
    for index in 0..(array_cc_symbols.size - 1)
      hash_cc = Hash[array_cc_symbols[index],  array_cc_prices[index]]
      #puts "Hash de cryptocur : #{hash_cc}"
      array_cc << hash_cc
    end
  else
    puts "Il y a une incohérence entre les symboles et les prix."
  end

    return array_cc
end

puts "Tableau de crypto : #{dark_trader}"