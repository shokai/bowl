meta :description => "open URL on web browser for Mac OSX.",
     :author      => "Sho Hashimoto <hashimoto@shokai.org>"

data do
  field "url", :type => String, :default => "http://shokai.org"
end

call do
  raise ArgumentError, 'invalid URL' unless url =~ Regexp.new("^https?://.+$")
  puts cmd = "open #{url}"
  system cmd
end
