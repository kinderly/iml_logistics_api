describe ImlLogisticsApi::ResponseRequest do
  it 'parses xml' do
    xml_file = File.expand_path("../../../support/response_request.xml", __FILE__)
    xml = File.read (xml_file)
    puts xml
    @rr = nil
    expect {@rr = described_class.from_xml(xml)}.not_to raise_error

    expect(@rr.orders).to have_exactly(2).items

    @rr.orders.each do |ord|
      p ord
    end
  end

  it 'parses barcode' do
    xml_file = File.expand_path("../../../support/response_request.xml", __FILE__)
    xml = File.read (xml_file)
    rr = described_class.from_xml(xml)
    rr.orders.each do |ord_r|
      expect(ord_r.barcode).not_to be_nil
      puts ord_r.barcode
    end
  end
end
