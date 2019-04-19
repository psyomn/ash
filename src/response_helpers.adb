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
with Ada.Calendar;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with GNAT.Calendar.Time_IO;

with Common_Utils; use Common_Utils;

package body Response_Helpers is
   function Headers (Status : HTTP_Status.Code) return String is
      Content_Type : constant String :=
         "Content-Type: text/html; charset=iso-8859-1";
   begin
      return
        First_Header_Line (Status) &
        Response_Date     & CRLF &
        "Server: ash"     & CRLF &
        Content_Type      & CRLF &
        "Content-Length: ";
   end Headers;

   function Response_Date return String is
      package ac  renames Ada.Calendar;
      package gct renames GNAT.Calendar.Time_IO;
      Current_Time : constant ac.Time := ac.Clock;
      Format       : constant gct.Picture_String :=
         "%a, %d %B %Y %H:%M:%S EST";
      Field_Name   : constant String := "Date: ";
      Result : constant String :=
         Field_Name & gct.Image (Current_Time, Format);
   begin
      return Result;
   end Response_Date;

   function Make_Response
     (Status : HTTP_Status.Code; S : String) return String is
      Length       : constant Positive := S'Length;
      Length_Str   : constant String   := Trim (
        Source => Positive'Image (Length),
        Side => Both
      );
   begin
      return
         Headers (Status) & Length_Str &
         CRLF &
         CRLF &
         S;
   end Make_Response;

   function First_Header_Line (Status : HTTP_Status.Code) return String is
      use HTTP_Status;

      Status_Str   : constant String :=
         Integer_To_Trimmed_String (Integer (Status));
      Message      : constant String := Message_Of_Code (Status);
      HTTP_Version : constant String := "1.0";
      Result       : constant String :=
        "HTTP/" & HTTP_Version & " " & Status_Str & " " & Message & CRLF;
   begin
      return Result;
   end First_Header_Line;
end Response_Helpers;
