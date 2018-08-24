# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :marks, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  def apply_mark(value)
    self.marks_count += 1
    self.average_mark += (value - average_mark) / marks_count
  end
end
