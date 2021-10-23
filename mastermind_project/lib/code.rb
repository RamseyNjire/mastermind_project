require 'byebug'

class Code
  attr_reader :pegs
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(array)
    array.all?{ |peg| POSSIBLE_PEGS.keys.include?(peg.upcase)} ? true : false
  end

  def self.random(length)
    Code.new(Array.new(length){POSSIBLE_PEGS.keys.sample})
  end

  def self.from_string(peg_string)
    Code.new(peg_string.chars)
  end


  def initialize(peg_array)
    raise "One or more of the characters is not a valid peg" unless Code.valid_pegs?(peg_array)
    @pegs = peg_array.map!{ |peg| peg.upcase }
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(code)
    count = 0
    code.pegs.each_with_index{ |peg, index| count += 1 if peg == self[index] }
    count
  end

  def num_near_matches(code)
    count = 0
    duplicate_code = Marshal.load(Marshal.dump(code))
    duplicate_self = Marshal.load(Marshal.dump(self))
    failed_matches_code_array = []
    failed_matches_self_array = []
    count = 0
    iteration_count = duplicate_code.length

    # first let's remove all the exact matches and extract the non-matchers
    # to separate arrays for further analysis.

    while true
      peg = duplicate_code.pegs.first
      if peg == duplicate_self[0]
        duplicate_code.pegs.delete_at(0)
        duplicate_self.pegs.delete_at(0)
      else
        failed_matches_code_array << peg
        failed_matches_self_array << duplicate_self[0]
        duplicate_code.pegs.delete_at(0)
        duplicate_self.pegs.delete_at(0)
      end
      iteration_count -= 1
      break if iteration_count == 0
    end

    # Now that I have arrays of pegs that failed the exact_match test, I can test these
    # for near matches

    while true
      peg = failed_matches_code_array.first
      if failed_matches_self_array.include?(peg)
        failed_matches_code_array.delete_at(0)
        failed_matches_self_array.delete_at(failed_matches_self_array.find_index(peg))
        count += 1
      else
        failed_matches_code_array.delete_at(0)
        # failed_matches_self_array.delete_at(0)
      end
      break if failed_matches_code_array.length == 0
    end

    count
    
  end

  def ==(code)
    self.num_exact_matches(code) == code.length ? true : false
  end
end

# code = Code.new(%w(R G R B))

# other_code = Code.new(%w(Y Y Y G))

# p code.num_near_matches(other_code)
