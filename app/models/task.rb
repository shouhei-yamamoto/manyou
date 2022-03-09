class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  enum status:{未着手:0,着手中:1,完了:2}
  scope :name_search, -> (name) {where("name LIKE ?", "%#{name}%")}
  scope :status_search, -> (status) {where(status: status)}
end
