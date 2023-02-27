require_relative './word_suggestion/utils/dictionary'

module WordSuggestion
    class Suggestion
        WordSuggestion::Utils::Dictionary.index

        def initialize(word, dictionary = nil)
            @word = word
            @dictionary = dictionary
            WordSuggestion::Utils::Dictionary.index(@dictionary) unless dictionary.nil?
        end

        def get
            words = WordSuggestion::Utils::Dictionary.get_words(@word)
        end
    end
end