class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :login, presence: true, uniqueness: true
end
