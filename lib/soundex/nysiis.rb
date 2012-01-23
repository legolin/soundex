module Soundex
  class Nysiis

    #
    # Reference doc:
    # https://en.wikipedia.org/wiki/New_York_State_Identification_and_Intelligence_System
    #

    def self.convert(word)
      str = word.upcase
      begin
        str.strip!
        str.gsub!(/[^A-Z ]/,"")
        str.gsub!(/ +(JR|SR)$/,"")
        str.gsub!(/ +(I|V|X|L|C|D|M)+$/,"")
        str.gsub!(/ /,"")

        return '' if str == ''

        # 1. Translate first characters of name:
        # => MAC → MCC, KN → NN, K → C, PH → FF, PF → FF, SCH → SSS
        {
          /^MAC/      => "MCC",
          /^KN/       => "NN",
          /^K/        => "C",
          /^(PH|PF)/  => "FF",
          /SCH/       => "SSS"
        }.each do |r,s|
          break if str.sub!(r,s)
        end

        # 2. Translate last characters of name:
        # => EE → Y, IE → Y, DT, RT, RD, NT, ND → D
        str.sub!(/(EE|IE)$/,"Y")
        str.sub!(/(DT|RT|RD|NT|ND)$/,"D")

        # 3. First character of key = first character of name.
        first_char = str[0,1]
        str = str[1,str.length]

        if str.length > 0
          # 4. Translate remaining characters by following rules,
          #    incrementing by one character each time:
          # => EV → AF else A, E, I, O, U → A
          # => Q → G, Z → S, M → N
          # => KN → NN else K → C
          # => SCH → SSS, PH → FF
          # => H → If previous or next is nonvowel, previous.
          # => W → If previous is vowel, previous. (A is the only vowel left)
          str.gsub!(/EV/, "AF")
          str.gsub!(/[AEIOU]/,"A")
          str.gsub!(/Q/, "G")
          str.gsub!(/Z/, "S")
          str.gsub!(/M/, "N")
          str.gsub!(/KN/, "NN")
          str.gsub!(/K/, "C")
          str.gsub!(/SCH/, "SSS")
          str.gsub!(/PH/, "FF")
          str.gsub!(/([^AEIOU])H/, $1) if $1
          str.gsub!(/(.)H[^AEIOU]/, $1) if $1
          str.gsub!(/AW/, "A")

          # 4. CONTINUED
          # => Add current to key if current is not same as the last key character.
          str.squeeze!     #everything was done in place, so squeeze out the duplicates
        else
          str = ''
        end
        str = first_char + str

        # 5. If last character is S, remove it.
        # 6. If last characters are AY, replace with Y.
        # 7. If last character is A, remove it.
        str.sub!(/(S|A)$/,"")
        str.sub!(/AY$/,"Y")

        return str
      rescue Exception => e
        raise Exceptions::NysiisConversionError, "Error converting string: `#{word}`"
      end

    end
  end
end