defmodule KVStore do

def init do
  HashDict.new
end

def handle_call({:put, key, value}, state) do
  IO.puts "busy storing Values"
  {:ok, HashDict.put(state, key,value)}
end

def handle_call({:get, key}, state) do
  {HashDict.get(state,key), state}
end

#Create an abstraction so that User don't have to deal with

def start do
  GenericServerProcess.start(KVStore)
end

def put(pid, key, value) do
  GenericServerProcess.call(pid, {:put, key, value })
end

def get(pid, key) do
  GenericServerProcess.call(pid, {:get, key})
end
end
