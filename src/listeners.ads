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
package Listeners is
   type Listener is record
      Port_Number  : Integer range 0 .. 16#ffff#;
      Shutdown     : Boolean := False;
      WS_Root_Path : String (1 .. 256) :=
        (others => Character'Val (0));
      Host_Name    : String (1 .. 256) :=
        (others => Character'Val (0));
   end record;

   task type Launch_Listener is
      entry Construct (The_Listener : in Listeners.Listener);
      entry Start;
      entry Stop;
   end Launch_Listener;

   function Make_Listener
     (Port : Integer;
      Root : String;
      Host : String) return Listeners.Listener;

   procedure Print_Info (L : Listener);
   procedure Listen (L : Listener);
end Listeners;
