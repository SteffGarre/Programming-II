defmodule Calc do

  ## An integer n is represented by the tuple {:int, n}

  def eval({:int, n}) do n end

  def eval({:add, a, b}) do
    eval(a) + eval(b)
  end

  def eval({:sub, a, b}) do
    eval(a) - eval(b)
  end

  def eval({:mul, a, b}) do
    eval(a) *  eval(b)
  end


  def eval({:var, name}, bindings) do
    {:int,lookup(name, bindings)}
   end

   def eval({x,a,b}, bindings)do
     eval({x,eval(a,bindings),eval(b,bindings)})
   end

  def lookup(var, [{:bind, var, value} | _] ) do
    value
   end

  def lookup(var, [_ | rest]) do
    lookup(var,rest)
   end

end
