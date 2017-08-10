class Api::User < Api::Record
  def self.all(link = nil)
    if link.blank?

    else
      users = self.new.extend(UserRepresenter).get(uri: link, as: "application/json")
    end
  end
end
