require 'rails_helper'

#use before each to create users/shows

RSpec.describe User, type: :model do
  it "users can add favorites" do
    user1 = FactoryGirl.create :user
    show1 = FactoryGirl.create :show

    user1.add_favorite(show1.id)
    expect(Favorite.all.count).to eq 1
    expect(user1.shows.first.name).to eq "Show1"
    expect(show1.users.first.id).to eq 1
  end

  it "different users can add the same show to favorites" do
    user1 = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    show1 = FactoryGirl.create :show

    user1.add_favorite(show1.id)
    user2.add_favorite(show1.id)

    expect(user1.favorites.count).to eq 1
    expect(user2.favorites.count).to eq 1
  end

  it "users cannot add a favorite that is already their favorite" do
    user1 = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    show1 = FactoryGirl.create :show

    user1.add_favorite(show1.id)
    
    expect{
      user1.add_favorite(show1.id)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "users can delete favorites" do
    user1 = FactoryGirl.create :user
    show1 = FactoryGirl.create :show

    user1.add_favorite(show1.id)
    expect(Favorite.all.count).to eq 1

    user1.remove_favorite(show1.id)
    expect(Favorite.all.count).to eq 0
  end
end
