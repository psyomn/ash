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
with AUnit.Assertions; use AUnit.Assertions;

with Common_Utils; use Common_Utils;

package body Common_Utils_Test is

   procedure Test_Integer_To_Trimmed_String (T : in out Test) is
      pragma Unreferenced (T);
      Actual : constant String := Integer_To_Trimmed_String (123);
      Expected : constant String := "123";
      Result : constant Boolean := Actual = Expected;
   begin
      Assert (Result, "expected: " & Expected & " actual: " & Actual);
   end Test_Integer_To_Trimmed_String;

   procedure Test_Header_String (T : in out Test) is
      pragma Unreferenced (T);
      Field    : constant String := "Server";
      Value    : constant String := "ash";
      Actual   : constant String := Header_String (Field, Value);
      Expected : constant String := "Server: ash";
      Result : constant Boolean := Actual = Expected;
   begin
      Assert (Result, "expected: " & Expected & ", actual: " & Actual);
   end Test_Header_String;

   procedure Test_Header_String_Integer (T : in out Test) is
      pragma Unreferenced (T);
      Field    : constant String := "Processor";
      Value    : constant Integer := 6502;
      Actual   : constant String := Header_String (Field, Value);
      Expected : constant String := "Processor: 6502";
      Result : constant Boolean := Actual = Expected;
   begin
      Assert (Result, "expected header: " & Expected & ", actual: " & Actual);
   end Test_Header_String_Integer;

   procedure Test_Empty_String (T : in out Test) is
      pragma Unreferenced (T);
      S : String := "notempty";
      Count : Integer := 0;
   begin
      for I in Positive range S'First .. S'Last loop
         if S (I) = Character'Val (0) then
            Count := Count + 1;
         end if;
      end loop;
      Assert (Count = 0, "should not have null chars");

      Empty_String (S);
      for I in Positive range S'First .. S'Last loop
         if S (I) = Character'Val (0) then
            Count := Count + 1;
         end if;
      end loop;

      Assert (Count = S'Length, "should be all null chars");
   end Test_Empty_String;

   procedure Test_Empty_String_Range (T : in out Test) is
      pragma Unreferenced (T);

      type Test_Case is record
         Data : String (1 .. 9);
         First : Positive;
         Last : Positive;
      end record;

      type Tca is array (Positive range <>) of Test_Case;

      Tc1 : constant Test_Case := ("hello    ", 1, 1);
      Tc2 : constant Test_Case := ("    hello", 1, 1);
      Tc3 : constant Test_Case := ("  hello  ", 1, 1);
      Tcs : constant Tca := (Tc1, Tc2, Tc3);

      First, Last : Positive := 1;
   begin
      for I in Positive range Tcs'First .. Tcs'Last loop
         Empty_String_Range
           (S => Tcs (I).Data,
            First => First,
            Last => Last);

         Assert (Tcs (I).First = First and Tcs (I).Last = Last,
                 "did not get what was expected");
      end loop;
   end Test_Empty_String_Range;

end Common_Utils_Test;
