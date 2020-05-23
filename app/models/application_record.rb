class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :recent, -> { order(created_at: :desc) }
  scope :paginate, -> (params, i) { page(params[:page]).without_count.per(i) }
end
