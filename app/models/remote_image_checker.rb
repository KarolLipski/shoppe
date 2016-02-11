class RemoteImageChecker

  def initialize
    @site_prefix = 'http://madej.com.pl/zdjecia/'
    @extensions = %w(jpg jpeg JPG)
  end

  def get_valid_url(item_number)
    @extensions.each do |ext|
      url = @site_prefix + item_number + '.' + ext
      return url if file_exist?(url)
    end

    raise Exceptions::RemoteFileNotFound
  end

  def file_exist?(url)
    response = Net::HTTP.get_response(URI.parse(url))
    if response.code.to_f >= 200 && response.code.to_f < 400
      return true
    end
    return false
  end

end