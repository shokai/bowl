
helpers do
  Plugin.list.each do |name, path|
    pl = Plugin.new name
    puts pl.name
  end
end
