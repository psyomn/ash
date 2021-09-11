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

with Ada.Exceptions; use Ada.Exceptions;
with GNAT.Traceback.Symbolic; use GNAT.Traceback.Symbolic;
with Ada.Text_IO; use Ada.Text_IO;

package Common_Utils is
   --  TODO: I'm not sure if we should really care about inlines. Maybe they
   --  make sense in the functionality bellow, but I would like to empirically
   --  see if any of these make sense.

   procedure Empty_String_Range
     (S : String;
      First : out Positive;
      Last : out Positive)
      with Inline;

   procedure Empty_String (S : in out String)
      with Inline;

   function Header_String (Field : String; Value : String) return String
      with Inline;

   function Header_String (Field : String; Value : Integer) return String
      with Inline;

   function Integer_To_Trimmed_String (I : Integer) return String
      with Inline;

   function Concat_Null_Strings (S1, S2 : String) return String;

   procedure Print_Exception (E       : Exception_Occurrence;
                              Message : String);
end Common_Utils;
