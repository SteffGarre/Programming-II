defmodule Tentor do

#Tenta 2020.03.09
#--------------------------------------------------------------

    def toogle(list)do
      case list do
        [] -> []
        [h|[]] -> [h]
        [h|t] -> [hd(t),h|toogle(tl(t))]
      end
    end
#--------------------------------------------------------------

    def stack() do [:no] end

    def push(e,[:no]) do [e] end

    def push(e,stack) do [e|stack] end

    def pop([]) do [:no] end

    def pop(list) do {:ok,hd(list),tl(list)} end
#--------------------------------------------------------------

    def flatten([]) do [] end

    def flatten([h|t]) do flatten(h) ++ flatten(t) end

    def flatten(element) do [element] end
#--------------------------------------------------------------

  def index(list) do
    h = 0
    index(list,h)
   end

   def index([],h) do h end

   def index([head|list],h) do
     if(h < head) do
       h = h + 1
       index(list,h)
     else
       index(list,h)
     end
   end
#--------------------------------------------------------------


@doc"  tree() :: :nil | {:node, tree(), tree()} | {:leaf, any()}"

  def compact({:node,{:leaf,x},{:leaf,x}}) do {:leaf,x} end
  def compact({:node,:nil,{:leaf,x}}) do {:leaf,x} end
  def compact({:node,{:leaf,x},:nil}) do {:leaf,x} end

  def compact({:node, left, right}) do
    {:node, compact(left), compact(right)}
  end

  def compact(:nil) do :nil end
  def compact({:leaf,x}) do {:leaf, x} end
#--------------------------------------------------------------

  def primes() do
      fn() -> {:ok, 2, fn() -> sieve(2, fn() -> next(3) end) end} end
  end

  def next(n) do
    {:ok, n, fn() -> next(n+1) end}
  end

  def sieve(p,f) do
    {:ok,n,f} = f.()

    if rem(n,p) == 0 do
      sieve(p,f)
    else
      {:ok, n, fn()->sieve(n, fn()-> sieve(p,f)end) end}
    end
  end




#Tenta 2019.06.05
#--------------------------------------------------------------

  def drop(list,n) do
    k = 0
    drop(list,n,k)
  end

  def drop([h|rest], n, k) do
    k = k + 1
    cond do
      k == n -> rest
      true -> [h|drop(rest,n,k)]
    end
  end
  #--------------------------------------------------------------

  def rotate(list,n) do
    k = 0
    rotate(list,n,k,[])
  end

  def rotate([h|rest],n,k,acc) do
    k = k + 1
    cond do
      k==n ->
        acc = [h|acc]
        acc2 = Enum.reverse(acc)
        append(rest,acc2)
      true -> rotate(rest,n,k,[h|acc])
    end
  end

  def append(list1,list2) do
    case list1 do
      [] -> list2
      [h|t] -> [h|append(t,list2)]
    end
  end
#--------------------------------------------------------------

#--------------------------------------------------------------

  @doc"
  @type op() :: :add | :sub
  @type instr() :: integer() | op()
  @type seq() :: [instr()]
  "

  def hp35(seq) do
    hp35(seq,[])
  end

  def hp35([], [element]) do element end

  def hp35([:add|rest],[a,b|stack]) do
      res = a + b
      hp35(rest, [res|stack])
  end

  def hp35([:sub|rest],[a,b|stack]) do
    res = b - a
    hp35(rest, [res|stack])
  end

  def hp35([int|rest],stack) do
    hp35(rest,[int|stack])
  end
#--------------------------------------------------------------

  def trans(:nil,_) do :nil end

  def trans({:node, any, left, right}, func) do
    {:node, func.(any), trans(left,func), trans(right,func)}
  end

  def remit(tree,n) do
    trans(tree, fn(x)-> rem(x,n) end)
  end
#--------------------------------------------------------------






#Tenta 2019.06.05
#--------------------------------------------------------------

  def decode(list) do
    decode(list,[])
  end

  def decode([],acc) do Enum.reverse(acc) end

  def decode([h|rest],acc) do
    acc = add(h,acc)
    decode(rest,acc)
  end

  def add({_,0}, acc) do acc end

  def add({c,n},acc) do
    add({c,n-1},[c|acc])
  end
#--------------------------------------------------------------

  def zip([],[]) do [] end

  def zip([h1|rest1],[h2|rest2]) do
    [{h1,h2}|zip(rest1,rest2)]
  end
#--------------------------------------------------------------

  def balance(:nil) do {0,0} end

  def balance({:node, _, left, right}) do
    {dl, il} = balance(left)
    {dr, ir} = balance(right)
    depth = max(dl, dr) + 1
    imbalance = max(max(il, ir), abs(dl-dr))
    {depth, imbalance}
  end
#--------------------------------------------------------------

  def eval({:neg, int}) do -int end

  def eval({:add, a, b}) do
    eval(a) + eval(b)
  end

  def eval({:mul, a, b}) do
    eval(a) * eval(b)
  end

  def eval(int) do int end
#--------------------------------------------------------------

  def fib() do
    fn() -> fib(1,1) end
  end

  def fib(f1,f2) do
    {:ok,f1,fn()-> fib(f2, f1+f2) end}
  end

  def take(inf, 0) do
    {:ok, [], inf}
  end

  def take(inf, n) do
    {:ok, next, cont} = inf.()
    {:ok, rest, cont} = take(cont, n-1)
    {:ok, [next|rest], cont}
  end


  def test() do
    cont = fib()
    {:ok, f1, cont} = cont.()
    {:ok, f2, cont} = cont.()
    {:ok, f3, cont} = cont.()
    {:ok, f4, cont} = cont.()
    {:ok, f5, cont} = cont.()
    [f1,f2,f3,f4,f5]

    {:ok, _, cont} = take(fib(), 4); take(cont,5)
  end
  #--------------------------------------------------------------

  def facl(n) do
    facl(n,[], 1)
  end

  def facl(n, acc, count) when n == count do [fac(n)|acc] end

  def facl(n,acc,count) do
    facl(n,[fac(count)|acc],count+1)
  end


  def fac(1) do 1 end

  def fac(n) do
   n * fac(n-1)
  end
#--------------------------------------------------------------


  def luhn(list) do
    luhn(list,2,0)
  end

  def luhn([],_, sum) do
    10 - rem(sum,10)
  end

  def luhn([h|rest],1,sum) do
    luhn(rest,2,sum + h)
  end

  def luhn([h|rest],2,sum) when h<5 do
    luhn(rest,1, sum + (h*2))
  end

  def luhn([h|rest],2,sum) do
    luhn(rest,1,sum + (h * 2) - 9)
  end



end
