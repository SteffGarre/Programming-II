defmodule Tenta1 do

  def prog() do

    register = {0,0,0,0,0,0}
    output = []
    pc = 0

    instruc = [
      {:addi,1,0,10},
      {:addi,3,0,1},
      {:out, 3},
      {:addi,1,1,-1},
      {:addi,4,3,0},
      {:add,3,2,3},
      {:out, 3},
      {:beq,1,0,3},
      {:addi,2,4,0},
      {:beq,0,0,-6},
      {:halt}]

    inst(instruc,register,output,pc,instruc)

  end

  def inst([],regist,output,pc,_) do
    {:noInstruc, {:register,regist},{:output,rev(output)}, {:pc,pc}}
  end

  def inst([{:add,res, a, b}|rest],regist,output,pc,list) do
    inst(rest,put_elem(regist,res,elem(regist,a) + elem(regist,b)), output, pc+1,list)
  end

  def inst([{:addi,res, a, imm}|rest],regist,output,pc,list) do
    inst(rest,put_elem(regist,res,elem(regist,a) + imm),output,pc+1,list)
  end

  def inst([{:beq,a, b, offset}|_],regist,output,pc,list) when elem(regist,a) == elem(regist,b) do
    inst(jump(list,pc + offset,0),regist,output,pc + offset,list)
  end

  def inst([{:beq,_, _, _}|rest],regist,output,pc,list) do
    inst(rest,regist,output,pc + 1,list)
  end

  def inst([{:out,reg}|rest],regist,output,pc,list) do
    inst(rest, regist, [elem(regist,reg)|output],pc+1,list)
  end

  def inst([{:halt}|_],regist,output,pc,_) do
    {:terminate, {:register,regist},{:output,rev(output)}, {:pc,pc}}
  end


  def jump(list,beq,count) when beq==count do list end

  def jump([_|rest],beq,count) do
    jump(rest,beq,count+1)
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
