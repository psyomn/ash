--  Copyright 2019 Simon Symeonidis (psyomn)
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
     (S     : String;
      First : out Positive;
      Last  : out Positive) is
      Current   : Character          := Character'Val (0);
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

   procedure Empty_String (S : in out String) is
      Null_Char : constant Character := Character'Val (0);
   begin
      for I in Positive range S'First .. S'Last loop
         S (I) := Null_Char;
      end loop;
   end Empty_String;

   function Concat_Null_Strings (S1, S2 : String) return String is
      Upto1, Upto2 : Positive;
   begin
      for I in Positive range S1'Range loop
         if S1 (I) = Character'Val (0) then
            Upto1 := I - 1;
            exit;
         end if;
      end loop;

      for I in Positive range S2'Range loop
         if S2 (I) = Character'Val (0) then
            Upto2 := I - 1;
            exit;
         end if;
      end loop;

      declare
         Ret : constant String (1 .. Upto1 + Upto2) :=
           S1 (S1'First .. Upto1) & S2 (S2'First .. Upto2);
      begin
         return Ret;
      end;
   end Concat_Null_Strings;

end Common_Utils;
