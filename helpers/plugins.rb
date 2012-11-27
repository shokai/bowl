
def plugins
  @@plugins ||=
    (
     plugins = {}
     Plugin.list.each do |name, path|
       begin
       plugins[name] = Plugin.new name
       rescue => e
         STDERR.puts e
         next
       end
     end
     plugins
     )
end

plugins
