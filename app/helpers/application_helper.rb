module ApplicationHelper
  def event_day_format(time)
    day = time.to_date
    if day == Date.today
      "今"
    elsif day == Date.yesterday
      "昨"
    else
      "<span class='date'>#{day.strftime('%-m/%-d')}</span>".html_safe + 
      "<span class='day'>#{day.strftime('%a')}</span>".html_safe
    end
  end

  def event_time_format(time)
    time.strftime("%H:%M")
  end

  def todo_event_time_format(time)
    time.strftime("%m-%d %H:%M")
  end

  def comment_event_time_format(time)
    time.strftime("%m-%d %H:%M")
  end
end
