module ApplyHelper
  def apply_row(param, type, label, placeholder, icon)
    {
      placeholder: placeholder,
      type: type,
      label: label,
      param: param.to_s,
      error: @application.errors.messages[param].try(:join, ', '),
      value: @application.send(param),
      icon: "mdi mdi-#{icon}"
    }
  end
end
