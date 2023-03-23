defmodule BtreeKey do

  @doc "
  :nil                                # an empty tree
  {:node, key , value, left, right}   # a node with a key (integer)
                                        and value (any)

  "

  def tree() do
    t = {:node,10,:apple, :nil, :nil}
    t = add(5,:lemon,t)
    t = add(2,:tomate,t)
    t = add(7,:lime,t)
    t = add(15,:pie,t)
    t = add(12,:banana,t)
    t = add(17,:milk,t)
    t
  end

  ##lookup
  def lookup(_,:nil) do :no end

  def lookup(key,{:node,key,value,_,_}) do {:ok, value} end

  def lookup(key,{:node,k,_,left,_}) when key < k do
    lookup(key,left)
  end

  def lookup(key,{:node,_,_,_,right})do
  lookup(key,right)
  end

  ##remove
  def remove(key,{:node,key,_,:nil,:nil}) do :nil end

  def remove(key,{:node,key,_,:nil,right}) do right end

  def remove(key,{:node,key,_,left,:nil}) do left end

  def remove(key, {:node, key,_, left, right}) do
    {:ok, newk, newv} = rightmost(left)
    {:node,newk,newv,remove(newk,left), right}
  end

  def remove(key,{:node,k,v,left,right}) when key < k do
    {:node,k,v,remove(key,left),right}
  end

  def remove(key,{:node,k,v,left,right}) do
    {:node,k,v,left,remove(key,right)}
  end

  def rightmost({:node,key,value,_,:nil}) do {:ok,key,value} end
  def rightmost({:node, _,_, _, right}) do rightmost(right) end


  ##add
  def add(key,value, :nil) do {:node, key,value, :nil, :nil} end

  def add(key,value, {:node,key,_,left,right}) do
    {:node, key,value, left, right} end

  def add(key,value, {:node,k,v,left,right}) when key < k  do
    {:node, k,v, add(key,value,left), right}
  end

  def add(key,value,{:node,k,v,left,right}) do
    {:node, k,v,left,add(key,value,right)}
  end


end
