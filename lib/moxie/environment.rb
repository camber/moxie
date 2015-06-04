module Moxie
  class Environment < Hashie::Trash
    extend Finders
    key 'environment'
  end
end

