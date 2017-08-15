module CitiesHelper
  def lead_teachers(city)
    lead_teachers_slugs = Static::LEAD_TEACHERS[city.slug.to_sym].nil? ? [] : Static::LEAD_TEACHERS[city.slug.to_sym]
    lead_teachers = city.current_batch.teachers
      .select { |teacher| lead_teachers_slugs.include?(teacher.user.github_nickname) }
      .sort_by { |teacher| lead_teachers_slugs.index(teacher.user.github_nickname) }
  end
end
