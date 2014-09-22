require 'nokogiri'

module ImlLogisticsApi
  module FileListResponse
    def self.parse(xml)
      doc = Nokogiri::XML(xml)
      doc.xpath('FileList/fileName/text()')
    end
  end
end
