require 'barby'
require 'barby/barcode/ean_13'
require 'barby/outputter/svg_outputter'
require 'base64'
require 'erb'

module ImlLogisticsApi
  class Label
    attr_accessor :store_name, :region, :order_number

    def barcode=(val)
      b = val.to_s
      @barcode = b[0..11]
      @barby = Barby::EAN13.new(barcode)
      @barcode_with_checksum = @barby.data_with_checksum
    end

    def barcode
      @barcode
    end

    def barcode_with_checksum
      @barcode_with_checksum if @barcode_with_checksum
    end

    def barcode_svg(height = 75)
      @barby.to_svg(xdim: 2, margin: 0, height: 45)
    end

    def self.render(labels, template = nil)
      renderer = ERB.new(template || default_template)
      labels = labels.is_a?(Array) ? labels : [labels]
      @labels = labels.select{|l| l.is_a?(ImlLogisticsApi::Label)}
      renderer.result(binding)
    end

    def logo_base_64
      @logo ||= "data:image/png;base64,#{Base64.encode64(File.binread(self.class.logo))}"
    end

    protected

    def self.default_template
      File.read(default_erb)
    end

    def self.path(filename)
      File.join(File.dirname(File.expand_path(__FILE__)), filename)
    end

    def self.default_erb
      path('../templates/label.html.erb')
    end

    def self.logo
      path('../assets/logo.png')
    end
  end
end
