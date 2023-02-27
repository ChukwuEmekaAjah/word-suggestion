require 'json'

module WordSuggestion
    module Utils
        module Dictionary
            extend self
            @@index = {}
            @@words = nil
            @@ngram = 3


            def get
                @@words ||= File.open('./lib/word_suggestion/utils/dictionary.json', 'r') do |f|
                    JSON.parse(f.read).keys
                end
                @@words
            end

            def index(words = self.get, ngram = 3)
                @@words.each_with_index do |word, i|
                    chunk_word(word, ngram).each do |chunk|
                        @@index[chunk] ||= []
                        @@index[chunk] << i
                    end
                end
                
            end

            def get_words(word)
                matching_words = []
                matching_words_dict = Hash.new(0)
                chunk_word(word, @@ngram).each do |chunk|
                    score = 1
                    score = 0.333 if chunk[1] == '_'
                    score = 0.667 if chunk[2] == '_'
                    update_matching_words(matching_words_dict, @@index[chunk], score)
                end

                score_matching_words(word, matching_words_dict).filter {|k,v| k.length >= word.length }
            end

            private

            def update_matching_words(container, words_ids, score = 1)
                words_ids.each do |id|
                    container[id] += score
                end
                container
            end

            def score_matching_words(word, container)
                matching_words = Hash.new(0)
                container.each do |word_id, matches|
                    next if @@words[word_id].length < @@ngram
                    matching_words[@@words[word_id]] = (word.length / @@words[word_id].length.to_f) * matches
                end
                scoring = matching_words.sort_by {|k, v| -v }
                scoring[0 ... 10]
            end

            def filler(char = '_')
                '_'
            end

            def chunk_word(word, chunk_size)
                chunks = []
                i = 0
                while i < word.length
                    char = word[i]
                    chunk = word[i...(i + chunk_size)]
                    i += 1
                    break if chunk.length < chunk_size
                    
                    chunks << chunk
                end
                chunks
            end
        end
    end
end