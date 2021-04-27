class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders, dependent: :destroy
  has_many :addresses

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def active_for_authentication?
    super && !is_deleted?
  end

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/i }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/i }
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/i }
  validates :address, presence: true
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/i }

  def self.search(column, value)
    Customer.where(Customer.sanitize_sql(["#{column} LIKE ?", "%#{value}%"]))
  end
end
