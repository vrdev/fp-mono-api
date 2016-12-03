{
* environment.h: System.Environment support internal calls
*
* Author:
* Dick Porter (dick@ximian.com)
*
* (C) 2002 Ximian, Inc
}

{$mode objfpc}
unit mono_environment;
interface
uses
  mono_publib;

var
  mono_environment_exitcode_get : function:int32_t;cdecl;
  mono_environment_exitcode_set : procedure(value:int32_t);cdecl;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
  
implementation

procedure free_procs;
begin
  mono_environment_exitcode_get:=nil;
  mono_environment_exitcode_set:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_environment_exitcode_get):=GetProcAddress(hlib,'mono_environment_exitcode_get');
  pointer(mono_environment_exitcode_set):=GetProcAddress(hlib,'mono_environment_exitcode_set');
end;

end.
