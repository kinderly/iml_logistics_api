require 'nokogiri'

module ImlLogisticsApi
  module FileListResponse
    def self.parse(xml)
      doc = Nokogiri::XML(xml)
      doc.xpath('FileList/fileName').map(&:text)
    end
  end
end
