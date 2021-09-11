--  Copyright 2019-2021 Simon Symeonidis (psyomn)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Unbounded;
with GNAT.Sockets; use GNAT.Sockets;

with Transaction_Handlers;
with Common_Utils;

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
      Put_Line ("listening on " & Host_Str & ": " & Port_Str &
                ", root dir.: " & Root_Str);
   end Print_Info;

   --  Listen forever. Graceful shutdown if it receives some signal.
   procedure Listen (L : Listener) is
      Socket   : Socket_Type;
      Server   : Socket_Type;
      Address  : Sock_Addr_Type;
      Channel  : Stream_Access;
      The_Host : constant String := L.Host_Name;
   begin
      Address.Addr := Addresses (Get_Host_By_Name (The_Host), 1);
      Address.Port := Port_Type (L.Port_Number);
      Create_Socket (Server);

      Set_Socket_Option (Server, Socket_Level, (Reuse_Address, True));
      Bind_Socket (Server, Address);
      Listen_Socket (Server);

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

         exception
            when E : End_Error =>
               Common_Utils.Print_Exception (E, "socket reading EOF error");
            when E : Socket_Error =>
               Common_Utils.Print_Exception (E, "generic socket error");
            when E : others =>
               Common_Utils.Print_Exception (E, "unexpected error");
         end;
         Free (Channel);
         Close_Socket (Socket);
      end loop Listening_Loop;
   end Listen;
end Listeners;
