class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :favorites
  has_many :shows, through: :favorites

  serialize :fb_data, JSON

  def add_favorite(show_id)
    self.favorites.create!(show_id: show_id)
  end

  def remove_favorite(show_id)
    self.favorites.find_by(show_id: show_id).delete
  end

  def self.from_omniauth data
    fb_id = data.uid
    if user = User.find_by(fb_id: fb_id)
      user
    else
      where(fb_id: fb_id).create! do |u|
        u.password = SecureRandom.hex 64
        u.name = data.info.name
        u.email = data.info.email
        u.avatar = data.info.image
        u.fb_id = data.uid
        u.fb_token = data.credentials.token
      end
    end
  end
end

# HTTParty.get("https://graph.facebook.com/#{user.fb_id}/television?access_token=#{user.fb_token}&limit=5000")