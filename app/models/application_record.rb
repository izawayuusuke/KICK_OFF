class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :recent, -> { order(created_at: :desc) }
  scope :limited, -> { where(created_at: Time.current.prev_year..Time.current) }
  scope :paginate, -> (params, i) { page(params[:page]).without_count.per(i) }
  scope :exclude, -> (current_user_id) { where.not(user_id: current_user_id) }
end
