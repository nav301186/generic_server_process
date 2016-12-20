defmodule GenericServerProcess do
  #This is a pluggable Server process
  #where user can plug any module
  #all the boilerplate code will be handled here,

#what is this callback_module, is it a pid
def start(callback_module) do
  spawn(fn ->
    intial_state = callback_module.init
    loop(callback_module,intial_state)
  end)
end

#Handling messages in the server process
#this also is a boiler plate and doesnot differ process to process.
def loop(callback_module, current_state) do
  #here we will loop
  #but the actual proccessing should be done by
  #callback_module

#Since elixir uses immutable data
#we need to pass current_state at every call
#state need to flow from one process to another process.
  receive do
    {request,caller} ->
            {response, new_state} = callback_module.handle_call(request, current_state)
            send(caller, {:response, response})
            loop(callback_module, new_state)
  end
end

#loop will be fired off
#when server process is created.
#now the client process needs to communicate to the server process.
#below method allows clients to send messages to the server process.
def call(server_id, request) do
  #since this method will run in client process
  #it needs to use send.
  send(server_id, {request, self})
  #now we wait for server_process to give us back the response
  receive do

    {:response,response} -> response
  end

#return will happen using processId
end
end
