require 'rails_helper'

 describe Airing do

  it "can create new airing listing" do
    airs_at = 1.day.from_now
    listing = Airing.new(network: "Fox", show: "Futurama", airs_at: airs_at)

    # expect(listing.respong_to?(:network)).to be true

    expect(listing.network).to eq "Fox"
    expect(listing.show).to eq "Futurama"
    expect(listing.airs_at).to eq airs_at
  end

  it "requires all 3 entires" do
    expect { Airing.new }.to raise_error
    expect { Airing.new(network: "Fox")}.to raise_error
  end

  it "can show all airing objects" do
    expect(Airing.all.count).to be > 0
  end
end