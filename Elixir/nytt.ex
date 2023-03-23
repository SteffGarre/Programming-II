defmodule Nytt do


  def test(list,value) do
    func = fn(a,b) ->
        cond do
          (b - a) > 0 -> {:ok, b - a}
          true -> :no
        end
      end
    higher(list,value,func)
  end

  def higher([], _, _) do [] end

  def higher([head|tail], value, func) do

    case func.(head, value) do
      {:ok, acc} -> [head|higher(tail, acc, func)]
      :no -> []
    end
  end


end
