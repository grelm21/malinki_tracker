module UsersHelper
  def user_status(user)
    user.approved? ? 'approved' : 'not_approved'
  end

  def user_status_dict(user)
    { approved: 'подтвержден', not_approved: 'не подтвержден' }[user_status(user).to_sym]
  end

  def user_status_decorator(user)
  { approved: 'text-info', not_approved: 'text-warning' }[user_status(user).to_sym].html_safe
  end
end
