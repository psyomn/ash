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
package Common_Utils is
   function Integer_To_Trimmed_String (I : Integer) return String
      with Inline;

   function Header_String (Field : String; Value : String) return String
      with Inline;

   function Header_String (Field : String; Value : Integer) return String
      with Inline;

   procedure Empty_String_Range
     (S : String;
      First : out Positive;
      Last : out Positive)
      with Inline;

   procedure Empty_String (S : in out String)
      with Inline;
end Common_Utils;
