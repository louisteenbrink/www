module ProjectsHelper
  def card_url(project)
    cloudinary_url(project["cloudinary_image_id"], width: 700, height:365, format: 'jpg', quality: 40)
  end
end
