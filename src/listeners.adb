with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Unbounded;
with Ada.Exceptions; use Ada.Exceptions;
with GNAT.Sockets; use GNAT.Sockets;

with Response_Helpers; use Response_Helpers;
with Transaction_Handlers;

package body Listeners is
   package IO renames Ada.Text_IO;
   package ASU renames Ada.Strings.Unbounded;

   task body Launch_Listener is
      L : Listener;
   begin
      accept Construct (The_Listener : in Listener) do
         L := The_Listener;
      end Construct;
      accept Start;
      Print_Info (L);
      Listen (L);
      accept Stop;
   end Launch_Listener;

   function Make_Listener
     (Port : Integer;
      Root : String;
      Host : String) return Listeners.Listener is
      L : Listeners.Listener;
   begin
      L.Port_Number := Port;
      L.WS_Root_Path (1 .. Root'Last) := Root;
      L.Host_Name (1 .. Host'Last) := Host;
      return L;
   end Make_Listener;

   procedure Print_Info (L : Listener) is
      Port_Str : constant String := Integer'Image (L.Port_Number);
      Host_Str : constant String := L.Host_Name;
      Root_Str : constant String := L.WS_Root_Path;
   begin
      Put_Line (
        "Listener Info: " &
        "Port Number : " & Port_Str & CRLF &
        "Hostname    : " & Host_Str & CRLF &
        "Root Dir.   : " & Root_Str & CRLF & CRLF);
   end Print_Info;

   --  Listen forever. Graceful shutdown if it receives some signal.
   procedure Listen (L : Listener) is
      Socket   : Socket_Type;
      Server   : Socket_Type;
      Address  : Sock_Addr_Type;
      Channel  : Stream_Access;
      The_Host : constant String := L.Host_Name;
      Port_Img : constant String := Port_Type'Image (Address.Port);
   begin
      Address.Addr := Addresses (Get_Host_By_Name (The_Host), 1);
      Address.Port := Port_Type (L.Port_Number);
      Create_Socket (Server);

      Set_Socket_Option (Server, Socket_Level, (Reuse_Address, True));
      Bind_Socket (Server, Address);
      Listen_Socket (Server);

      Put_Line ("Successfully listening on: " & Port_Img);

      Listening_Loop :
      while not L.Shutdown loop
         Accept_Socket (Server, Socket, Address);
         Channel := Stream (Socket);

         declare
            Counter : Integer := 0;
            Request : ASU.Unbounded_String;
            Chara   : Character;
         begin
            --  Read the request body
            Read_Request :
            loop
               Character'Read (Channel, Chara);
               ASU.Append (Source => Request, New_Item => Chara);

               if Chara = ASCII.LF or Chara = ASCII.CR then
                  Counter := Counter + 1;
               else
                  Counter := 0;
               end if;

               exit Read_Request when Counter = 4;
            end loop Read_Request;

            IO.Put_Line (ASU.To_String (Request));

            String'Write
              (Channel, Transaction_Handlers.Handle_Request (
                 ASU.To_String (Request),
                 L.WS_Root_Path));

         exception when E : others =>
            IO.Put_Line
              (IO.Standard_Error,
               "Listeners, at main listen loop: " &
               Exception_Name (E) & Exception_Message (E));
         end;
         Free (Channel);
         Close_Socket (Socket);
      end loop Listening_Loop;
   end Listen;
end Listeners;
