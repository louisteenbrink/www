module ApplyHelper
  def apply_row(param, mandatory, type, label, placeholder, icon, tabindex, options = {})
    row = {
      placeholder: placeholder,
      mandatory: mandatory,
      tabindex: tabindex,
      type: type,
      label: label,
      param: param.to_s,
      error: @application.errors.messages[param].map(&:html_safe).try(:join, ', '),
      value: @application.send(param),
      icon: icon.starts_with?("fa") ? "fa #{icon}" : "mdi mdi-#{icon}"
    }
    row.merge(options)
  end

  def apply_rows
    [
      apply_row(:first_name, true, :text, t("applies.new.first_name"), "Alan", "account", 1),
      apply_row(:last_name, true, :text, t("applies.new.last_name"), "Turing", "format-text", 2),
      apply_row(:age, true, :text, t("applies.new.age"), "42", "crown", 3),
      apply_row(:email, true, :email, "Email", "alan@turing.com", "email-open", 4),
      apply_row(:phone, true, :tel, t("applies.new.phone"), "+33612345678", "cellphone-iphone", 5),
      apply_row(:source, true, :text, t("applies.new.source"), t("applies.new.source_placeholder"), "tag", 6),
      apply_row(:linkedin, false, :text, t("applies.new.linkedin_html"), t("applies.new.linkedin_placeholder"), "fa-linkedin", 7),
      apply_row(:codecademy_username, false, :text, t("applies.new.codecademy_username_html"), t("applies.new.codecademy_username_placeholder"), "fa-code", 8),
      apply_row(:motivation, true, :textarea, t("applies.new.motivation"), t("applies.new.motivation_placeholder"), "content-paste", 9, { minMotivLength: Apply::MININUM_MOTIVATION_LENGTH, singular_motivation_tip: t('applies.new.motivation_tip', count: 1), plural_motivation_tip: t('applies.new.motivation_tip', count: 140), })
    ]
  end
end
