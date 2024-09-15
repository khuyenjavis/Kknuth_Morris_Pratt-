def kmp_pattern_processing(pattern)
  m = pattern.length
  kmp_table = Array.new(m, 0)
  prefix_end = 0
  suffix_end = 1

  while suffix_end < m
    if pattern[prefix_end] == pattern[suffix_end]
      prefix_end += 1
      kmp_table[suffix_end] = prefix_end
      suffix_end += 1
    elsif prefix_end != 0
      prefix_end = kmp_table[prefix_end - 1]
    else
      kmp_table[suffix_end] = 0
      suffix_end += 1
    end
  end

  kmp_table
end

def kmp_search(text, pattern)
  n = text.length
  m = pattern.length
  kmp_table = kmp_pattern_processing(pattern)
  text_pos = 0
  pattern_pos = 0

  while text_pos < n
    if pattern[pattern_pos] == text[text_pos]
      pattern_pos += 1
      text_pos += 1
    end

    if pattern_pos == m
      puts "Pattern found at index #{text_pos - pattern_pos}"
      pattern_pos = kmp_table[pattern_pos - 1]
    elsif text_pos < n && pattern[pattern_pos] != text[text_pos]
      if pattern_pos != 0
        pattern_pos = kmp_table[pattern_pos - 1]
      else
        text_pos += 1
      end
    end
  end
end
