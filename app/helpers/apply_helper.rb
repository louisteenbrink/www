module ApplyHelper
  def apply_row(param, type, label, placeholder, icon, required = true)
    {
      placeholder: placeholder,
      type: type,
      label: label,
      param: param.to_s,
      error: @application.errors.messages[param].try(:join, ', '),
      required: required,
      value: @application.send(param),
      icon: "mdi mdi-#{icon}"
    }
  end
end
