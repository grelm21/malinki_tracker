module PagesHelper
  def date_dict(date)
    date.today? ? 'сегодня' : date.strftime('%d.%m.%Y').concat(" (#{l(date, format: '%a').downcase})")
  end
end
