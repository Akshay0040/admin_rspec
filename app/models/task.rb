# app/models/task.rb
class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
end
