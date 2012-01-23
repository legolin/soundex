require 'soundex/exceptions'
require 'soundex/nysiis'

class String
  def nysiis
    self.split(' ').collect{|word| Soundex::Nysiis.convert(word)}.join(' ')
  end
end

class NilClass
  def nysiis
    ''
  end
end