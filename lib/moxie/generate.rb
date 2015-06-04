module Moxie
  class Generate
    def self.id
      SecureRandom.hex[0,8]
    end

    def self.version
      Time.now.strftime('%Y%m%dT%H%M%S')
    end

  end
end

