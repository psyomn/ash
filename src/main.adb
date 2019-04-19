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
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

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

   Process_Command_Line_Arguments (l1);

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
