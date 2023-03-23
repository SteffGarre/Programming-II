defmodule CRC do

  def compute(seq) do
    gen = [1,0,1,1]
    seq = extend(seq)
    res = compute(seq,gen)
    IO.write("The code is: ")
    res
  end

  def extend([]) do[0,0,0] end

  def extend([h|t]) do
    [h|extend(t)]
  end



  def compute([a,b,c],_) do [a,b,c] end

  def compute([0|tail], gen) do
    compute(tail,gen)
  end

  def compute(seq,gen) do
    list = check(seq,gen)
    compute(list,gen)
  end



  def check(list,[]) do list end

  def check([h1|rest], [h2|gen]) when h1 == h2 do
    [0|check(rest,gen)]
  end

  def check([_|rest], [_|gen]) do
    [1|check(rest,gen)]
  end


end
