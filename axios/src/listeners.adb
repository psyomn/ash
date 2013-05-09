-- @author Simon Symeonidis
-- @date   Mon May 6 2013
-- Implementation for the listener

with GNAT.Sockets;

package body Listeners is

  -- Print to the command line information such
  -- as host and port number
  procedure Print_Info(Listener_Handle : Listener) is 
  begin
    Ada.Text_IO.Put_Line("Listener Info: ");
    Ada.Text_IO.Put_Line("Port Number : " 
      & Integer'Image(Listener_Handle.Port_Number));
    Ada.Text_IO.Put_Line("Hostname    : " 
      & Ada.Strings.Unbounded.To_String(Listener_Handle.Host_Name));
    Ada.Text_IO.Put_Line("Root Dir.   : "
      & Ada.Strings.Unbounded.To_String(Listener_Handle.WS_Root_Path));
    Ada.Text_IO.New_Line;
  end Print_Info;

  -- Listen forever. Graceful shutdown if it receives some signal.
  procedure Listen(This : Listener) is
    Socket  : GNAT.Sockets.Socket_Type;
    Server  : GNAT.Sockets.Socket_Type;
    Address : GNAT.Sockets.Sock_Addr_Type;
    Channel : GNAT.Sockets.Stream_Access;
  begin
    Ada.Text_IO.Put_Line("Started listening [" 
      & Ada.Strings.Unbounded.To_String(This.Host_Name) & "@" 
      & Integer'Image(This.Port_Number) &"]");

    while This.Shutdown loop
      null;
    end loop;
  end Listen;

  procedure Set_Port(port : Integer) is 
  begin
    Ada.Text_IO.Put_Line("Placeholder...");
  end Set_Port;
end Listeners;
