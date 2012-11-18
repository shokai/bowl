
def plugins
  @@plugins ||=
    (
     plugins = {}
     Plugin.list.each do |name, path|
       pl = Plugin.new name
       plugins[name] = pl
       CometIO.on "__fishbowl_plugin_#{name}" do |data, session_id|
         pl.emit(:call, data, session_id)
       end
     end
     plugins
     )
end

plugins
