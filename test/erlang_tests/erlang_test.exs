defmodule ErlangTest do
use ExUnit.Case

test "erlang" do
  path = Path.absname("build/tests/")
  test_exe = Path.join([path, "test-erlang"])
  {result, code} = System.cmd(test_exe, [])
  assert code == 0
end

end