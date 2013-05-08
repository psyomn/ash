-- @author Simon Symeonidis
-- @date   
--
-- This is the listener for http connections to port 80. 
-- This should delegate the request to some handler, and 
-- execute the proper logic.
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with GNAT.Sockets;

package Listeners is 

  -- This is basically the specification for web servers. The way
  type Listener is tagged record
    Port_Number : Integer range 0..65536; 
    Host_Name   : Ada.Strings.Unbounded.Unbounded_String;
    Shutdown    : Boolean := False;
  end record;

  procedure Print_Info(Listener_Handle : Listener);
  procedure Listen(This : Listener);
end Listeners;
