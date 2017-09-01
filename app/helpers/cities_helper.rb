module CitiesHelper
  # def lead_teachers(city)
  #   lead_teachers_slugs = Static::LEAD_TEACHERS[city.slug.to_sym].nil? ? [] : Static::LEAD_TEACHERS[city.slug.to_sym]
  #   lead_teachers = city.current_batch.teachers
  #     .select { |teacher| lead_teachers_slugs.include?(teacher.user.github_nickname) }
  #     .sort_by { |teacher| lead_teachers_slugs.index(teacher.user.github_nickname) }
  # end

  def next_open_batch_date(city)
    city.next_batches.find { |b| b.apply_status ==  "open_for_registration" }.starts_at.to_date
  end
end
