with Ada.Text_IO;
-- @author Simon Symeonidis
-- @date   
-- Implementation for the listener
package body Listener is

  type Receiver is tagged record
    Port_Number : Integer range 0..65536; 
    Host_Name   : String(1..100);
    Response    : String(1..100); 
    Request     : String(1..100); 
  end record;

  -- Print to the command line information such
  -- as host and port number
  procedure Print_Info(Receiver_Handle : Receiver) is 
  begin
    Ada.Text_IO.Put_Line("Receiver Info: ");
    Ada.Text_IO.Put_Line("Port Number ");
    Ada.Text_IO.Put_Line("Receiver Info: ");
    Ada.Text_IO.Put_Line("Receiver Info: ");
  end Print_Info;

  -- Listen forever. Graceful shutdown omitted.
  procedure Listen is
    lvar : Boolean := true; 
  begin
    while lvar loop
      Ada.Text_IO.Put_Line("Loop for listein...");
      delay 3.0;
    end loop;
  end Listen;

  procedure Set_Port(port : Integer) is 
  begin
    Ada.Text_IO.Put_Line("Placeholder...");
  end Set_Port;

end Listener; 
