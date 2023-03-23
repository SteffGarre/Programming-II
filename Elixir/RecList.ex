defmodule RecList do

  def nth(n, l) do
    case n do
      0 -> hd(l)
      n -> nth((n-1), tl(l))
    end
  end


  def takeFirst(l) do
    hd(l)
  end


  def remFirst(l) do
    tl(l)
  end


  def len(l) do
    case l do
      [] -> 0
      l -> 1 + len(tl(l))
    end
  end


  def sum(l) do
    case l do
      [] -> 0
      l -> hd(l) + sum(tl(l))
    end
  end


  def duplicate (l) do
    case l do
      [] -> []
      l  -> [hd(l)] ++ [hd(l)| duplicate(tl(l))]
    end
  end


  def add(x,l) do
    cond do
      x == hd(l) -> l
      l == [hd(l)|[]] -> [hd(l),x]
      true -> [hd(l)|add(x,tl(l))]
    end
  end


  def remove(x,l) do
    cond do
      [] == l -> []
      x == hd(l) -> remove(x,tl(l))
      true -> [hd(l)|remove(x,tl(l))]
    end
  end


  def unique(l) do
    cond do
      [] == l -> []
      true ->[hd(l)|unique(remove(hd(l),l))]
    end
  end

  def append(list1,list2) do
    case list1 do
      [] -> list2
      [h|t] -> [h|append(t,list2)]
    end
  end


@doc """
 Nedan är enligt gitbook för reverse list och performance analysis
"""


  def nreverse([]) do
    []
  end

  def nreverse([h|t]) do
    r = nreverse(t)
    append(r, [h])
  end


  def reverse(l) do
    reverse(l, [])
  end

  def reverse([], r) do
    r
  end

  def reverse([h|t], r) do
    reverse(t, [h|r])
  end



  def bench() do
  ls = [16, 32, 64, 128, 256, 512]
  n = 100
  # bench is a closure: a function with an environment.
  bench = fn(l) ->
    seq = Enum.to_list(1..l)
    tn = time(n, fn -> nreverse(seq) end)
    tr = time(n, fn -> reverse(seq) end)
    :io.format("length: ~10w  nrev: ~8w us    rev: ~8w us~n", [l, tn, tr])
  end

  # We use the library function Enum.each that will call
  # bench(l) for each element l in ls
  Enum.each(ls, bench)
end

  # Time the execution time of the a function.
  def time(n, fun) do
    start = System.monotonic_time(:milliseconds)
    loop(n, fun)
    stop = System.monotonic_time(:milliseconds)
    stop - start
  end

  # Apply the function n times.
  def loop(n, fun) do
    if n == 0 do
      :ok
    else
      fun.()
      loop(n - 1, fun)
    end
  end

end
