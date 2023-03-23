defmodule Env do

@doc"

<sequence> ::=   <expression>
                 <match> ';' <sequence>

<match> ::=   <pattern> '=' <expression>

<expression> ::=   <atom>
                   <variable>
                   '{' <expression> ',' <expression> '}'

 <pattern> ::=   <atom>
                 <variable>
                 '_'
                 '{' <pattern> ',' <pattern> '}'
"


  def new() do
    []
  end

  def add(id,str,[]) do
   [{id,str}]
  end

  def add(id,str,[{id,_}|tail]) do
    [{id,str}|tail]
  end

  def add(id,str,[head|tail]) do
    [head|add(id,str,tail)]
  end


  def lookup(_,[]) do
    :nil
  end

  def lookup(id,[{id,str}|_]) do
    {id,str}
  end

  def lookup(id,[_|tail]) do
    lookup(id,tail)
  end

  def remove(list,env) do
    remove(list,env,[])
  end

  def remove(_,[],acc) do acc end

  def remove(list,env,acc) do
    acc = check(list,env,acc)
    remove(list,tl(env),acc)

  end

  def check([],[{id,str}|_],acc) do [{id,str}|acc] end

  def check([id|_],[{id,_}|_],acc) do  acc end

  def check([_|rest],env,acc) do
    check(rest,env,acc)
  end

end
