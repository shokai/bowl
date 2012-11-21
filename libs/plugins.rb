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
    @meta = {}
    @fields = Hash.new{|h,k|
      h[k] = {
        :name => nil,
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
  end

  def meta(meta=nil)
    if meta.kind_of? Hash
      @meta = meta
    else
      return @meta
    end
  end

  def data(&block)
    raise ArgumentError, 'block not given' unless block_given?
    instance_eval &block
  end

  def call(&block)
    raise ArgumentError, 'block not given' unless block_given?
    this = self
    CometIO.on "plugin_#{name}" do |data, session_id|
      this.fields.each do |name, field|
        data[name] = field[:default] if field[:default] and data[name].to_s.empty?
      end
      Hashie::Mash.new(data).instance_eval &block
    end
  end

  def field(name, params={})
    if Hashie::Mash.instance_methods.include? name.to_sym
      raise ArgumentError, "field \"#{name}\" is reserved."
    end
    fields[name][:name] = name
    params.each do |k,v|
      fields[name][k] = v
    end
  end

end
