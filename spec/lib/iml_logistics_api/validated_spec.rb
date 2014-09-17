describe ImlLogisticsApi::Validated do
  before :each do
    @klass = Class.new.send(:include, described_class)
  end

  describe '#get_validator' do
    it 'handles alphabetical patterns' do
      validator = @klass.get_validator('a')
      expect(validator.call('abc')).to be_truthy

      validator = @klass.get_validator('an')
      expect(validator.call('abc12')).to be_truthy

      validator = @klass.get_validator('a')
      expect(validator.call('abc12')).to be_falsey

      validator = @klass.get_validator('an')
      expect(validator.call('abc12_%')).to be_truthy
    end

    it 'handles alphabetical patterns with max length' do
      validator = @klass.get_validator('a..2')
      expect(validator.call('abc')).to be_falsey
      expect(validator.call('ab')).to be_truthy

      validator = @klass.get_validator('an..5')
      expect(validator.call('abc12')).to be_truthy
      expect(validator.call('abc123')).to be_falsey
    end

    it 'handles alphabetical patterns with strict length' do
      validator = @klass.get_validator('a2')
      expect(validator.call('abc')).to be_falsey
      expect(validator.call('ab')).to be_truthy
      expect(validator.call('a')).to be_falsey

      validator = @klass.get_validator('an3')
      expect(validator.call('abc')).to be_truthy
      expect(validator.call('a1c')).to be_truthy
      expect(validator.call('ac')).to be_falsey
      expect(validator.call('a1')).to be_falsey
    end

    it 'handles numeric patterns' do
      validator = @klass.get_validator('n')
      expect(validator.call('123')).to be_truthy

      validator = @klass.get_validator('n')
      expect(validator.call('abc12')).to be_falsey

      validator = @klass.get_validator('n')
      expect(validator.call('312')).to be_truthy

      validator = @klass.get_validator('n')
      expect(validator.call('abc')).to be_falsey

      validator = @klass.get_validator('n')
      expect(validator.call('_121%')).to be_falsey
    end

    it 'handles numeric patterns with max length' do
      validator = @klass.get_validator('n..2')
      expect(validator.call('1')).to be_truthy
      expect(validator.call('12')).to be_truthy
      expect(validator.call('1')).to be_truthy
      expect(validator.call('12')).to be_truthy
      expect(validator.call('123')).to be_falsey
      expect(validator.call('1.2')).to be_falsey
    end

    it 'handles numeric patterns with strict length' do
      validator = @klass.get_validator('n2')
      expect(validator.call('1')).to be_falsey
      expect(validator.call('12')).to be_truthy
      expect(validator.call('1')).to be_falsey
      expect(validator.call('12')).to be_truthy
      expect(validator.call('123')).to be_falsey
      expect(validator.call('1.2')).to be_falsey
    end

    it 'handles numeric patterns with precision' do
      validator = @klass.get_validator('n..18,2')
      expect(validator.call('1')).to be_truthy
      expect(validator.call('12')).to be_truthy
      expect(validator.call('12')).to be_truthy
      expect(validator.call('123')).to be_truthy
      expect(validator.call('1.2')).to be_truthy
      expect(validator.call('1.22')).to be_truthy
      expect(validator.call('1.223')).to be_falsey
    end

    it 'raises on invalid pattern' do
      expect{@klass.get_validator('z..2')}.to raise_error ImlLogisticsApi::Exceptions::Error
    end
  end
end

