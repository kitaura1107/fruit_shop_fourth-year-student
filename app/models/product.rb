class Product < ApplicationRecord
  # 関連付け
  has_many :orders
  
  validates :name, presence: true, uniqueness: true  # 商品名は必須で一意
  validates :price, presence: true                   # 価格は必須
end
