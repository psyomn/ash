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
with Listeners; use Listeners;

package CLI is
   CLI_Argument_Exception : exception;

   procedure Process_Command_Line_Arguments
     (Conf : in out Listener);

private

   procedure Apply_Port_Flag
     (Conf : in out Listener;
      Index : Positive)
      with Inline;

   procedure Apply_Root_Dir_Flag
     (Conf : in out Listener;
      Index : Positive)
      with Inline;

   procedure Apply_Host_Flag
     (Conf : in out Listener;
      Index : Positive)
      with Inline;
end CLI;
