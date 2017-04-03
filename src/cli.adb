with Ada.Strings; use Ada.Strings;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

with Common_Utils; use Common_Utils;

package body CLI is
   procedure Process_Command_Line_Arguments (Conf : in out Listener) is
      Total : constant Natural := Argument_Count;
      Count : Positive := 1;
      Skip : Boolean := False;
   begin
      if Total = 0 then
         return;
      end if;

      Argument_Parse_Loop : loop

         declare
            Current_Argument : constant String := Argument (Count);
            First_Two : constant String := Current_Argument (1 .. 2);
            Hyphenated : constant Boolean := Current_Argument (1) = '-';
         begin
            if Count + 1 > Argument_Count and Hyphenated then
               raise CLI_Argument_Exception with "you need to provide a value";
            else
               Skip := True;
            end if;

            if    First_Two = "-r" then Apply_Root_Dir_Flag (Conf, Count);
            elsif First_Two = "-p" then Apply_Port_Flag (Conf, Count);
            elsif First_Two = "-h" then Apply_Host_Flag (Conf, Count);
            else  raise CLI_Argument_Exception with "non existant flag";
            end if;
         end;

         Count := Count + 1 + (if Skip then 1 else 0);
         Skip := False;
         exit Argument_Parse_Loop when Count > Total;

      end loop Argument_Parse_Loop;
   end Process_Command_Line_Arguments;

   procedure Apply_Root_Dir_Flag (Conf : in out Listener; Index : Positive) is
      New_Path : constant String := Trim (
         Source => Argument (Index + 1),
         Side => Both
      );
   begin
      Empty_String (Conf.WS_Root_Path);
      Conf.WS_Root_Path (1 .. New_Path'Last) := New_Path (1 .. New_Path'Last);
   end Apply_Root_Dir_Flag;

   procedure Apply_Port_Flag (Conf : in out Listener; Index : Positive) is
      Arg : constant String := Argument (Index + 1);
      New_Port : constant Natural := Positive'Value (Arg);
   begin
      Conf.Port_Number := New_Port;
   end Apply_Port_Flag;

   procedure Apply_Host_Flag (Conf : in out Listener; Index : Positive) is
      New_Host : constant String := Trim (
         Source => Argument (Index + 1),
         Side => Both
      );
   begin
      Empty_String (Conf.Host_Name);

      Overwrite (
         Source   => Conf.Host_Name,
         Position => 1,
         New_Item => New_Host
      );
   end Apply_Host_Flag;
end CLI;
