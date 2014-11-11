describe ImlLogisticsApi::BarcodeList do
  it 'parses_xml' do
    xml_file = File.expand_path("../../../support/barcode_list.xml", __FILE__)
    xml = File.read (xml_file)
    bl = nil

    expect{bl = described_class.from_xml(xml)}.not_to raise_error
    expect(bl.volumes).not_to be_empty
    expect(bl.volumes.first.barcode).not_to be_nil
    p bl
  end
end
