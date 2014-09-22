describe ImlLogisticsApi::Message do
  it 'parses xml' do
    msg_a = build(:message)
    xml = msg_a.to_xml
    msg_b = described_class.from_xml(xml)
    expect(msg_b.recipient).to eq(msg_a.recipient)
    expect(msg_b.sender).to eq(msg_a.sender)
    expect(msg_b.reference).to eq(msg_a.reference)

    p msg_a
    p msg_b
  end
end
