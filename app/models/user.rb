class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_coins
  has_many :coins, through: :user_coins
  has_many :friendships
  has_many :friends, through: :friendships


  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end

  def coin_already_add(code)
    coin = Coin.find_by_code(code)
    return false unless coin
    user_coins.where(coin_id: coin.id).exists?
  end

  def under_limit
    (user_coins.count < 5)
  end

  def can_add(code)
    under_limit && !coin_already_add(code)
  end

  def self.search(param)
    param.strip!
    param.downcase!
    send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless send_back
    send_back
  end

    def self.first_name_matches(param)
      matches('first_name', param)
    end

    def self.last_name_matches(param)
      matches('last_name', param)
    end

    def self.email_matches(param)
      matches('email', param)
    end

    def self.matches(field_name, param)
      User.where("#{field_name} like ?", "%#{param}%")
    end

    def except_current_user(users)
      users.reject { |user| user.id == self.id }
    end

    def not_friends_with?(friend_id)
      friendships.where(friend_id: friend_id).count < 1
    end

end
