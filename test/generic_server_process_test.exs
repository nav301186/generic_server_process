defmodule GenericServerProcessTest do
  use ExUnit.Case
  doctest GenericServerProcess

  test "should return the stored key" do
    pid = GenericServerProcess.start(KVStore)
    GenericServerProcess.call(pid,{:put,:some_key, :some_value})
    value =  GenericServerProcess.call(pid,{:get,:some_key})
    assert value == :some_value
  end


    test "the truth" do
      pid = KVStore.start
      KVStore.put(pid, :some_key, :some_value)
      value = KVStore.get(pid, :some_key)
      assert value == :some_value
    end

end
