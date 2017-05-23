require 'spec_helper'
require_relative '../lib/sentence_composer'
require 'rspec'

describe 'sentence_composer' do
  it "should return an array of valid strings for: 'abcdefg'" do
    input_str = "abcdefg"
    expected = ["abcd e fg", "a bcd e fg", "a bc def g"]

    expect(sentence_composer(input_str)).to eq expected
  end

  it "should return an array with 1 valid string for 'abcc'" do
    input_str = "abcc"
    expected = ["a bc c"]

    expect(sentence_composer(input_str)).to eq expected
  end

  it "should return an array with 1 valid string for 'aBcC'" do
    input_str = "aBcC"
    expected = ["a bc c"]

    expect(sentence_composer(input_str)).to eq expected
  end

  it "should return an array of valid strings for: 'abcdefgacdef'" do
    input_str = "abcdefgacdef"
    expected = ["abcd e fg ac def", "a bcd e fg ac def", "a bc def g ac def"]

    expect(sentence_composer(input_str)).to eq expected
  end

  it "should return an array of valid strings for: 'ecdefghabcd'" do
    input_str = "ecdefghabcd"
    expected = ['e cde fg h abcd', 'e c def g h abcd']

    expect(sentence_composer(input_str)).to eq expected
  end

  it "should return an empty array for an invalid String" do
    input_str = "abcd"
    expected = []

    expect(sentence_composer(input_str)).to eq expected
  end

  it "should return an empty array if input isn't a String" do
    input_str = (rand * 100).floor
    expected = []

    expect(sentence_composer(input_str)).to eq expected
  end

  it "should return an empty array if input is an empty String" do
    input_str = ''
    expected = []

    expect(sentence_composer(input_str)).to eq expected
  end
end

describe 'valid_word?' do
  context "should return true if a given String is in the Dictionary" do
    specify 'for noun: abcd' do
      str = 'abcd'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for noun: c' do
      str = 'c'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for noun: def' do
      str = 'def'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for noun: h' do
      str = 'h'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for noun: ij' do
      str = 'ij'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for noun: cde' do
      str = 'cde'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for verb: bc' do
      str = 'bc'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for verb: fg' do
      str = 'fg'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for verb: g' do
      str = 'g'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for verb: hij' do
      str = 'hij'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for verb: bcd' do
      str = 'bcd'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for article: a' do
      str = 'a'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for article: ac' do
      str = 'ac'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
    specify 'for article: e' do
      str = 'e'
      expected = true
      expect(valid_word?(str)).to eq expected
    end
  end

  context "should return false if the input isn't in the Dictionary" do
    specify 'for x' do
      str = 'x'
      expected = false
      expect(valid_word?(str)).to eq expected
    end
    specify 'for 3' do
      str = 3
      expected = false
      expect(valid_word?(str)).to eq expected
    end
    specify "for ['nope']" do
      str = ['nope']
      expected = false
      expect(valid_word?(str)).to eq expected
    end
    specify 'for cd' do
      str = 'cd'
      expected = false
      expect(valid_word?(str)).to eq expected
    end
  end

  describe 'sentence_validator' do
    context "should return the String if it's a valid sentence" do
      specify "for test string: 'a bcd e fg'" do
        sentence = 'a bcd e fg'
        expected = 'a bcd e fg'
        expect(sentence_validator(sentence)).to eq expected
      end
      specify "for test string: 'e fg ac'" do
        sentence = 'e fg ac'
        expected = 'e fg ac'
        expect(sentence_validator(sentence)).to eq expected
      end
      specify "for test string: 'a bc c'" do
        sentence = 'a bc c'
        expected = 'a bc c'
        expect(sentence_validator(sentence)).to eq expected
      end
      specify "for test string: 'a fg e'" do
        sentence = 'a fg e'
        expected = 'a fg e'
        expect(sentence_validator(sentence)).to eq expected
      end
    end

    context "should return an empty array if it's an invalid sentence" do
      specify "for bogus test string: 'a fg x'" do
        sentence = 'a fg x'
        expected = []
        expect(sentence_validator(sentence)).to eq expected
      end
      specify "for test string with 1 Verb & 1 Article: 'bc ac'" do
        sentence = 'bc ac'
        expected = []
        expect(sentence_validator(sentence)).to eq expected
      end
      specify "for test string with only Nouns: 'def ij cde'" do
        sentence = 'def ij cde'
        expected = []
        expect(sentence_validator(sentence)).to eq expected
      end
      specify "for test string with only Articles: 'a ac e'" do
        sentence = 'a ac e'
        expected = []
        expect(sentence_validator(sentence)).to eq expected
      end
      specify "for test string with only Verbs: 'bc g bcd'" do
        sentence = 'bc g bcd'
        expected = []
        expect(sentence_validator(sentence)).to eq expected
      end
      specify "for test string with 1 noun & 1 article: 'ij ac'" do
        sentence = 'ij ac'
        expected = []
        expect(sentence_validator(sentence)).to eq expected
      end
    end
  end

  describe 'sentence_constructor' do
    context "should return an Array of valid words for given String" do
      specify "for test string: 'abcdefg'" do
        str = 'abcdefg'
        expected = ["abcd", "e", "fg"]
        expect(sentence_constructor(str)).to eq expected
      end
      specify "for test string: 'abcc'" do
        str = 'abcc'
        expected = ["a", "bc", "c"]
        expect(sentence_constructor(str)).to eq expected
      end
      specify "for test string: 'efgac'" do
        str = 'efgac'
        expected = ["e", "fg", "ac"]
        expect(sentence_constructor(str)).to eq expected
      end
    end

    context "should return false for a given String" do
      specify "for test string: 'abcx'" do
        str = 'abcx'
        expected = false
        expect(sentence_constructor(str)).to eq expected
      end
      specify "for test string: 'abcdefgacde'" do
        str = 'abcdefgacde'
        expected = false
        expect(sentence_constructor(str)).to eq expected
      end
    end
  end
end
