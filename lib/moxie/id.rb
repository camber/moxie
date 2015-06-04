module Moxie
  class ID
    def self.generate
      SecureRandom.hex[0,8]
    end
  end
end

