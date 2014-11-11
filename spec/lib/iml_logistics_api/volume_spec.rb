describe ImlLogisticsApi::Volume do
  it 'parses_xml' do
    xml_file = File.expand_path("../../../support/volume.xml", __FILE__)
    xml = File.read (xml_file)
    vl = nil

    expect{vl = described_class.from_xml(xml)}.not_to raise_error
    expect(vl.barcode).not_to be_nil
    expect(vl.position).not_to be_nil
    expect(vl.encoded_barcode).not_to be_nil
    expect(vl.encoded_type).not_to be_nil
  end
end
