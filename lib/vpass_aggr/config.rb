require 'yaml'
require 'erb'

module VpassAggr
  class Config
    attr_reader :data_dir, :payto_list
    def initialize()
      config = YAML.load(ERB.new(File.read('config/config.yaml')).result)
      @data_dir   = config['data_dir']
      @payto_list = config['payto_list']
    end
  end
end
