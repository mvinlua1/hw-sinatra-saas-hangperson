class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # Get a word from remote "random word" service

  def initialize()
    @word = ''
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess character
    # raise error if invalid
    raise ArgumentError if !character.is_a? String or character.length != 1 or character =~ /^[^a-z]$/i
    character.downcase!
    return false if @guesses.include? character or @wrong_guesses.include? character
    if @word.include? character then @guesses << character
    else @wrong_guesses << character
    end
    true
  end
  
  def word_with_guesses
    ret = ''
    @word.each_char do |c|
      if @guesses.include? c then ret << c
      else ret << '-'
      end
    end
    ret
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    @word.each_char do |c|
      return :play unless @guesses.include? c
    end
    :win
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
