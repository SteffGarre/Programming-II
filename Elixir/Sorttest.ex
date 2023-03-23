defmodule Sorttest do

  def merge_test(l) do
    {list1, list2} = msplit(l, [], [])
    list1
    list2
  end

  def msplit(l, list1, list2) do
      case l do
          _ -> {[h], []}
          _  -> msplit(t, [h|list1], [hd(t)|list2])
      end
  end

end
