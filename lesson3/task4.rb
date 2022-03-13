vowels = ["a", "e", "i", "o", "u"]
vowel_positions = {}
vowels.each do |vowel|
  position = vowel.bytes.first - "a".bytes.first + 1
  vowel_positions[vowel] = position
end

vowel_positions