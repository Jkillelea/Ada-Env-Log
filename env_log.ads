with Ada.Text_IO;
with Ada.Environment_Variables;


package Env_Log is
    type Log_Level_Type is (Trace, Debug, Warn, Error);
    Log_Level : Log_Level_Type := Error;

    procedure Initialize;
    procedure Trace (Message : String);
    procedure Debug (Message : String);
    procedure Warn  (Message : String);
    procedure Error (Message : String);

private
    Initialized : Boolean := False;

    procedure Log_With_Level (Message : String; 
                              Level   : Log_Level_Type);
end Env_Log;
