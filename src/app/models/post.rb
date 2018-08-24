class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :marks, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
end
