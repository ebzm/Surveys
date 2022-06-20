# frozen_string_literal: true

class GuestUser
  def guest?
    true
  end

  def employee?
    false
  end

  def employer?
    false
  end

  def admin?
    false
  end
end
