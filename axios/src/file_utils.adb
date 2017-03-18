with Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Exceptions; use Ada.Exceptions;

package body File_Utils is
  package IO renames Ada.Text_IO;
  procedure Write(File_Name : String; Contents : String) is
    The_File_Mode : IO.File_Mode := Ada.Text_IO.Out_File;
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
    IO.Put_Line (Exception_Name(E) & Exception_Message(E));
  end Write;

  function Read(File_Name : String) return String is
    The_File_Mode : IO.File_Mode := IO.In_File;
    The_File      : IO.File_Type;
    Contents      : Ada.Strings.Unbounded.Unbounded_String;
  begin
    IO.Open
      (File => The_File,
       Mode => The_File_Mode,
       Name => File_Name);

    while not IO.End_Of_File (The_File) loop
      declare
        Line : String := IO.Get_Line(The_File);
      begin
        Ada.Strings.Unbounded.Append(
          Source => Contents,

          New_Item => Line(1..Line'Last)
        );
      end;
    end loop;

    IO.Close(File => The_File);
    return Ada.Strings.Unbounded.To_String(Contents);
  exception when E : others =>
    IO.Put_Line("Warning: request to a non existant file was made.");
    IO.Put_Line(">> Path: " & File_Name);
    return "Error";
  end Read;
end File_Utils;
