defmodule Conc do

  def sum({:leaf,n}) do n end

  def sum({:node,left,right}) do

    self = self()
    spawn(fn()-> n = sum(left); send(self,n) end)
    spawn(fn()-> n = sum(right); send(self,n) end)

    receive do
      n1 ->
        receive do
          n2 ->
            n1+n2
        end
    end
  end


  def closed(s) do
    receive do
      {:add, x} -> closed(s + x)
      :open -> open(s)
      :done -> IO.puts("Sum #{s}")
    end
  end

  def open(s) do
    receive do
      {:sub, x} -> open(s - x)
      {:mul, x} -> open(s * x)
      :close -> closed(s)
    end
  end



end
