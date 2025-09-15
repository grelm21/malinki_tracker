module ClassroomsHelper
  def classroom_status(classroom)
    return 'classroom-name'.html_safe if classroom.active?

    'classroom-name-inactive'.html_safe if classroom.inactive?
  end

  def schedule_num_days
    (1..6).to_a.push(0)
  end

  def class_format_dict(class_format)
    {
      'multi' => 'группа',
      'single' => 'индивидуально'
    }[class_format]
  end

  def classroom_status_decorator(classroom)
    return { submit_text: 'удалить класс', new_status: 'inactive', class: 'button-alert' } if classroom.active?
    { submit_text: 'восстановить класс', new_status: 'active', class: 'button-success' } if classroom.inactive?
  end
end
