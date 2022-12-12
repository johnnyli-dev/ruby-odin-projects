p "A".ord

def caesar_cipher(string, shift)
    numbers = []
    string.each_char do |chr|
        if chr.match?(/[a-z]/)
            if shift > 26
                shift %= 26
            end
            if chr.ord + shift > 96 + 26
                change = chr.ord + shift - 26
                numbers.push(change.chr)
            else
                change = chr.ord + shift
                numbers.push(change.chr)
            end
        elsif chr.match?(/[A-Z]/)
            if shift > 26
                shift %= 26
            end
            if chr.ord + shift > 65 + 26
                change = chr.ord + shift - 26
                numbers.push(change.chr)
            else
                change = chr.ord + shift
                numbers.push(change.chr)
            end
        else
            numbers.push(chr)
        end
    end
    numbers.join("")
end

p caesar_cipher("What a string!", 5)