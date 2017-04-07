with Ada.Text_IO;
with Ada.Directories;
with Ada.Direct_IO;
with Ada.Exceptions; use Ada.Exceptions;

package body File_Utils is
   package IO renames Ada.Text_IO;

   procedure Write (File_Name : String; Contents : String) is
      The_File_Mode : constant IO.File_Mode := Ada.Text_IO.Out_File;
      The_File      : IO.File_Type;
   begin
      IO.Create
        (File => The_File,
         Mode => The_File_Mode,
         Name => File_Name);

      IO.Put
        (File => The_File,
         Item => Contents);

      IO.Close (File => The_File);
   exception when E : others =>
      IO.Put_Line (Exception_Name (E) & Exception_Message (E));
   end Write;

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
end File_Utils;
