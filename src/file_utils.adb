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
with Ada.Text_IO;
with Ada.Directories;
with Ada.Direct_IO;
with Ada.Exceptions; use Ada.Exceptions;

package body File_Utils is
   package IO renames Ada.Text_IO;

   function Read (File_Name : String) return String is
      File_Size : constant Natural :=
         Natural (Ada.Directories.Size (File_Name));

      subtype File_String is String (1 .. File_Size);
      package File_String_IO is new Ada.Direct_IO (File_String);
      The_File : File_String_IO.File_Type;
      Contents : File_String;
   begin
      File_String_IO.Open
        (File => The_File,
         Mode => File_String_IO.In_File,
         Name => File_Name);

      File_String_IO.Read (The_File, Item => Contents);

      File_String_IO.Close (File => The_File);

      return Contents;
   exception
      when File_String_IO.Device_Error =>
         File_String_IO.Close (File => The_File);
         raise File_String_IO.Device_Error;
   end Read;

   function Is_Dir (Path : String) return Boolean is
      use type Ada.Directories.File_Kind;
   begin
      return Ada.Directories.Exists (Path)
             and then Ada.Directories.Kind (Path) = Ada.Directories.Directory;
   end Is_Dir;

end File_Utils;
