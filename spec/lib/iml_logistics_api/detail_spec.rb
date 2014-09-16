describe ImlLogisticsApi::Detail do
  before(:each) do
    @detail = build(:detail)
  end

  it 'is valid' do
    expect(@detail).to be_valid
  end

  it 'it serializes as XML' do
    expect{puts @detail.to_xml}.not_to raise_error
  end
end
