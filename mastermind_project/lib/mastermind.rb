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

    def ask_user_for_guess
        puts "Enter a code: "
        peg_string = gets.chomp

        guessed_code = Code.from_string(peg_string)

        print_matches(guessed_code)

        @secret_code == guessed_code
    end

end

