if Rails.env.production?
  POSITIONS = YAML.load_file(Rails.root.join("data/positions.yml"))
else
  POSITIONS = nil
end
