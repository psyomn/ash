with Ada.Real_Time;
with Ada.Strings.Unbounded;
with Ada.Streams;

use type
  Ada.Streams.Stream_Element_Count
, Ada.Streams.Stream_Element_Array
, Ada.Real_Time.Time
, Ada.Real_Time.Time_Span
;

package Listeners is
   package ASU renames Ada.Strings.Unbounded;
   type Listener is tagged record
      Port_Number  : Integer range 0 .. 16#ffff#;
      Host_Name    : ASU.Unbounded_String;
      Shutdown     : Boolean := False;
      WS_Root_Path : ASU.Unbounded_String;
   end record;

   procedure Print_Info (This : Listener);
   procedure Listen (This : Listener);

   function Tiny_Name (This : Listener) return String;
end Listeners;
