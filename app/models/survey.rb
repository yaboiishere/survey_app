class Survey < ApplicationRecord
  validates :title, presence: true
  validates :questions, presence: true

  has_many :questions, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :questions, allow_destroy: true
end
