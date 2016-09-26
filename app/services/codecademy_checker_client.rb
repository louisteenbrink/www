class CodecademyCheckerClient
  def ruby_progress(username)
    JSON.parse RestClient::Request.execute({
      method: :get,
      url: "https://codecademy-checker.herokuapp.com/api/ruby/#{username}",
    })
  rescue URI::InvalidURIError
    { "error" => { "message" => "#{username} is not a CodeCademy username" } }
  rescue RestClient::ResourceNotFound
    { "error" => { "message" => "Go to codecademy.com/profiles/me to get your username" } }
  end
end
