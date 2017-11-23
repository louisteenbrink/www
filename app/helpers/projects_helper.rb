module ProjectsHelper
  def card_url(project)
    cloudinary_url(project.cover_picture_url, width: 700, height: 365, format: 'jpg', quality: 40)
  end

  def thumbnail_url(project)
    cloudinary_url(project.cover_picture_url, width: 320, height: 167, format: 'jpg', quality: 20)
  end
end
