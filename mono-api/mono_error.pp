{$mode objfpc}
unit mono_error;
interface

uses
  mono_publib;


{
The supplied strings were dup'd by means of calling mono_error_dup_strings.
Something happened while processing the error and the resulting message is incomplete.
}

type
  PMonoErrorCode1 = ^MonoErrorCode1;
  MonoErrorCode1 =  Longint;
const
  MONO_ERROR_FREE_STRINGS = $0001;
  MONO_ERROR_INCOMPLETE = $0002;


type
  PMonoErrorCode2 = ^MonoErrorCode2;
  MonoErrorCode2 =  Longint;
const
  MONO_ERROR_NONE = 0;
  MONO_ERROR_MISSING_METHOD = 1;
  MONO_ERROR_MISSING_FIELD = 2;
  MONO_ERROR_TYPE_LOAD = 3;
  MONO_ERROR_FILE_NOT_FOUND = 4;
  MONO_ERROR_BAD_IMAGE = 5;
  MONO_ERROR_OUT_OF_MEMORY = 6;
  MONO_ERROR_ARGUMENT = 7;
  MONO_ERROR_ARGUMENT_NULL = 11;
  MONO_ERROR_NOT_VERIFIABLE = 8;
  MONO_ERROR_GENERIC = 9;
  MONO_ERROR_EXCEPTION_INSTANCE = 10;
  MONO_ERROR_CLEANUP_CALLED_SENTINEL = $ffff;


type
  PMonoError = ^MonoError;
  MonoError = record
    error_code : word;
    hidden_0 : word;
    hidden_1 : array[0..11] of pointer;
  end;

var
  mono_error_init : procedure(error:PMonoError);cdecl;
  mono_error_init_flags : procedure(error:PMonoError; flags:word);cdecl;
  mono_error_cleanup : procedure(error:PMonoError);cdecl;
  mono_error_ok : function(error:PMonoError):mono_bool;cdecl;
  mono_error_get_error_code : function(error:PMonoError):word;cdecl;
  mono_error_get_message : function(error:PMonoError):Pchar;cdecl;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  

implementation

procedure free_procs;
begin
  mono_error_init:=nil;
  mono_error_init_flags:=nil;
  mono_error_cleanup:=nil;
  mono_error_ok:=nil;
  mono_error_get_error_code:=nil;
  mono_error_get_message:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_error_init):=GetProcAddress(hlib,'mono_error_init');
  pointer(mono_error_init_flags):=GetProcAddress(hlib,'mono_error_init_flags');
  pointer(mono_error_cleanup):=GetProcAddress(hlib,'mono_error_cleanup');
  pointer(mono_error_ok):=GetProcAddress(hlib,'mono_error_ok');
  pointer(mono_error_get_error_code):=GetProcAddress(hlib,'mono_error_get_error_code');
  pointer(mono_error_get_message):=GetProcAddress(hlib,'mono_error_get_message');
end;


end.
