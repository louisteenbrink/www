module ProjectsHelper
  def card_url(project)
    cl_image_path(cover_picture_path(project), width: 700, height: 365, crop: :fill, secure: true)
  end

  def thumbnail_url(project)
    cl_image_path(cover_picture_path(project), width: 320, height: 167, crop: :fill, secure: true)
  end

  def cover_picture_path(project)
    (project.cover_picture_url || project.og_image_url || "").split("upload/").last || ""
  end
end
