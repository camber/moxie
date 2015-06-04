module Moxie
  module Transforms
    Slug = lambda { |v|
      v.to_s.strip.downcase.gsub(/\s+/, ' ').gsub(/[^a-z1-9.]+/, '-')
    }
  end
end

