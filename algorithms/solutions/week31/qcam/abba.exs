defmodule Week31.ABBA do
  def detect(string) do
    detect(string, {false, false})
  end

  # When the current string is empty, finish parsing.
  defp detect(<<>>, {has_ab?, has_ba?}) do
    has_ab? and has_ba?
  end

  # When the current string starts with "AB".
  defp detect(<<"AB", rest::bits>>, {_has_ab?, has_ba?}) do
    detect(rest, {true, has_ba?})
  end

  # When the current string starts with "BA".
  defp detect(<<"BA", rest::bits>>, {has_ab?, _has_ba?}) do
    detect(rest, {has_ab?, true})
  end

  # When the first character of the current string does not match any clause above.
  defp detect(<<_::integer, rest::bits>>, flags) do
    detect(rest, flags)
  end
end

ExUnit.start()

defmodule Week31.ABBATest do
  use ExUnit.Case, async: true

  import Week31.ABBA

  test "detect/1" do
    assert detect("ABBBBA")
    assert detect("ABABBBAB")
    assert detect("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBBA")
    refute detect("ABA")
    refute detect("AXBYBXA")
    refute detect("")
    refute detect("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBB")
  end
end
