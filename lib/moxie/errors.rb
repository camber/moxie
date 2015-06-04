module Moxie
  Error    = Class.new(StandardError)
  NotFound = Class.new(Error)
  Exists   = Class.new(Error)
end

