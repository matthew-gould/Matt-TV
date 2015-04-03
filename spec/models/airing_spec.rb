require 'rails_helper'

 describe Airing do

  it "can create new airing listing" do
    day = 1.day.from_now
    listing = Airing.new(network: "Fox", show: "Futurama", day: day, time: "06:00")

    # expect(listing.respond_to?(:network)).to be true

    expect(listing.network).to eq "Fox"
    expect(listing.show).to eq "Futurama"
    expect(listing.day).to eq day
  end

  it "requires all 3 entires" do
    expect { Airing.new }.to raise_error
    expect { Airing.new(network: "Fox")}.to raise_error
  end

  it "can show all airing objects" do
    expect(Airing.all.count).to be > 0
  end

  # it "can be searched for a specific show" do
  #   Airing.all
    
  #   expect(Airing.search("Dig")).to eq "Dig"
  # end
end