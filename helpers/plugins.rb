
def plugins
  @@plugins ||=
    (
     plugins = {}
     Plugin.list.each do |name, path|
       puts "load plugin \"#{name}\" - #{path}"
       begin
         plugins[name] = Plugin.new name
       rescue => e
         STDERR.puts e
         plugins[name] = e
         next
       end
     end
     plugins
     )
end

plugins
