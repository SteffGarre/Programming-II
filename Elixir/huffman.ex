defmodule Huff do

  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text()  do
    'this is something that we should encode'
  end

  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end

  ##  create a Huffman tree given a sample text ------------------------
  def tree(sample) do
    freq = isort(freq(sample))
    huffman(freq)
  end


  def freq(sample) do freq(sample, []) end

  def freq([], freq) do freq end

  def freq([char | rest], freq) do
    freq(rest, check(char,freq))
  end


  def check(char,[]) do [{char,1}] end

  def check(char,[{char,n}|tail]) do
    [{char,n+1}|tail]
  end

  def check(char,[head|tail]) do
    [head|check(char,tail)]
  end

  ##insertionsort ---------------------------------------------------
  def isort(l) do
    isort(l, [])
  end

  def isort(l, sorted) do
    case l do
      [] -> sorted
      [h | t] -> isort(t,insert(h,sorted))
    end
  end

  def insert({char,freq},[]) do
    [{char,freq}]
  end

  def insert({char,freq},[{k,v}|tail]) when freq < v do
    [{char,freq},{k,v}|tail]
  end

  def insert({char,freq},[{k,v}|tail]) do
    [{k,v}|insert({char,freq},tail)]
  end

  ## Huffman tree constructor -------------------------------------------

  def huffman([{tree,_}]) do tree end

  def huffman([{c1,f1},{c2,f2}|rest]) do
    huffman(huffsort({c1,c2}, f1+f2, rest))
  end


  def huffsort(c,freq,[]) do [{c,freq}] end

  def huffsort(c, freq, htree) do
    [first|rest] = htree
    {_,f1} = first
    if freq < f1 do
      [{c,f1}|htree]
    else
      [first|huffsort(c,freq,rest)]
    end
  end



  ## create an encoding table containing the mapping from
  ## characters to codes given a Huffman tree. -----------------------------
  def encode_table(tree) do
    Enum.sort( Huff.encode_table(tree,[],[]),
    fn({_,x},{_,y}) -> length(x) < length(y) end)

  end

  def encode_table({a,b},sofar,acc) do
    left = encode_table(a,[0 | sofar],acc)
    encode_table(b,[1 | sofar],left)
  end

  def encode_table(a,code,acc) do
    [{a, Enum.reverse(code)}|acc]
  end



  ##  create an decoding table containing the mapping from codes
  ##  to characters given a Huffman tree. ------------------------------------
  def decode_table(tree) do tree end



  ## encode the text using the mapping in the table, return a sequence of bits.
  def encode([], _) do [] end

  def encode([char | rest], table) do
    code = elem(table,char)
    code ++ encode(rest, table)
  end

  ## decode the bit sequence using the mapping in table, return a text.

  def decode([],_) do [] end

  def decode(seq, tree) do
    {char,rest} = lookup(seq,tree)
    [char| decode(rest,tree)]
  end

  def lookup([0|seq], {left,_}) do
    lookup(seq,left)
  end

  def lookup([1|seq], {_,right}) do
    lookup(seq,right)
  end

  def lookup(rest,char) do {char,rest} end


end
