with Listeners;

procedure Main is
   task type Launch_Listener is
      entry Construct (The_Listener : in Listeners.Listener);
      entry Start;
      entry Stop;
   end Launch_Listener;

   task body Launch_Listener is
      L : Listeners.Listener;
   begin
      accept Construct (The_Listener : in Listeners.Listener) do
         L := The_Listener;
      end Construct;
      accept Start;
      Listeners.Print_Info (L);
      Listeners.Listen (L);
      accept Stop;
   end Launch_Listener;

   function Make_Listener
     (Port : Integer;
      Root : String;
      Host : String) return Listeners.Listener;

   function Make_Listener
     (Port : Integer;
      Root : String;
      Host : String) return Listeners.Listener is
      L : Listeners.Listener;
   begin
      L.Port_Number := Port;
      L.WS_Root_Path (1 .. Root'Last) := Root;
      L.Host_Name (1 .. Host'Last) := Host;
      return L;
   end Make_Listener;

   --  listener tasks
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
