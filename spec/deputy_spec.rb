require_relative '../lib/deputy'

describe "the get_deputy_email method" do
  it "should return an address mail" do
    expect(get_deputy_email("https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")).to eq("damien.abad@assemblee-nationale.fr")
  end
end

describe " the get_deputies method" do
  it "should return an array" do
    expect(get_deputies).to be_a(Array)
  end
end