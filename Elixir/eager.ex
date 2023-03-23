defmodule Eager do


  ## Simple test that checks a sequence och returns either :error
  ## or an answer in the form of {:ok, str}
  def eval(seq) do
    case eval_seq(seq,[]) do
      :error -> :error
      {_,str} -> {:ok, str}
    end
  end



  ## Expressions ----------------------------------------------------
  def eval_expr({:atm, id}, _) do {:ok, id} end

  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil -> :error
      {_, str} -> {:ok, str}
    end
  end


  def eval_expr({:cons, head, tail}, env) do
    case eval_expr(head, env) do
      :error -> :error

      {:ok, str} ->
        case eval_expr(tail, env) do
          :error -> :error
          {:ok, ts} -> {:ok, {str, ts}}
        end
    end
  end


  ## Pattern Matching --------------------------------------------------
  def eval_match(:ignore, _, env) do
  {:ok, env}
  end

  def eval_match({:atm, id}, id, env) do
    {:ok, env}
  end

  def eval_match({:var, id}, str, env) do
    case Env.lookup(id,env) do
      nil ->
        {:ok, [{id,str}|env]}
      {_, ^str} ->
        {:ok, env}
      {_, _} ->
        :fail
    end
  end

  def eval_match({:cons, hp, tp}, {str,ts}, env) do
    case eval_match(hp, str, env) do
      :fail -> :fail
      {:ok, env1} ->
        eval_match(tp, ts, env1)
    end
  end

  def eval_match(_, _, _) do
    :fail
  end


  ## Sequence ----------------------------------------------------------
  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end

  def eval_seq([{:match, seq1, seq2} | tail], env1) do
    case eval_expr(seq2, env1) do
      :error -> :error
      {:ok,str} ->
        vars = extract_vars(seq1)
        env = Env.remove(vars, env1)

        case eval_match(seq1, str , env) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(tail, env)
        end
    end
  end


  ## Extract -------------------------------------------------------------
  def extract_vars(pattern) do
    extract_vars(pattern,[])
  end

  def extract_vars({:cons,:ignore,tail},list) do
      extract_vars(tail,list)
  end

  def extract_vars({:cons, {_,str},tail}, list) do
    list = [str|list]
    extract_vars(tail,list)
  end

  def extract_vars(:ignore, list) do list end

  def extract_vars({_,str},list) do [str|list] end

end
