require_relative '../lib/mairie_christmas'

describe "the get_townhall_email method" do
  it "should return an address mail" do
    expect(get_townhall_email("https://www.annuaire-des-mairies.com/95/avernes.html")).to eq("mairie.avernes@orange.fr")
  end
end

describe " the get_townhall_urls method" do
  it "should return an array" do
    expect(get_townhall_urls).to be_a(Array)
  end
end