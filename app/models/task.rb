class Task < ApplicationRecord
  validates :title, :presence => true

  # belongs_to(:user)
  belongs_to :user, counter_cache: true
end
