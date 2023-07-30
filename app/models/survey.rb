class Survey < ApplicationRecord
  validates :title, :questions, presence: true
  validates :questions, length: { minimum: 1, message: 'must have at least one question' }

  has_many :questions, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :questions, allow_destroy: true
end
