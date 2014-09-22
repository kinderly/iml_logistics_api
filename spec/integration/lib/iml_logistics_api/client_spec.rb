describe ImlLogisticsApi::Client, type: :integration do

  before(:each) do
    integration_yml = File.join(File.dirname(__FILE__), "../../integration.yml")
    @iml_credentials = YAML.load(File.read(integration_yml))
    @client = described_class.new(@iml_credentials['login'], @iml_credentials['password'], true)
  end

  describe '#folder_contents' do
    it 'works' do
      fileList = @client.folder_contents(:list)
      expect(fileList).not_to be_empty
      puts fileList
    end
  end

  describe '#get_file' do
    it 'works' do
      fileList = @client.folder_contents(:list)

      fileList.each do |file|
        res = @client.get_file(:list, file)
        expect(res).not_to be_nil
        puts file
        puts res
      end
    end
  end


end
