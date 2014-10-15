describe ImlLogisticsApi::ResponseRequest do
  it 'parsed xml' do
    xml_file = File.expand_path("../../../support/response_request.xml", __FILE__)
    xml = File.read (xml_file)
    puts xml
    @rr = nil
    expect {@rr = described_class.from_xml(xml)}.not_to raise_error

    expect(@rr.orders).to have_exactly(2).items

    p @rr
  end
end
