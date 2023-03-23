defmodule Tenta do

  def prog() do

    register = {0,0,0,0,0,0}
    output = []
    pc = 0 

    {register,pc} = inst({:addi,1,0,10,register},pc)
    {register,pc} = inst({:addi,3,0,1,register},pc)
    {register,output,pc} = inst({:out, 3,register,output},pc)

    {register,pc} = inst({:addi,1,1,-1,register},pc)
    {register,pc} = inst({:addi,4,3,2,register},pc)
    {register,pc} = inst({:add,4,3,2,register},pc)
    {register,output,pc} = inst({:out, 3,register,output},pc)

    {register,pc} = inst({:beq,1,0,3,register},pc)
    {register,pc} = inst({:addi,2,4,0,register},pc)
    {register,pc} = inst({:beq,0,0,-6,register},pc)

    inst({:halt,register,output,pc})

  end


  def inst({:add,res, a, b, regist},pc) do
    {put_elem(regist,res,elem(regist,a) + elem(regist,b)),pc+1}
  end

  def inst({:addi,res, a, imm, regist},pc) do
    {put_elem(regist,res,elem(regist,a) + imm),pc+1}
  end

  def inst({:beq,a, b, offset, regist},pc) when elem(regist,a) == elem(regist,b) do
    {regist,pc + offset}
  end

  def inst({:beq,_, _, _, regist},pc) do
    {regist,pc+1}
  end

  def inst({:out,reg,regist,list},pc) do
    {regist, [elem(regist,reg)|list],pc+1}
  end

  def inst({:halt,regist, output,pc}) do
    {:terminate, {:register,regist},{:output,rev(output)}, {:pc,pc}}
  end

  ##Används för att vända på en lista
  def rev(l) do
    rev(l, [])
  end

  def rev([], res) do res end

  def rev([h|t], res) do
    rev(t, [h|res])
  end


end
