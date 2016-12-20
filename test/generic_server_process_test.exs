defmodule GenericServerProcessTest do
  use ExUnit.Case
  doctest GenericServerProcess

  test "the truth" do
    pid = GenericServerProcess.start(KVStore)
    GenericServerProcess.call(pid,{:put,:some_key, :some_value})
    value =  GenericServerProcess.call(pid,{:get,:some_key})
    assert value == :some_value
  end
end
