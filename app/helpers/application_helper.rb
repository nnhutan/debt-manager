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

  def style_for_body
    if logged_in?
      ''
    else
      # "background-image: url('https://media.istockphoto.com/photos/close-up-of-businesswoman-using-calculator-while-going-through-bills-picture-id1147332704?k=20&m=1147332704&s=612x612&w=0&h=tStkwPiNMt_Sy9Ieu1DsL9JbCjtPcul6h7uZzvRRZjs='); background-repeat: no-repeat; background-size: cover;"
      "background-image: url('https://www.sunbizsolutions.in/images/service/collections.jpg'); background-repeat: no-repeat; background-size: cover;"
    end
  end
end
