require_relative "code"
require "byebug"

class Mastermind

    def initialize(length)
        @secret_code = Code.random(length)
    end

end
