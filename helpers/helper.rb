
helpers do
  def app_name
    "FishBowl"
  end

  def app_root
    "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{env['SCRIPT_NAME']}"
  end
end
