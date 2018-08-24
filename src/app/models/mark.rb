# frozen_string_literal: true

class Mark < ApplicationRecord
  A = 5
  B = 4
  C = 3
  D = 2
  E = 1

  belongs_to :post

  validates :value, presence: true, inclusion: { in: E..A }
end
