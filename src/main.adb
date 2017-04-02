with Ada.Text_IO; use Ada.TeXT_IO;

with Ada.Exceptions; use Ada.Exceptions;
with Ada.Text_IO; use Ada.Text_IO;

with Listeners; use Listeners;
with CLI; use CLI;

procedure Main is
   Listener_Task : Launch_Listener;

   l1 : Listeners.Listener :=
      Make_Listener
        (Port => 3000,
         Root => "./www1",
         Host => "localhost");
begin

   Put_Line ("ASDFASD");
   Process_Command_Line_Arguments (l1);
   Put_Line ("ASDASDASDASDASD");

   Listener_Task.Construct (l1);
   Listener_Task.Start;
   Listener_Task.Stop;

exception
   when E : CLI_Argument_Exception =>
      Put_Line ("Error: " & Exception_Message (E));
      New_Line;
      Put_Line ("Example usage: ");
      Put_Line ("ash [-h HOST] [-p PORT] [-r ROOTDIR]");
end Main;
