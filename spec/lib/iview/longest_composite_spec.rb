require 'spec_helper'

describe Iview::LongestComposite do
  let(:lc) { Iview::LongestComposite.new( ) }
  context "given no list of words" do
    describe "#word_list" do
      it "returns an empty list" do
        expect( lc.word_list ).to be_empty
      end
    end

    describe "#detect" do
      it "returns nil" do
        expect( lc.detect ).to be_nil
      end
    end
  end

  context "given a list of words" do
    let(:lc) { Iview::LongestComposite.new( word_list ) }
    context "given an empty-list of words" do
      let(:word_list) { [] }
      describe "#word_list" do
        it "returns an empty list" do
          expect( lc.word_list ).to be_empty
        end
      end
      describe "#detect" do
        it "returns nil" do
          expect( lc.detect ).to be_nil
        end
      end
    end
    context "given a list of non-overlapping words" do
      let(:word_list) {%w{one two three}}
      describe "#word_list" do
        it "returns the initial list" do
          expect( lc.word_list ).to eql( word_list )
        end
      end
      describe "#detect" do
        it "returns nil" do
          expect( lc.detect ).to be_nil
        end
      end
    end
    context "given a list of partially-overlapping words" do
      let(:word_list) {%w{one onetwo three threefour}}
      describe "#word_list" do
        it "returns the initial list" do
          expect( lc.word_list ).to eql( word_list )
        end
      end
      describe "#detect" do
        it "returns nil" do
          expect( lc.detect ).to be_nil
        end
      end
    end
    context "given a list of words, some of which are fully composite" do
      let(:word_list) {%w{one onetwo two twothree three threefour}}
      describe "#word_list" do
        it "returns the initial list" do
          expect( lc.word_list ).to eql( word_list )
        end
      end
      describe "#detect" do
        it "returns the longest fully composite word" do
          expect( lc.detect ).to eql( "twothree" )
        end
      end
    end
    context "given the books list of words (some of which are fully composite)" do
      let(:word_list) { %w{ cat banana dog nana walk walker dogwalker } }
      describe "#word_list" do
        it "returns the initial list" do
          expect( lc.word_list ).to eql( word_list )
        end
      end
      describe "#detect" do
        it "returns the longest fully composite word" do
          expect( lc.detect ).to eql( "dogwalker" )
        end
      end
    end
  end
end
