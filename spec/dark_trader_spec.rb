require_relative '../lib/dark_trader'

describe "the dark_trader method" do
  it "should not return nil" do
    expect(dark_trader).to_not be_nil
  end

  it "should return an array" do
    expect(dark_trader).to be_a(Array)
  end

end