with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body CLI is
   procedure Process_Command_Line_Arguments (Conf : in out Listener) is
      Total : Positive := Argument_Count;
      Count : Positive := 1;
      Skip : Boolean := False;
   begin
      if Total = 0 then return; end if;

      loop
         declare
            First_Two : constant String := Argument (Count) (1 .. 2);
         begin
            if Count + 1 > Argument_Count and First_Two (1) = '-' then
               raise CLI_Argument_Exception with "you need to provide a value";
            else
               Skip := True;
            end if;

            if    First_Two = "-r" then Apply_Root_Dir_Flag (Conf, Count);
            elsif First_Two = "-p" then Apply_Port_Flag (Conf, Count);
            elsif First_Two = "-h" then Apply_Host_Flag (Conf, Count);
            end if;
         end;

         exit when Count > Total;

         Count := Count + 1 + (if Skip then 1 else 0);
      end loop;
   end Process_Command_Line_Arguments;

   procedure Apply_Root_Dir_Flag (Conf : in out Listener; Index : Positive) is
      New_Path : constant String := Argument (Index + 1);
   begin
      Delete (
         Source  => Conf.WS_Root_Path,
         From    => 1,
         Through => Conf.WS_Root_Path'Last
      );

      Overwrite (
         Source   => Conf.WS_Root_Path,
         Position => 1,
         New_Item => New_Path
      );
   end Apply_Root_Dir_Flag;

   procedure Apply_Port_Flag (Conf : in out Listener; Index : Positive) is
      Arg : constant String := Argument (Index);
      New_Port : constant Positive := Positive'Value (Arg);
   begin
      Conf.Port_Number := New_Port;
   end Apply_Port_Flag;

   procedure Apply_Host_Flag (Conf : in out Listener; Index : Positive) is
      New_Host : constant String := Argument (Index);
   begin
      Delete (
         Source  => Conf.Host_Name,
         From    => 1,
         Through => Conf.Host_Name'Last
      );

      Overwrite (
         Source   => Conf.Host_Name,
         Position => 1,
         New_Item => New_Host
      );
   end Apply_Host_Flag;
end CLI;
