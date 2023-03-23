defmodule Test do

  def double(n) do
    n + n
  end

  def convertFahr(a) do
    (a - 32)/1.8
  end

  def areaSqu(a) do
    areaTri(a,a) * 2
  end

  def areaTri(a,b) do
    (a * b)/2
  end

  def areaCir(r) do
    r * r * :math.pi()
  end

end
