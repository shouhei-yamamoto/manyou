class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  enum status:{未着手:0,着手中:1,完了:2}
  scope :name_search, -> (params) {where('(name LIKE ?)',"#{params[:task][:name]}")}
  scope :status_search, -> (params) {where(status: params[:task][:status])}
end
