class Seller < ApplicationRecord
  has_many :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.build_from_github(auth_hash)
    seller = Seller.new
    seller.uid = auth_hash[:uid]
    seller.provider = "github"
    seller.username = auth_hash["info"]["name"]
    seller.email = auth_hash["info"]["email"]

    return seller
  end
end
