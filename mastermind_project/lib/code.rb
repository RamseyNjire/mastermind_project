class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(array)
    array.all?{ |peg| POSSIBLE_PEGS.keys.include?(peg.upcase)} ? true : false
  end

end
