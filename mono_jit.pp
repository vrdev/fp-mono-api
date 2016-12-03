{$mode objfpc} {$H+}
unit mono_jit;
interface

uses
  mono_publib, mono_assembly, mono_metadata, mono_appdomain;

type
  PMonoAotMode = ^MonoAotMode;
  MonoAotMode =  Longint;
const
  MONO_AOT_MODE_NONE = 0;
  MONO_AOT_MODE_NORMAL = 1;
  MONO_AOT_MODE_HYBRID = 2;
  MONO_AOT_MODE_FULL = 3;
  MONO_AOT_MODE_LLVMONLY = 4;

type
  PMonoBreakPolicy = ^MonoBreakPolicy;
  MonoBreakPolicy =  Longint;
const
  MONO_BREAK_POLICY_ALWAYS = 0;
  MONO_BREAK_POLICY_NEVER = 1;
  MONO_BREAK_POLICY_ON_DBG = 2;

type
  MonoBreakPolicyFunc = function (method:PMonoMethod):MonoBreakPolicy;cdecl;

var
  mono_jit_init : function(afile:Pchar):PMonoDomain;cdecl;
  mono_jit_init_version : function(root_domain_name:Pchar; runtime_version:Pchar):PMonoDomain;cdecl;
  mono_jit_exec : function(domain:PMonoDomain; assembly:PMonoAssembly; argc:longint; argv:PPchar):longint;cdecl;
  mono_jit_cleanup : procedure(domain:PMonoDomain);cdecl;
  mono_jit_set_trace_options : function(options:Pchar):mono_bool;cdecl;
  mono_set_signal_chaining : procedure(chain_signals:mono_bool);cdecl;
  mono_set_crash_chaining : procedure(chain_signals:mono_bool);cdecl;
  {*
  * This function is deprecated, use mono_jit_set_aot_mode instead.
  }
  mono_jit_set_aot_only : procedure(aot_only:mono_bool);cdecl;
  {*
  * Allows control over our AOT (Ahead-of-time) compilation mode.
  }
  { Disables AOT mode  }
  { Enables normal AOT mode, equivalent to mono_jit_set_aot_only (false)  }
  { Enables hybrid AOT mode, JIT can still be used for wrappers  }
  { Enables full AOT mode, JIT is disabled and not allowed,
   * equivalent to mono_jit_set_aot_only (true)  }
  { Same as full, but use only llvm compiled code  }




var
  mono_jit_set_aot_mode : procedure(mode:MonoAotMode);cdecl;
  { Allow embedders to decide wherther to actually obey breakpoint instructions
  * in specific methods (works for both break IL instructions and Debugger.Break ()
  * method calls).
  }
  { the default is to always obey the breakpoint  }
  { a nop is inserted instead of a breakpoint  }
  { the breakpoint is executed only if the program has ben started under
  * the debugger (that is if a debugger was attached at the time the method
  * was compiled).
  }



var
  mono_set_break_policy : procedure(policy_callback:MonoBreakPolicyFunc);cdecl;
  mono_jit_parse_options : procedure(argc:longint; argv:PPchar);cdecl;
  mono_get_runtime_build_info : function:Pchar;cdecl;
  { The following APIs are not stable. Avoid if possible.  }
  mono_get_jit_info_from_method : function(domain:PMonoDomain; method:PMonoMethod):PMonoJitInfo;cdecl;
  mono_aot_get_method : function(domain:PMonoDomain; method:PMonoMethod):pointer;cdecl;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation


procedure free_procs;
begin
  mono_jit_init:=nil;
  mono_jit_init_version:=nil;
  mono_jit_exec:=nil;
  mono_jit_cleanup:=nil;
  mono_jit_set_trace_options:=nil;
  mono_set_signal_chaining:=nil;
  mono_set_crash_chaining:=nil;
  mono_jit_set_aot_only:=nil;
  mono_jit_set_aot_mode:=nil;
  mono_set_break_policy:=nil;
  mono_jit_parse_options:=nil;
  mono_get_runtime_build_info:=nil;
  mono_get_jit_info_from_method:=nil;
  mono_aot_get_method:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_jit_init):=GetProcAddress(hlib,'mono_jit_init');
  pointer(mono_jit_init_version):=GetProcAddress(hlib,'mono_jit_init_version');
  pointer(mono_jit_exec):=GetProcAddress(hlib,'mono_jit_exec');
  pointer(mono_jit_cleanup):=GetProcAddress(hlib,'mono_jit_cleanup');
  pointer(mono_jit_set_trace_options):=GetProcAddress(hlib,'mono_jit_set_trace_options');
  pointer(mono_set_signal_chaining):=GetProcAddress(hlib,'mono_set_signal_chaining');
  pointer(mono_set_crash_chaining):=GetProcAddress(hlib,'mono_set_crash_chaining');
  pointer(mono_jit_set_aot_only):=GetProcAddress(hlib,'mono_jit_set_aot_only');
  pointer(mono_jit_set_aot_mode):=GetProcAddress(hlib,'mono_jit_set_aot_mode');
  pointer(mono_set_break_policy):=GetProcAddress(hlib,'mono_set_break_policy');
  pointer(mono_jit_parse_options):=GetProcAddress(hlib,'mono_jit_parse_options');
  pointer(mono_get_runtime_build_info):=GetProcAddress(hlib,'mono_get_runtime_build_info');
  pointer(mono_get_jit_info_from_method):=GetProcAddress(hlib,'mono_get_jit_info_from_method');
  pointer(mono_aot_get_method):=GetProcAddress(hlib,'mono_aot_get_method');
end;

end.
