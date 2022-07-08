# frozen_string_literal: true

# Application helper
module ApplicationHelper
  def active_class(path)
    if request.path == path
      'active'
    else
      ''
    end
  end

  def debtor_name(debtor_id)
    debtor = Debtor.find(debtor_id)
    debtor[:full_name]
  end
end
