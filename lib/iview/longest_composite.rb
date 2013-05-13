module Iview
  class LongestComposite
    attr_reader :word_list
    def initialize( word_list = [] )
      @word_list = word_list
    end

    def detect
      fully_composite_words.reduce(nil) do |longest_word, word|
        longest_word_length = longest_word.nil? ? -1 : longest_word.length
        word_length = word.length
        if word_length >= longest_word_length
          longest_word = word
        end
        longest_word
      end
    end

    private

    def fully_composite_words
      results = []

      word_dups.each_pair do |word, word_index|
        previous_index = word_index - 1
        previous_word = sorted_words[ previous_index ]
        if shortened_word = remainder( word, previous_word )
          results << word if "" == shortened_word || resolve( shortened_word )
        end
      end

      return results
    end

    def resolve( target_word )
      sorted_words.each do |possible_start_word|
        if got = remainder( target_word, possible_start_word )
          return true if "" == got
          return resolve( got )
        end
      end
      return false
    end

    def remainder(target_word, start_word)
      if match = target_word.match(/^#{start_word}(.*)$/)
        return match[1]
      else
        return nil
      end
    end

    def word_dups
      @word_dups ||= get_word_dups
    end

    MIN_WORDS = 1
    INITIAL_INDEX = 0
    def get_word_dups
      results = {}
      return results unless num_words > MIN_WORDS

      # initialize the loop vars:
      current_word = sorted_words[ INITIAL_INDEX ]
      current_word_length = current_word.length

      (INITIAL_INDEX..penultimate_word_count).each do |index|
        next_index = index + 1
        next_word = sorted_words[ next_index ]
        next_word_length = next_word.length

        # A dup occurs when next_word starts with current_word
        if next_word_length >= current_word_length && next_word.start_with?( current_word )
          results[ next_word ] = next_index
        end

        # This loop's next_word becomes the next loop's current_word
        current_word = next_word
        current_word_length = next_word_length
      end

      return results
    end

    # slow but now we can check if sorted_words[n] includes sorted_words[n-1]
    def sorted_words
      @sorted_words ||= word_list.sort{|a,b| a <=> b }
    end

    def penultimate_word_count
      num_words - 2
    end
    def num_words
      @num_words ||= @word_list.length
    end
  end
end
