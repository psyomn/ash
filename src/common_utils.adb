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
end Common_Utils;
