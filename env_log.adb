package body Env_Log is

    -- Get Log Level --
    -- Read the environment variable ADA_LOG
    -- Default to log level of Error on spurious input
    function Get_Log_Level return Log_Level_Type is
    begin
        return Log_Level_Type'Value (Ada.Environment_Variables.Value ("ADA_LOG")); -- can fail
    exception
        when others =>    -- anything goes wrong
            return Error; -- default to least verbose and only report errors
    end Get_Log_Level;

    -- Initialize --
    -- Must be called before logging anything
    procedure Initialize is
    begin
        Log_Level := Get_Log_Level;
        Initialized := True;
        -- Debug ("Log level is " & Log_Level'Img);
    end Initialize;

    -- Trace --
    -- Only printed if Log_Level is Trace
    procedure Trace (Message : String) is
    begin
        Log_With_Level (Message, Trace);
    end Trace;

    -- Debug --
    -- Printed if Log_Level is Trace or Debug
    procedure Debug (Message : String) is
    begin
        Log_With_Level (Message, Debug);
    end Debug;

    -- Warn --
    -- Printed if Log_Level is Trace, Debug, or Warn
    procedure Warn (Message : String) is
    begin
        Log_With_Level (Message, Warn);
    end Warn;

    -- Error --
    -- Always printed
    procedure Error (Message : String) is
    begin
        Log_With_Level (Message, Error);
    end Error;

    -- Log With Level --
    -- If the current log level is at or below the level passed, print out the message
    procedure Log_With_Level (Message : String; Level : Log_Level_Type) is
    begin
        if (not Initialized) then
            return;
        end if;

        if Level in Log_Level .. Error then
            Ada.Text_IO.Put_Line ("[" & Level'Img & "] " & Message);
        end if;
    end Log_With_Level;

end Env_Log;
