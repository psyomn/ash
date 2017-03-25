with Ada.Real_Time;
with Ada.Streams;

package Listeners is
   type Listener is record
      Port_Number  : Integer range 0 .. 16#ffff#;
      Shutdown     : Boolean := False;
      WS_Root_Path : String (1 .. 256) := (others => Character'Val(0));
      Host_Name    : String (1 .. 256) := (others => Character'Val(0));
   end record;

   procedure Print_Info (L : Listener);

   procedure Listen (L : Listener);

   function Tiny_Name (L : Listener) return String;
end Listeners;
