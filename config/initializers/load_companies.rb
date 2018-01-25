if Rails.env.production?
  COMPANIES = YAML.load_file(Rails.root.join("data/companies.yml"))
else
  COMPANIES = nil
end
