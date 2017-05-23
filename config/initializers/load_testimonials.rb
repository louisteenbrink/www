if Rails.env.production?
  TESTIMONIALS = YAML.load_file(Rails.root.join("data/testimonials.yml"))
else
  TESTIMONIALS = nil
end