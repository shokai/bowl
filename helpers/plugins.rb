
def plugins
  @@plugins ||=
    (
     plugins = {}
     Plugin.list.each do |name, path|
       plugins[name] = Plugin.new name
     end
     plugins
     )
end

plugins
