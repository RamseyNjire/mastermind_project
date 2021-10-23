require_relative "code"
require "byebug"

class Mastermind
    attr_accessor :secret_code
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(code)
        puts "#{@secret_code.num_exact_matches(code)}"
        puts "#{@secret_code.num_near_matches(code)}"
    end

end

# mastermind = Mastermind.new(4)

# mastermind.secret_code = (Code.new(["R", "G", "R", "B"]))

# code_1 = Code.new(["R", "Y", "Y", "B"])

# code_2 = Code.new(["Y", "Y", "Y", "G"])

# p mastermind.print_matches(code_1)

