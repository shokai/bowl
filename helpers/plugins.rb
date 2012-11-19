
helpers do
  def plugin_sample_code(plugin)
    post_data = {};
    plugin.fields.each do |name,field|
      post_data[name] = field[:default]
    end

    ["<script src=\"#{fishbowl_js}\">",
     "<script type=\"text/javascript\">",
     "  fishbowl.plugin(\"#{plugin.name}\", #{post_data.to_json});",
     "</script>"].join("\n")
  end
end

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
