module ClassroomsHelper
  def classroom_status(classroom)
    return 'classroom-name'.html_safe if classroom.active?

    'classroom-name-inactive'.html_safe if classroom.inactive?
  end
end
