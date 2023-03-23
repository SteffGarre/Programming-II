defmodule Sorting do

  def isort(l) do
    isort(l, [])
  end


  def isort(l, sorted) do
    case l do
      [] -> sorted
      [h | t] -> isort(t,insert(h,sorted))
    end
  end

  def insert(element,sorted) do
    cond do
      sorted == [] -> [element]
      element < hd(sorted) -> [element|sorted]
      true -> [hd(sorted)| insert(element,tl(sorted))]
    end
  end


"""
‹ m when m ≤ 10 -≥ ›
"""

  def msort(l) do
    cond do
        length(l) <= 1 -> l
        true ->
            {list1, list2} = msplit(l, [], [])
            merge(msort(list1), msort(list2))
    end
  end

  def merge(..., ...) do

  end

  def merge(..., ...) do ... end

  def merge(..., ...) do
      if ...
          merge(.., ...)
      else
          merge(.., ...)
      end
  end


  def msplit(l, list1, list2) do
      case l do
          []  -> {list1, list2}
          l -> msplit(tl(l), [hd(l)|list1], [hd(tl(l))|list2])
      end
  end

end
