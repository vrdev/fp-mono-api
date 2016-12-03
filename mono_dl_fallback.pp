{$mode objfpc}
unit mono_dl_fallback;
interface

//This is the dynamic loader fallback API

type

  PMonoDlFallbackHandler = ^MonoDlFallbackHandler;
  MonoDlFallbackHandler = record
  end;

type
  TMonoDL =  Longint;
Const
  MONO_DL_EAGER = 0;
  MONO_DL_LAZY = 1;
  MONO_DL_LOCAL = 2;
  MONO_DL_MASK = 3;

type
  //The "err" variable contents must be allocated using g_malloc or g_strdup
  PMonoDlFallbackLoad = ^MonoDlFallbackLoad;
  MonoDlFallbackLoad = function (name:Pchar; flags:longint; err:PPchar; user_data:pointer):pointer;cdecl;
  PMonoDlFallbackSymbol = ^MonoDlFallbackSymbol;
  MonoDlFallbackSymbol = function (handle:pointer; name:Pchar; err:PPchar; user_data:pointer):pointer;cdecl;
  PMonoDlFallbackClose = ^MonoDlFallbackClose;
  MonoDlFallbackClose = function (handle:pointer; user_data:pointer):pointer;cdecl;

var
  mono_dl_fallback_register : function(load_func:MonoDlFallbackLoad; symbol_func:MonoDlFallbackSymbol; close_func:MonoDlFallbackClose; user_data:pointer):PMonoDlFallbackHandler;cdecl;
  mono_dl_fallback_unregister : procedure(handler:PMonoDlFallbackHandler);cdecl;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
  
implementation

procedure free_procs;
begin
  mono_dl_fallback_register:=nil;
  mono_dl_fallback_unregister:=nil;
end;

procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_dl_fallback_register):=GetProcAddress(hlib,'mono_dl_fallback_register');
  pointer(mono_dl_fallback_unregister):=GetProcAddress(hlib,'mono_dl_fallback_unregister');
end;


end.
