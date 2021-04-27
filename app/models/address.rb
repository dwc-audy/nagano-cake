class Address < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/i }
  validates :address, presence: true

  def address_all
    name + "〒" + postal_code + " " + address
  end
end
