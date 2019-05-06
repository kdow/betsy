module ApplicationHelper
  def readable_date(date)
    return "[unknown]" unless date
    return ("<span class='date' title='".html_safe +
            date.to_s +
            "'>".html_safe +
            time_ago_in_words(date) +
            " ago</span>".html_safe)
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"
    when "error"
      "alert-danger"
    when "alert"
      "alert-warning"
    when "notice"
      "alert-info"
    else
      flash_type.to_s
    end
  end
end
