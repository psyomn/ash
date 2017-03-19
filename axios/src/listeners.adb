with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with GNAT.Sockets; use GNAT.Sockets;

with Response_Helpers; use Response_Helpers;
with Transaction_Handlers;

package body Listeners is
  package IO renames Ada.Text_IO;

  procedure Print_Info (This : Listener) is
    Port_Str : constant String := Integer'Image(This.Port_Number);
    Host_Str : constant String := ASU.To_String(This.Host_Name);
    Root_Str : constant String := ASU.To_String(This.WS_Root_Path);
  begin
    Put_Line (
      "Listener Info: " &
      "Port Number : " & Port_Str & CRLF &
      "Hostname    : " & Host_Str & CRLF &
      "Root Dir.   : " & Root_Str & CRLF & CRLF);
  end Print_Info;

  function Tiny_Name (This : Listener) return String is
    Name : constant String :=
      ASU.To_String(This.Host_Name) & "@" &
      Integer'Image(This.Port_Number);
  begin
    return Name;
  end Tiny_Name;

  function Response_Date return String is
  begin
    return "Date: Tue, 20 Jan 2012 10:48:45 GMT";
  end Response_Date;

  -- Listen forever. Graceful shutdown if it receives some signal.
  procedure Listen (This : Listener) is
    Socket   : Socket_Type;
    Server   : Socket_Type;
    Address  : Sock_Addr_Type;
    Channel  : Stream_Access;
    The_Host : constant String := ASU.To_String(This.Host_Name);
  begin
    Address.Addr := Addresses (Get_Host_By_Name (The_Host), 1);
    Address.Port := Port_Type (This.Port_Number);
    Create_Socket(Server);

    Set_Socket_Option (Server, Socket_Level, (Reuse_Address, True));
    Bind_Socket (Server, Address);
    Listen_Socket (Server);

    -- pass to other socket.
    Put_Line ("Successfully listening on: " & Port_Type'Image(Address.Port));

    Listening_Loop :
    while not This.Shutdown loop
      Accept_Socket(Server, Socket, Address);
      Channel := Stream(Socket);
      declare
        Counter      : Integer   := 0;

        Request      : ASU.Unbounded_String;
        Chara        : Character;
      begin
        -- Read the request body
        Read_Request :
        loop
          Character'Read(Channel, Chara);
          ASU.Append(
            Source   => Request,
            New_Item => Chara);

          if Chara = ASCII.LF or Chara = ASCII.CR then
            Counter := Counter + 1;
          else -- reset
            Counter := 0;
          end if;

          exit when Counter = 4;
        end loop Read_Request;

        IO.Put_Line(ASU.To_String(Request));

        String'Write
          (Channel, Transaction_Handlers.Handle_Request(
             ASU.To_String(Request),
             ASU.To_String(This.WS_Root_Path)));
      exception when E : others =>
        IO.Put_Line ("Listeners, at main listen loop: " & Exception_Name(E) & Exception_Message(E));
      end;
      Free(Channel);
      Close_Socket(Socket);
    end loop Listening_Loop;
  end Listen;
end Listeners;
