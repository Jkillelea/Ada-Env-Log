package body Env_Log is

    -- Get Log Level --
    -- Read the environment variable ADA_LOG
    -- Default to log level of Error on spurious input
    function Get_Log_Level return Log_Level_Type is
        Log_Level_String : String := Ada.Environment_Variables.Value ("ADA_LOG", "ERROR"); -- default value
        Level : Log_Level_Type := Error;
    begin
        Level := Log_Level_Type'Value (Log_Level_String); -- can fail
        return Level;
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
        Error ("Log level is " & Log_Level'Img);
    end Initialize;

    -- Trace --
    -- Only printed if Log_Level is Trace
    procedure Trace (Message : in String) is
    begin
        Log_With_Level (Message, Trace);
    end Trace;

    -- Debug --
    -- Printed if Log_Level is Trace or Debug
    procedure Debug (Message : in String) is
    begin
        Log_With_Level (Message, Debug);
    end Debug;

    -- Warn --
    -- Printed if Log_Level is Trace, Debug, or Warn
    procedure Warn (Message : in String) is
    begin
        Log_With_Level (Message, Warn);
    end Warn;

    -- Error --
    -- Always printed
    procedure Error (Message : in String) is
    begin
        Log_With_Level (Message, Error);
    end Error;

    -- Log With Level --
    -- If the current log level is at or below the level passed, print out the message
    procedure Log_With_Level (Message : in String; Level : Log_Level_Type) is
    begin
        if (not Initialized) then
            return;
        end if;

        if Level in Log_Level .. Error then
            Ada.Text_IO.Put_Line ("[" & Level'Img & "] " & Message);
        end if;
    end Log_With_Level;

end Env_Log;
