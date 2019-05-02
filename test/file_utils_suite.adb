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
with AUnit.Test_Caller;

with File_Utils_Test; use File_Utils_Test;

package body File_Utils_Suite is

   package Caller is new AUnit.Test_Caller (File_Utils_Test.Test);

   function Suite return Access_Test_Suite is
      Ret : constant Access_Test_Suite := AUnit.Test_Suites.New_Suite;
   begin
      Ret.Add_Test
        (Caller.Create
           ("test read file with normal named string",
            Test_Read_File_With_Normal_Named_String'Access));
      Ret.Add_Test
        (Caller.Create
           ("test read file with null named string",
            Test_Read_File_With_Null_Named_String'Access));
      return Ret;
   end Suite;

end File_Utils_Suite;
