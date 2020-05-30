module ApplicationHelper
  # 投稿時間を現在時刻から計算して表示する
  def time_format(datetime)
    time_ago_in_words(datetime, include_seconds: true) + "前"
  end
end
