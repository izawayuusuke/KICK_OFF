module ApplicationHelper
  def time_format(datetime)
    time_ago_in_words(datetime) + "前"
  end
end
