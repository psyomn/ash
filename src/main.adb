with Listeners; use Listeners;

procedure Main is
   Listener_Task : Launch_Listener;

   l1 : constant Listeners.Listener :=
      Make_Listener
        (Port => 3000,
         Root => "./www1",
         Host => "localhost");
begin
   Listener_Task.Construct (l1);
   Listener_Task.Start;
   Listener_Task.Stop;
end Main;
