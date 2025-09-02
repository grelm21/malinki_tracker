module ClassroomsHelper
  def classroom_status(classroom)
    return 'classroom-name'.html_safe if classroom.active?

    'classroom-name-inactive'.html_safe if classroom.inactive?
  end

  def schedule_num_days
    (1..6).to_a.push(0)
  end
end
