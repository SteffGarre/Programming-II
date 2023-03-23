defmodule Recursion do

  @doc """

  power x^n
  func "prod" kallas rekursivt och gångrar x med sig själv n-antal gånger
  basfall: n=0 vilket är x gånger 1

  """
  def exp(x,n) do
    case n do
      0 -> 1
      n -> prod(x,exp(x, n-1))
    end
  end


  @doc """
  compute the prodcut between n and m

  product of n and m :

    condition
      m = 0
      then the product is 0

    else
      n > 0 and m < 0 -> change place between n and m and call func again
      n < 0 and m < 0 -> change both to positive
      m != 0 -> n + prod(n,(m-1))
      base case: if m = 0 -> end recursion

  """

  def prod(n,m) do

    cond do
      n > 0 and m < 0 -> prod(m,n)
      n < 0 and m < 0 -> prod(n*-1, m*-1)
      m != 0 -> n + prod(n,(m-1))
      m == 0 -> 0
    end
  end

  @doc """

  Beräknar fibonacci tal enligt:
  
  0          if n is 0
  1          if n is 1
  otherwise  fib(n-1) + fib (n-2)

  sekvensen blir då: 0,1,1,2,3,5,8,13,21,….

  """
  def fib(n) do

    case n do
      0 -> 0
      1 -> 1
      _-> fib(n-1) + fib (n-2)
    end
  end

end
