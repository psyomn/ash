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

with File_Utils; use File_Utils;

package body File_Utils_Test is

   Fixture_File_Name : constant String := "./test/fixtures/file.txt";

   procedure Test_Read_File_With_Normal_Named_String (T : in out Test) is
      pragma Unreferenced (T);
      Contents : constant String := Read (Fixture_File_Name);
      Expected : constant String := "hello world" & ASCII.LF;
   begin
      Assert (Contents'Length = Expected'Length,
              "lengths of returned string must be the same; " &
                "expected: " & Contents'Length'Image &
                "actual: " & Expected'Length'Image);

      Assert (Contents = Expected,
              "expected: " & Expected & " actual: " & Contents);
   end Test_Read_File_With_Normal_Named_String;

   procedure Test_Read_File_With_Null_Named_String (T : in out Test) is
      pragma Unreferenced (T);
      Fname_Buff : String (1 .. 548) := (others => Character'Val (0));
      Expected : constant String := "hello world" & ASCII.LF;
   begin
      Fname_Buff (1 .. Fixture_File_Name'Last) := Fixture_File_Name;
      declare
         Contents : constant String := Read (Fname_Buff);
      begin
         Assert (Contents'Length = Expected'Length,
                 "lengths of returned string must be the same; " &
                   "expected: " & Contents'Length'Image &
                   "actual: " & Expected'Length'Image);

         Assert (Contents = Expected,
                 "expected: " & Expected & " actual: " & Contents);
      end;
   end Test_Read_File_With_Null_Named_String;

end File_Utils_Test;
