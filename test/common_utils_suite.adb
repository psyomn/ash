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

with Common_Utils_Test; use Common_Utils_Test;

package body Common_Utils_Suite is

   package Caller is new AUnit.Test_Caller (Common_Utils_Test.Test);

   function Suite return Access_Test_Suite is
      Ret : constant Access_Test_Suite := AUnit.Test_Suites.New_Suite;
   begin
      Ret.Add_Test
        (Caller.Create ("test integer to trimmed string",
                       Test_Integer_To_Trimmed_String'Access));
      Ret.Add_Test
        (Caller.Create ("Test header string",
                        Test_Header_String'Access));
      Ret.Add_Test
        (Caller.Create ("Test header string integer",
                        Test_Header_String_Integer'Access));
      Ret.Add_Test
        (Caller.Create ("Test empty string",
                        Test_Empty_String'Access));
      Ret.Add_Test
        (Caller.Create ("test empty string range",
                        Test_Empty_String_Range'Access));
      Ret.Add_Test
        (Caller.Create ("test concat null string",
                        Test_Concat_Null_String'Access));
      return Ret;
   end Suite;

end Common_Utils_Suite;
