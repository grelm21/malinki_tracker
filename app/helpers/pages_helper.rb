module PagesHelper
  def date_dict(date)
    day = date.today? ? ' (сегодня)' : " (#{l(date, format: '%a').downcase})"
    date.strftime('%d.%m.%Y').concat(day)
  end
end
