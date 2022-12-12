dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(string, dictionary)
    #results hash
    results = Hash.new()
    dictionary.each do |word|
        #if statement so that words with 0 matches do not append
        if string.scan(word).length > 0
            #add words with matches of #scan to results hash
            results[word] = string.scan(word).length
        end
    end
end

substrings("below", dictionary)