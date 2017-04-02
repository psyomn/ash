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
