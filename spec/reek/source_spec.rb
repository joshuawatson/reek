require File.dirname(__FILE__) + '/../spec_helper.rb'

require 'reek/source'

include Reek

describe SourceList do

  describe 'with no smells in any source' do
    before :each do
      @src = Dir['lib/reek/*.rb'].to_source
    end

    it 'reports no smells' do
      @src.report.length.should == 0
    end

    it 'is empty' do
      @src.report.should be_empty
    end
  end

  describe 'with smells in one source' do
    before :each do
      @src = Source.from_pathlist(['spec/samples/inline.rb', 'lib/reek.rb'])
    end

    it 'reports some smells in the samples' do
      @src.report.length.should == 32
    end

    it 'is smelly' do
      @src.should be_smelly
    end

    it 'reports an UncommunicativeName' do
      @src.report.any? {|warning| warning.report =~ /Uncommunicative Name/}.should be_true
    end
  end
end
