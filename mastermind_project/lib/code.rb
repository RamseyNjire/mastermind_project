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


  def initialize(peg_array)
    raise "One or more of the characters is not a valid peg" unless Code.valid_pegs?(peg_array)
    @pegs = peg_array.map!{ |peg| peg.upcase }
  end
end
