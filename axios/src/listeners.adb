-- @author Simon Symeonidis
-- @date   Mon May 6 2013
-- Implementation for the listener

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
  end Print_Info;

  -- Listen forever. Graceful shutdown omitted.
  procedure Listen(This : Listener) is
  begin
    while This.Shutdown loop
      Ada.Text_IO.Put_Line("Loop for listein...");
      delay 3.0;
    end loop;
  end Listen;

  procedure Set_Port(port : Integer) is 
  begin
    Ada.Text_IO.Put_Line("Placeholder...");
  end Set_Port;


end Listeners;
