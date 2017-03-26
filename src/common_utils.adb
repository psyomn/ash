with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body Common_Utils is
   function Integer_To_Trimmed_String (I : Integer) return String is
      Result : constant String :=
         Trim (Source => Integer'Image (I), Side => Both);
   begin
      return Result;
   end Integer_To_Trimmed_String;

   function Header_String (Field : String; Value : String) return String is
      Result : constant String := Field & ": " & Value;
   begin
      return Result;
   end Header_String;

   function Header_String (Field : String; Value : Integer) return String is
      Result : constant String :=
         Header_String (Field, Integer_To_Trimmed_String (Value));
   begin
      return Result;
   end Header_String;

   procedure Empty_String_Range
     (S : String;
      First : out Positive;
      Last : out Positive) is
      Current : Character := Character'Val (0);
   begin
      First := S'First;
      Last := S'Last;

      for I in Positive range S'First .. S'Last loop
         Current := S (I);
         if Current = Character'Val (0) then
            First := (if I > 1 then I - 1 else I);
            exit;
         end if;
      end loop;

      for I in Positive range First .. S'Last loop
         Current := S (I);
         if Current /= Character'Val (0) then
            Last := I;
            exit;
         end if;
      end loop;
   end Empty_String_Range;
end Common_Utils;
