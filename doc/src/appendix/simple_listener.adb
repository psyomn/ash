-- @author Simon Symeonidis
-- A concise example of a listener procedure, adapted from the
-- ping pong example in the GNAT.Sockets specification file.
with Ada.Text_IO;
with Ada.Strings; 
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings.Maps.Constants;
with GNAT.Sockets; use GNAT.Sockets;
with Ada.Exceptions; use Ada.Exceptions;

procedure Simple_Listener is 
  Address  : Sock_Addr_Type;
  Server   : Socket_Type;
  Socket   : Socket_Type;
  Channel  : Stream_Access;
begin
  -- Init socket stuff.
  Address.Addr := Addresses (Get_Host_By_Name (Host_Name), 1);
  Address.Port := 3000; 
  Create_Socket (Server);
  
  Set_Socket_Option(Server, Socket_Level, (Reuse_Address, True));
  Bind_Socket (Server, Address); 
  Listen_Socket(Server);
  Accept_Socket(Server,Socket,Address);
  Channel := Stream (Socket); 
  declare
    Message : String := String'Input (Channel);
  begin
    Ada.Text_IO.Put_Line("Got: " & Message);
    String'Output (Channel,
      Ada.Strings.Fixed.Translate(Message,
        Ada.Strings.Maps.Constants.Upper_Case_Map));
  end;

  Close_Socket (Server);
  Close_Socket (Socket);

  exception when E : others => 
    Ada.Text_IO.Put_Line
      (Exception_Name (E) & Exception_Message(E));
end Simple_Listener;
