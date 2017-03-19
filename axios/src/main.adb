with Ada.Strings.Unbounded;

with Listeners;

procedure Main is
  package ASU renames Ada.Strings.Unbounded;

  -- Pointers so we pass to the task types.
  type Listener_Access is access Listeners.Listener;

  task type Launch_Listener(L : Listener_Access) is
    entry Start;
    entry Stop;
  end Launch_Listener;

  task body Launch_Listener is
  begin
    accept Start;
    L.Print_Info;
    L.Listen;
    accept Stop;
  end Launch_Listener;

  l1 : constant Listener_Access :=
    new Listeners.Listener'(
      Port_Number  => 3000,
      Host_Name    => ASU.To_Unbounded_String("localhost"),
      Shutdown     => false,
      WS_Root_Path => ASU.To_Unbounded_String("./www1/")
    );

  -- listener tasks
  Listener_Task : Launch_Listener(L => l1);
begin
  Listener_Task.Start;
  Listener_Task.Stop;
end Main;
