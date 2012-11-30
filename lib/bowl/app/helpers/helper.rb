
helpers do
  def app_name
    "Bowl"
  end

  def app_root
    "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{env['SCRIPT_NAME']}"
  end

  def url(obj)
    return "#{app_root}/plugin/#{obj.name}" if obj.class == Plugin
  end
end
