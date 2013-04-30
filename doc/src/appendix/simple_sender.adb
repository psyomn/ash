-- @author Simon Symeonidis
-- A concise example of a client procedure, adapted from the
-- ping pong example in the GNAT.Sockets specification file.

with Ada.Text_IO;
with GNAT.Sockets; use GNAT.Sockets;

procedure Simple_Sender is 
  Address : Sock_Addr_Type;
  Socket  : Socket_Type;
  Channel : Stream_Access;
begin
  -- Init socket stuff
  Address.Addr := Addresses (Get_Host_By_Name (Host_Name), 1);
  Address.Port := 3000;
  Create_Socket(Socket);
  Set_Socket_Option(Socket, Socket_Level, (Reuse_Address, True));
  Connect_Socket (Socket, Address);
  Channel := Stream (Socket);
  String'Output (Channel, "hack the planet.");

  declare
    Message : String := String'Input(Channel);
  begin
    Address := Get_Address(Channel);
    Ada.Text_IO.Put_Line ("Server @ " & Image(Address) 
                          & ": " & Message);
  end;

  -- Cleanup
  Close_Socket(Socket);
end Simple_Sender;
