defmodule DNATest do
  use ExUnit.Case

  describe "encode to 4-bit encoding" do
    @task_id 1
    test "?\\s to 0b0000", do: assert(DNA.encode_nucleotide(?\s) == 0b0000)
    @task_id 1
    test "?A to 0b0001", do: assert(DNA.encode_nucleotide(?A) == 0b0001)
    @task_id 1
    test "?C to 0b0010", do: assert(DNA.encode_nucleotide(?C) == 0b0010)
    @task_id 1
    test "?G to 0b0100", do: assert(DNA.encode_nucleotide(?G) == 0b0100)
    @task_id 1
    test "?T to 0b1000", do: assert(DNA.encode_nucleotide(?T) == 0b1000)
  end

  describe "decode to code point" do
    @task_id 2
    test "0b0000 to ?\\s", do: assert(DNA.decode_nucleotide(0b0000) == ?\s)
    @task_id 2
    test "0b0001 to ?A", do: assert(DNA.decode_nucleotide(0b0001) == ?A)
    @task_id 2
    test "0b0010 to ?C", do: assert(DNA.decode_nucleotide(0b0010) == ?C)
    @task_id 2
    test "0b0100 to ?G", do: assert(DNA.decode_nucleotide(0b0100) == ?G)
    @task_id 2
    test "0b1000 to ?T", do: assert(DNA.decode_nucleotide(0b1000) == ?T)
  end

  describe "encoding" do
    @task_id 3
    test "' '", do: assert(DNA.encode(' ') == <<0b0000::4>>)
    @task_id 3
    test "'A'", do: assert(DNA.encode('A') == <<0b0001::4>>)
    @task_id 3
    test "'C'", do: assert(DNA.encode('C') == <<0b0010::4>>)
    @task_id 3
    test "'G'", do: assert(DNA.encode('G') == <<0b0100::4>>)
    @task_id 3
    test "'T'", do: assert(DNA.encode('T') == <<0b1000::4>>)

    @task_id 3
    test "' ACGT'",
      do: assert(DNA.encode(' ACGT') == <<0b0000::4, 0b0001::4, 0b0010::4, 0b0100::4, 0b1000::4>>)

    @task_id 3
    test "'TGCA '",
      do: assert(DNA.encode('TGCA ') == <<0b1000::4, 0b0100::4, 0b0010::4, 0b0001::4, 0b0000::4>>)
  end

  describe "decoding" do
    @task_id 4
    test "' '", do: assert(DNA.decode(<<0b0000::4>>) == ' ')
    @task_id 4
    test "'A'", do: assert(DNA.decode(<<0b0001::4>>) == 'A')
    @task_id 4
    test "'C'", do: assert(DNA.decode(<<0b0010::4>>) == 'C')
    @task_id 4
    test "'G'", do: assert(DNA.decode(<<0b0100::4>>) == 'G')
    @task_id 4
    test "'T'", do: assert(DNA.decode(<<0b1000::4>>) == 'T')

    @task_id 4
    test "' ACGT'",
      do: assert(DNA.decode(<<0b0000::4, 0b0001::4, 0b0010::4, 0b0100::4, 0b1000::4>>) == ' ACGT')

    @task_id 4
    test "'TGCA '",
      do: assert(DNA.decode(<<0b1000::4, 0b0100::4, 0b0010::4, 0b0001::4, 0b0000::4>>) == 'TGCA ')
  end
end
