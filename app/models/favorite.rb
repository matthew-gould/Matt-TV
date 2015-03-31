class Favorite < ActiveRecord::Base

  belongs_to :user
  belongs_to :show

  validates_uniqueness_of :show, scope: :user
end
