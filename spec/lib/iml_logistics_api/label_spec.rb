describe ImlLogisticsApi::Label do
  it 'renders label' do
    label = build(:label)
    html = nil
    expect {html = ImlLogisticsApi::Label.render(label)}.not_to raise_error
    # File.open('/home/nu-hin/Desktop/iml.html', 'w') { |file| file.write(html) }
  end

  it 'renders multiple labels' do
    labels = build_list(:label, 8)
    html = nil
    expect {html = ImlLogisticsApi::Label.render(labels)}.not_to raise_error
    # File.open('/home/nu-hin/Desktop/iml_labels.html', 'w') { |file| file.write(html) }
  end
end
