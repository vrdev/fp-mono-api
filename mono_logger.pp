{$mode objfpc}
unit mono_logger;


interface
uses
  mono_publib;

var
  mono_trace_set_level_string : procedure(value:Pchar);cdecl;
  mono_trace_set_mask_string : procedure(value:Pchar);cdecl;


type
  MonoLogCallback = procedure (log_domain:Pchar; log_level:Pchar; message:Pchar; fatal:mono_bool; user_data:pointer);cdecl;
  MonoPrintCallback = procedure (_string:Pchar; is_stdout:mono_bool);cdecl;

var
  mono_trace_set_log_handler : procedure(callback:MonoLogCallback; user_data:pointer);cdecl;
  mono_trace_set_print_handler : procedure(callback:MonoPrintCallback);cdecl;
  mono_trace_set_printerr_handler : procedure(callback:MonoPrintCallback);cdecl;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation


procedure free_procs;
begin
  mono_trace_set_level_string:=nil;
  mono_trace_set_mask_string:=nil;
  mono_trace_set_log_handler:=nil;
  mono_trace_set_print_handler:=nil;
  mono_trace_set_printerr_handler:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_trace_set_level_string):=GetProcAddress(hlib,'mono_trace_set_level_string');
  pointer(mono_trace_set_mask_string):=GetProcAddress(hlib,'mono_trace_set_mask_string');
  pointer(mono_trace_set_log_handler):=GetProcAddress(hlib,'mono_trace_set_log_handler');
  pointer(mono_trace_set_print_handler):=GetProcAddress(hlib,'mono_trace_set_print_handler');
  pointer(mono_trace_set_printerr_handler):=GetProcAddress(hlib,'mono_trace_set_printerr_handler');
end;

end.
