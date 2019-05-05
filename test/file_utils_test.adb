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

with Common_Utils;
with File_Utils; use File_Utils;
with Ada.Text_IO; use Ada.Text_IO;

package body File_Utils_Test is

   Fixture_File_Name : constant String := "./test/fixtures/file.txt";
   Expected_Contents : constant String := "hello world" & ASCII.LF;

   procedure Test_Read_File_With_Normal_Named_String (T : in out Test) is
      pragma Unreferenced (T);
      Contents : constant String := Read (Fixture_File_Name);
   begin
      Assert (Contents'Length = Expected_Contents'Length,
              "lengths of returned string must be the same; " &
                "expected: " & Contents'Length'Image &
                "actual: " & Expected_Contents'Length'Image);

      Assert (Contents = Expected_Contents,
              "expected: " & Expected_Contents & " actual: " & Contents);
   end Test_Read_File_With_Normal_Named_String;

   procedure Test_Read_File_With_Null_Named_String (T : in out Test) is
      pragma Unreferenced (T);
      Fname_Buff : String (1 .. 548) := (others => Character'Val (0));
   begin
      Fname_Buff (1 .. Fixture_File_Name'Last) := Fixture_File_Name;
      declare
         Contents : constant String := Read (Fname_Buff);
      begin
         Assert (Contents'Length = Expected_Contents'Length,
                 "lengths of returned string must be the same; " &
                   "expected: " & Contents'Length'Image &
                   "actual: " & Expected_Contents'Length'Image);

         Assert (Contents = Expected_Contents,
                 "expected: " & Expected_Contents &
                   " actual: " & Contents);
      end;
   end Test_Read_File_With_Null_Named_String;

   procedure Test_Read_File_From_Null_Concat_Name (T : in out Test) is
      pragma Unreferenced (T);
      Path : constant String := "./test/fixtures/";
      File : constant String := "file.txt";

      Buff_1 : String (1 .. 548) := (others => Character'Val (0));
      Buff_2 : String (1 .. 548) := (others => Character'Val (0));
      Buff_3 : String (1 .. Buff_1'Length + Buff_2'Length) :=
        (others => Character'Val (0));
   begin
      Buff_1 (1 .. Path'Last) := Path;
      Buff_2 (1 .. File'Last) := File;
      Buff_3 := Buff_1 & Buff_2;
      Put_Line (Buff_3);

      declare
         Contents : constant String := Read (Buff_3);
         pragma Unreferenced (Contents);
      begin
         --  NOTE: this should fail, and that's ok
         Assert (False, "should fail trying using bad buffers");
      end;

   exception
      when Name_Error =>
         null;
   end Test_Read_File_From_Null_Concat_Name;

   procedure Test_Read_File_From_Null_Concat_Name_Fix (T : in out Test) is
      pragma Unreferenced (T);
      Path : constant String := "./test/fixtures/";
      File : constant String := "file.txt";

      Buff_1 : String (1 .. 548) := (others => Character'Val (0));
      Buff_2 : String (1 .. 548) := (others => Character'Val (0));
      Buff_3 : String (1 .. Buff_1'Length + Buff_2'Length) :=
        (others => Character'Val (0));
   begin
      Buff_1 (1 .. Path'Last) := Path;
      Buff_2 (1 .. File'Last) := File;
      Buff_3 := Buff_1 & Buff_2;
      Put_Line (Buff_3);

      declare
         Path : constant String :=
           Common_Utils.Concat_Null_Strings (Buff_1, Buff_2);
         Contents : constant String := Read (Path);
         pragma Unreferenced (Contents);
      begin
         --  NOTE: this should fail, and that's ok
         Assert (True, "ayyyay");
      end;
   exception
      when Name_Error =>
         Assert (False, "should not raise, path should be sound");
   end Test_Read_File_From_Null_Concat_Name_Fix;

end File_Utils_Test;
