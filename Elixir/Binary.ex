defmodule Binary do

  def to_binary1(n) do
    case n do
      0 -> []
      n -> append(to_binary1(div(n,2)), [rem(n,2)])
    end
   end

  def append(l1,l2) do
    case l1 do
      [] -> l2
      [h|t] -> [h|append(t,l2)]
    end
  end


  def to_binary2(n) do to_binary2(n, []) end

  def to_binary2(0, b) do b end

  def to_binary2(n, b) do
    to_binary2(div(n, 2), [rem(n, 2) | b])
  end


  def to_integer(x) do
    to_integer(x, 0)
  end

  def to_integer([], n) do
    n
  end

  def to_integer([x | r], n) do
    to_integer(r, x + (n*2))
  end


end
