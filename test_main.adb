with Env_Log;

procedure Test_Main is
begin
    Env_Log.Initialize;

    Env_Log.Error ("error message");
    Env_Log.Warn ("warn message");
    Env_Log.Debug ("debug message");
    Env_Log.Trace ("trace message");
end Test_Main;
