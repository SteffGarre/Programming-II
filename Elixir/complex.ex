defmodule Cmplx do

  def new(r,i) do
    {:cmplx, {:re,r}, {:im, i}}
  end

  def add({:cmplx,{:re,r1},{:im, i1}},{:cmplx,{:re,r2},{:im, i2}}) do
    {:cmplx,{:re,r1+r2},{:im, i1+i2}}
  end

  def sqr({:cmplx,{:re,r},{:im, i}}) do
    {:cmplx,{:re,(r*r)-(i*i)},{:im,(2*r*i)}}
  end

  def abs({:cmplx,{:re,r},{:im, i}}) do
    :math.sqrt( ((r*r) + (i*i)) )
  end

end
