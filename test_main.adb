with Env_Log;

procedure Test_Main is
begin
    -- use the environment variable ADA_LOG to set different log levels
    Env_Log.Initialize;

    Env_Log.Error ("error message");
    Env_Log.Warn ("warn message");
    Env_Log.Debug ("debug message");
    Env_Log.Trace ("trace message");
end Test_Main;
