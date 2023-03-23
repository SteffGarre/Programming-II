defmodule High do

  def fib() do
    fn() -> fib(1,1) end
  end

  def fib(f1,f2) do
    [f1|fn()-> fib(f2, f1+f2) end]
  end
#---------------------------------------------------------------

  def sum_range(r) do
    reduce(r,{:cont,0},fn(a,b)-> {:cont,a+b} end)
  end

  def take(range,n) do
    reduce(range, {:cont,{:sofar, 0, []}},
      fn(x,{:sofar,s,acc}) ->
        s = s+1
        if s >= n do
          {:halt, [x|acc]}
        else
          {:cont, {:sofar, s, [x|acc]}}
        end
      end)
  end

  def head(range) do
    reduce(range,{:cont,:na}, fn(x,_)-> {:suspend, x} end)
  end

  def reduce(range,{:suspend,acc}, func)do
     {:suspended, acc, fn(cmd)-> reduce(range,cmd,func) end}
  end

  def reduce({:range, from, to}, {:cont,acc}, func) do
      if from <= to do
        reduce({:range, from+1, to}, func.(from,acc), func)
      else
        IO.write("* The sum of integers in defined range is: \n")
        {:done,acc}
      end
  end

  def reduce(_,{:halt,acc},_) do {:halted, acc} end


end
