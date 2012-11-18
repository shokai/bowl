require 'rubygems'
require 'event_emitter'
  
class Plugin

  def self.dir=(dir)
    @@dir = dir
  end

  def self.dir
    @@dir ||= File.expand_path '../plugins', File.dirname(__FILE__)
  end

  def self.list
    @@list ||=
      (
       h = {}
       Dir.glob(File.expand_path '*.rb', self.dir).each do |rb|
         name = rb.scan(/([^\/]+)\.rb$/)[0][0]
         h[name] = rb
       end
       h
       )
  end

  include EventEmitter
  attr_reader :name, :fields

  def initialize(name)
    @name = name
    @fields = Hash.new{|h,k|
      h[k] = {
        :index => lambda{ @fields.keys.size }.call,
        :type => String,
        :default => nil,
        :value => nil
      }
    }
    code = nil
    open(self.class.list[name]) do |f|
      code = f.read
    end
    raise IOError, "cannot read plug-in file \"#{name}\"" unless code
    instance_eval code
    
    this = self
    CometIO.on "__fishbowl_plugin_#{name}" do |data, session_id|
      this.emit(:call, data, session_id)
    end
  end

  def data(&block)
    raise ArgumentError, 'block not given' unless block_given?
    instance_eval &block
  end

  def field(name, params)
    params.each do |k,v|
      fields[name][k] = v
    end
  end

end


if __FILE__ == $0
  p Plugin.list
  wb = Plugin.new 'webbrowser'
  p wb.fields

  wb.emit :call, 'url' => 'http://shokai.org'
end
