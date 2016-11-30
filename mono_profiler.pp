{$mode objfpc}
unit mono_profiler;

interface
uses
  mono_publib, mono_object, mono_appdomain, mono_metadata, mono_assembly;

const
  MONO_PROFILER_MAX_STAT_CALL_CHAIN_DEPTH = 128;


type

  PMonoProfiler = ^MonoProfiler;
  MonoProfiler = record
  end;

type
  PMonoProfileFlags = ^MonoProfileFlags;
  MonoProfileFlags =  Longint;
const
  MONO_PROFILE_NONE = 0;
  MONO_PROFILE_APPDOMAIN_EVENTS = 1 shl 0;
  MONO_PROFILE_ASSEMBLY_EVENTS = 1 shl 1;
  MONO_PROFILE_MODULE_EVENTS = 1 shl 2;
  MONO_PROFILE_CLASS_EVENTS = 1 shl 3;
  MONO_PROFILE_JIT_COMPILATION = 1 shl 4;
  MONO_PROFILE_INLINING = 1 shl 5;
  MONO_PROFILE_EXCEPTIONS = 1 shl 6;
  MONO_PROFILE_ALLOCATIONS = 1 shl 7;
  MONO_PROFILE_GC = 1 shl 8;
  MONO_PROFILE_THREADS = 1 shl 9;
  MONO_PROFILE_REMOTING = 1 shl 10;
  MONO_PROFILE_TRANSITIONS = 1 shl 11;
  MONO_PROFILE_ENTER_LEAVE = 1 shl 12;
  MONO_PROFILE_COVERAGE = 1 shl 13;
  MONO_PROFILE_INS_COVERAGE = 1 shl 14;
  MONO_PROFILE_STATISTICAL = 1 shl 15;
  MONO_PROFILE_METHOD_EVENTS = 1 shl 16;
  MONO_PROFILE_MONITOR_EVENTS = 1 shl 17;
  MONO_PROFILE_IOMAP_EVENTS = 1 shl 18;  { this should likely be removed, too  }
  MONO_PROFILE_GC_MOVES = 1 shl 19;
  MONO_PROFILE_GC_ROOTS = 1 shl 20;
  MONO_PROFILE_CONTEXT_EVENTS = 1 shl 21;
  MONO_PROFILE_GC_FINALIZATION = 1 shl 22;

type
  PMonoProfileResult = ^MonoProfileResult;
  MonoProfileResult =  Longint;
const
  MONO_PROFILE_OK = 0;
  MONO_PROFILE_FAILED = 1;

  { Keep somewhat in sync with libgc/include/gc.h:enum GC_EventType }
  {
  * This is the actual arrival order of the following events:
  *
  * MONO_GC_EVENT_PRE_STOP_WORLD
  * MONO_GC_EVENT_PRE_STOP_WORLD_LOCKED
  * MONO_GC_EVENT_POST_STOP_WORLD
  * MONO_GC_EVENT_PRE_START_WORLD
  * MONO_GC_EVENT_POST_START_WORLD_UNLOCKED
  * MONO_GC_EVENT_POST_START_WORLD
  *
  * The LOCKED and UNLOCKED events guarantee that, by the time they arrive,
  * the GC and suspend locks will both have been acquired and released,
  * respectively.
  }

type
  PMonoGCEvent = ^MonoGCEvent;
  MonoGCEvent =  Longint;
const
  MONO_GC_EVENT_START = 0;
  MONO_GC_EVENT_MARK_START = 1;
  MONO_GC_EVENT_MARK_END = 2;
  MONO_GC_EVENT_RECLAIM_START = 3;
  MONO_GC_EVENT_RECLAIM_END = 4;
  MONO_GC_EVENT_END = 5;
  MONO_GC_EVENT_PRE_STOP_WORLD = 6;
  MONO_GC_EVENT_POST_STOP_WORLD = 7;
  MONO_GC_EVENT_PRE_START_WORLD = 8;
  MONO_GC_EVENT_POST_START_WORLD = 9;
  MONO_GC_EVENT_PRE_STOP_WORLD_LOCKED = 10;
  MONO_GC_EVENT_POST_START_WORLD_UNLOCKED = 11;

  { coverage info  }
type
  PMonoProfileCoverageEntry = ^MonoProfileCoverageEntry;
  MonoProfileCoverageEntry = record
    method : PMonoMethod;
    iloffset : longint;
    counter : longint;
    filename : Pchar;
    line : longint;
    col : longint;
    end;

{ executable code buffer info  }
type
  PMonoProfilerCodeBufferType = ^MonoProfilerCodeBufferType;
  MonoProfilerCodeBufferType =  Longint;
const
  MONO_PROFILER_CODE_BUFFER_UNKNOWN = 0;
  MONO_PROFILER_CODE_BUFFER_METHOD = 1;
  MONO_PROFILER_CODE_BUFFER_METHOD_TRAMPOLINE = 2;
  MONO_PROFILER_CODE_BUFFER_UNBOX_TRAMPOLINE = 3;
  MONO_PROFILER_CODE_BUFFER_IMT_TRAMPOLINE = 4;
  MONO_PROFILER_CODE_BUFFER_GENERICS_TRAMPOLINE = 5;
  MONO_PROFILER_CODE_BUFFER_SPECIFIC_TRAMPOLINE = 6;
  MONO_PROFILER_CODE_BUFFER_HELPER = 7;
  MONO_PROFILER_CODE_BUFFER_MONITOR = 8;
  MONO_PROFILER_CODE_BUFFER_DELEGATE_INVOKE = 9;
  MONO_PROFILER_CODE_BUFFER_EXCEPTION_HANDLING = 10;
  MONO_PROFILER_CODE_BUFFER_LAST = 11;

type
  PMonoProfilerMonitorEvent = ^MonoProfilerMonitorEvent;
  MonoProfilerMonitorEvent =  Longint;
const
    MONO_PROFILER_MONITOR_CONTENTION = 1;
    MONO_PROFILER_MONITOR_DONE = 2;
    MONO_PROFILER_MONITOR_FAIL = 3;

type
  PMonoProfilerCallChainStrategy = ^MonoProfilerCallChainStrategy;
  MonoProfilerCallChainStrategy =  Longint;
const
  MONO_PROFILER_CALL_CHAIN_NONE = 0;
  MONO_PROFILER_CALL_CHAIN_NATIVE = 1;
  MONO_PROFILER_CALL_CHAIN_GLIBC = 2;
  MONO_PROFILER_CALL_CHAIN_MANAGED = 3;
  MONO_PROFILER_CALL_CHAIN_INVALID = 4;

type
  PMonoProfileGCHandleEvent = ^MonoProfileGCHandleEvent;
  MonoProfileGCHandleEvent =  Longint;
const
  MONO_PROFILER_GC_HANDLE_CREATED = 0;
  MONO_PROFILER_GC_HANDLE_DESTROYED = 1;

{ the above are flags, the type is in the low 2 bytes  }
{ could be stack, handle, etc.  }

type
  PMonoProfileGCRootType = ^MonoProfileGCRootType;
  MonoProfileGCRootType =  Longint;
 const
  MONO_PROFILE_GC_ROOT_PINNING = 1 shl 8;
  MONO_PROFILE_GC_ROOT_WEAKREF = 2 shl 8;
  MONO_PROFILE_GC_ROOT_INTERIOR = 4 shl 8;
  MONO_PROFILE_GC_ROOT_STACK = 0;
  MONO_PROFILE_GC_ROOT_FINALIZER = 1;
  MONO_PROFILE_GC_ROOT_HANDLE = 2;
  MONO_PROFILE_GC_ROOT_OTHER = 3;
  MONO_PROFILE_GC_ROOT_MISC = 4;
  MONO_PROFILE_GC_ROOT_TYPEMASK = $ff;
{
* Functions that the runtime will call on the profiler.
}
type
  MonoProfileFunc = procedure (prof:PMonoProfiler);cdecl;
  MonoProfileAppDomainFunc = procedure (prof:PMonoProfiler; domain:PMonoDomain);cdecl;
  MonoProfileContextFunc = procedure (prof:PMonoProfiler; context:PMonoAppContext);cdecl;
  MonoProfileMethodFunc = procedure (prof:PMonoProfiler; method:PMonoMethod);cdecl;
  MonoProfileClassFunc = procedure (prof:PMonoProfiler; klass:PMonoClass);cdecl;
  MonoProfileModuleFunc = procedure (prof:PMonoProfiler; module:PMonoImage);cdecl;
  MonoProfileAssemblyFunc = procedure (prof:PMonoProfiler; assembly:PMonoAssembly);cdecl;
  MonoProfileMonitorFunc = procedure (prof:PMonoProfiler; obj:PMonoObject; event:MonoProfilerMonitorEvent);cdecl;
  MonoProfileExceptionFunc = procedure (prof:PMonoProfiler; pobject:PMonoObject);cdecl;
  MonoProfileExceptionClauseFunc = procedure (prof:PMonoProfiler; method:PMonoMethod; clause_type:longint; clause_num:longint);cdecl;
  MonoProfileAppDomainResult = procedure (prof:PMonoProfiler; domain:PMonoDomain; result:longint);cdecl;
  MonoProfileAppDomainFriendlyNameFunc = procedure (prof:PMonoProfiler; domain:PMonoDomain; name:Pchar);cdecl;
  MonoProfileMethodResult = procedure (prof:PMonoProfiler; method:PMonoMethod; result:longint);cdecl;
  MonoProfileJitResult = procedure (prof:PMonoProfiler; method:PMonoMethod; jinfo:PMonoJitInfo; result:longint);cdecl;
  MonoProfileClassResult = procedure (prof:PMonoProfiler; klass:PMonoClass; result:longint);cdecl;
  MonoProfileModuleResult = procedure (prof:PMonoProfiler; module:PMonoImage; result:longint);cdecl;
  MonoProfileAssemblyResult = procedure (prof:PMonoProfiler; assembly:PMonoAssembly; result:longint);cdecl;
  MonoProfileMethodInline = procedure (prof:PMonoProfiler; parent:PMonoMethod; child:PMonoMethod; ok:Plongint);cdecl;
  MonoProfileThreadFunc = procedure (prof:PMonoProfiler; tid:uintptr_t);cdecl;
  MonoProfileThreadNameFunc = procedure (prof:PMonoProfiler; tid:uintptr_t; name:Pchar);cdecl;
  MonoProfileAllocFunc = procedure (prof:PMonoProfiler; obj:PMonoObject; klass:PMonoClass);cdecl;
  MonoProfileStatFunc = procedure (prof:PMonoProfiler; ip:Pmono_byte; context:pointer);cdecl;
  MonoProfileStatCallChainFunc = procedure (prof:PMonoProfiler; call_chain_depth:longint; ip:PPmono_byte; context:pointer);cdecl;
  MonoProfileGCFunc = procedure (prof:PMonoProfiler; event:MonoGCEvent; generation:longint);cdecl;
  MonoProfileGCMoveFunc = procedure (prof:PMonoProfiler; objects:Ppointer; num:longint);cdecl;
  MonoProfileGCResizeFunc = procedure (prof:PMonoProfiler; new_size:int64_t);cdecl;
  MonoProfileGCHandleFunc = procedure (prof:PMonoProfiler; op:longint; _type:longint; handle:uintptr_t; obj:PMonoObject);cdecl;
  MonoProfileGCRootFunc = procedure (prof:PMonoProfiler; num_roots:longint; objects:Ppointer; root_types:Plongint; extra_info:Puintptr_t);cdecl;
  MonoProfileGCFinalizeFunc = procedure (prof:PMonoProfiler);cdecl;
  MonoProfileGCFinalizeObjectFunc = procedure (prof:PMonoProfiler; obj:PMonoObject);cdecl;
  MonoProfileIomapFunc = procedure (prof:PMonoProfiler; report:Pchar; pathname:Pchar; new_pathname:Pchar);cdecl;
  MonoProfileCoverageFilterFunc = function (prof:PMonoProfiler; method:PMonoMethod):mono_bool;cdecl;
  MonoProfileCoverageFunc = procedure (prof:PMonoProfiler; entry:PMonoProfileCoverageEntry);cdecl;
  MonoProfilerCodeChunkNew = procedure (prof:PMonoProfiler; chunk:pointer; size:longint);cdecl;
  MonoProfilerCodeChunkDestroy = procedure (prof:PMonoProfiler; chunk:pointer);cdecl;
  MonoProfilerCodeBufferNew = procedure (prof:PMonoProfiler; buffer:pointer; size:longint; _type:MonoProfilerCodeBufferType; data:pointer);cdecl;
  {
  * Function the profiler may call.
  }
var
  mono_profiler_install : procedure(prof:PMonoProfiler; shutdown_callback:MonoProfileFunc);
  mono_profiler_set_events : procedure(events:MonoProfileFlags);
  mono_profiler_get_events : function:MonoProfileFlags;
  mono_profiler_install_appdomain : procedure(start_load:MonoProfileAppDomainFunc; end_load:MonoProfileAppDomainResult; start_unload:MonoProfileAppDomainFunc; end_unload:MonoProfileAppDomainFunc);
  mono_profiler_install_appdomain_name : procedure(domain_name_cb:MonoProfileAppDomainFriendlyNameFunc);
  mono_profiler_install_context : procedure(load:MonoProfileContextFunc; unload:MonoProfileContextFunc);
  mono_profiler_install_assembly : procedure(start_load:MonoProfileAssemblyFunc; end_load:MonoProfileAssemblyResult; start_unload:MonoProfileAssemblyFunc; end_unload:MonoProfileAssemblyFunc);
  mono_profiler_install_module : procedure(start_load:MonoProfileModuleFunc; end_load:MonoProfileModuleResult; start_unload:MonoProfileModuleFunc; end_unload:MonoProfileModuleFunc);
  mono_profiler_install_class : procedure(start_load:MonoProfileClassFunc; end_load:MonoProfileClassResult; start_unload:MonoProfileClassFunc; end_unload:MonoProfileClassFunc);
  mono_profiler_install_jit_compile : procedure(start:MonoProfileMethodFunc; pend:MonoProfileMethodResult);
  mono_profiler_install_jit_end : procedure(pend:MonoProfileJitResult);
  mono_profiler_install_method_free : procedure(callback:MonoProfileMethodFunc);
  mono_profiler_install_method_invoke : procedure(start:MonoProfileMethodFunc; pend:MonoProfileMethodFunc);
  mono_profiler_install_enter_leave : procedure(enter:MonoProfileMethodFunc; fleave:MonoProfileMethodFunc);
  mono_profiler_install_thread : procedure(start:MonoProfileThreadFunc; pend:MonoProfileThreadFunc);
  mono_profiler_install_thread_name : procedure(thread_name_cb:MonoProfileThreadNameFunc);
  mono_profiler_install_transition : procedure(callback:MonoProfileMethodResult);
  mono_profiler_install_allocation : procedure(callback:MonoProfileAllocFunc);
  mono_profiler_install_monitor : procedure(callback:MonoProfileMonitorFunc);
  mono_profiler_install_statistical : procedure(callback:MonoProfileStatFunc);
  mono_profiler_install_statistical_call_chain : procedure(callback:MonoProfileStatCallChainFunc; call_chain_depth:longint; call_chain_strategy:MonoProfilerCallChainStrategy);
  mono_profiler_install_exception : procedure(throw_callback:MonoProfileExceptionFunc; exc_method_leave:MonoProfileMethodFunc; clause_callback:MonoProfileExceptionClauseFunc);
  mono_profiler_install_coverage_filter : procedure(callback:MonoProfileCoverageFilterFunc);
  mono_profiler_coverage_get : procedure(prof:PMonoProfiler; method:PMonoMethod; func:MonoProfileCoverageFunc);
  mono_profiler_install_gc : procedure(callback:MonoProfileGCFunc; heap_resize_callback:MonoProfileGCResizeFunc);
  mono_profiler_install_gc_moves : procedure(callback:MonoProfileGCMoveFunc);
  mono_profiler_install_gc_roots : procedure(handle_callback:MonoProfileGCHandleFunc; roots_callback:MonoProfileGCRootFunc);
  mono_profiler_install_gc_finalize : procedure(pbegin:MonoProfileGCFinalizeFunc; begin_obj:MonoProfileGCFinalizeObjectFunc; end_obj:MonoProfileGCFinalizeObjectFunc; pend:MonoProfileGCFinalizeFunc);
  mono_profiler_install_runtime_initialized : procedure(runtime_initialized_callback:MonoProfileFunc);
  mono_profiler_install_code_chunk_new : procedure(callback:MonoProfilerCodeChunkNew);
  mono_profiler_install_code_chunk_destroy : procedure(callback:MonoProfilerCodeChunkDestroy);
  mono_profiler_install_code_buffer_new : procedure(callback:MonoProfilerCodeBufferNew);
  mono_profiler_install_iomap : procedure(callback:MonoProfileIomapFunc);
  mono_profiler_load : procedure(desc:Pchar);
  { Elapsed time is tracked by user+kernel time of the process - this is the default }
  { Elapsed time is tracked by wallclock time  }

type
  PMonoProfileSamplingMode = ^MonoProfileSamplingMode;
  MonoProfileSamplingMode =  Longint;
const
  MONO_PROFILER_STAT_MODE_PROCESS = 0;
  MONO_PROFILER_STAT_MODE_REAL = 1;

var
  mono_profiler_set_statistical_mode : procedure(mode:MonoProfileSamplingMode; sampling_frequency_hz:int64_t);

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   

implementation

procedure free_procs;
begin
  mono_profiler_install:=nil;
  mono_profiler_set_events:=nil;
  mono_profiler_get_events:=nil;
  mono_profiler_install_appdomain:=nil;
  mono_profiler_install_appdomain_name:=nil;
  mono_profiler_install_context:=nil;
  mono_profiler_install_assembly:=nil;
  mono_profiler_install_module:=nil;
  mono_profiler_install_class:=nil;
  mono_profiler_install_jit_compile:=nil;
  mono_profiler_install_jit_end:=nil;
  mono_profiler_install_method_free:=nil;
  mono_profiler_install_method_invoke:=nil;
  mono_profiler_install_enter_leave:=nil;
  mono_profiler_install_thread:=nil;
  mono_profiler_install_thread_name:=nil;
  mono_profiler_install_transition:=nil;
  mono_profiler_install_allocation:=nil;
  mono_profiler_install_monitor:=nil;
  mono_profiler_install_statistical:=nil;
  mono_profiler_install_statistical_call_chain:=nil;
  mono_profiler_install_exception:=nil;
  mono_profiler_install_coverage_filter:=nil;
  mono_profiler_coverage_get:=nil;
  mono_profiler_install_gc:=nil;
  mono_profiler_install_gc_moves:=nil;
  mono_profiler_install_gc_roots:=nil;
  mono_profiler_install_gc_finalize:=nil;
  mono_profiler_install_runtime_initialized:=nil;
  mono_profiler_install_code_chunk_new:=nil;
  mono_profiler_install_code_chunk_destroy:=nil;
  mono_profiler_install_code_buffer_new:=nil;
  mono_profiler_install_iomap:=nil;
  mono_profiler_load:=nil;
  mono_profiler_set_statistical_mode:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_profiler_install):=GetProcAddress(hlib,'mono_profiler_install');
  pointer(mono_profiler_set_events):=GetProcAddress(hlib,'mono_profiler_set_events');
  pointer(mono_profiler_get_events):=GetProcAddress(hlib,'mono_profiler_get_events');
  pointer(mono_profiler_install_appdomain):=GetProcAddress(hlib,'mono_profiler_install_appdomain');
  pointer(mono_profiler_install_appdomain_name):=GetProcAddress(hlib,'mono_profiler_install_appdomain_name');
  pointer(mono_profiler_install_context):=GetProcAddress(hlib,'mono_profiler_install_context');
  pointer(mono_profiler_install_assembly):=GetProcAddress(hlib,'mono_profiler_install_assembly');
  pointer(mono_profiler_install_module):=GetProcAddress(hlib,'mono_profiler_install_module');
  pointer(mono_profiler_install_class):=GetProcAddress(hlib,'mono_profiler_install_class');
  pointer(mono_profiler_install_jit_compile):=GetProcAddress(hlib,'mono_profiler_install_jit_compile');
  pointer(mono_profiler_install_jit_end):=GetProcAddress(hlib,'mono_profiler_install_jit_end');
  pointer(mono_profiler_install_method_free):=GetProcAddress(hlib,'mono_profiler_install_method_free');
  pointer(mono_profiler_install_method_invoke):=GetProcAddress(hlib,'mono_profiler_install_method_invoke');
  pointer(mono_profiler_install_enter_leave):=GetProcAddress(hlib,'mono_profiler_install_enter_leave');
  pointer(mono_profiler_install_thread):=GetProcAddress(hlib,'mono_profiler_install_thread');
  pointer(mono_profiler_install_thread_name):=GetProcAddress(hlib,'mono_profiler_install_thread_name');
  pointer(mono_profiler_install_transition):=GetProcAddress(hlib,'mono_profiler_install_transition');
  pointer(mono_profiler_install_allocation):=GetProcAddress(hlib,'mono_profiler_install_allocation');
  pointer(mono_profiler_install_monitor):=GetProcAddress(hlib,'mono_profiler_install_monitor');
  pointer(mono_profiler_install_statistical):=GetProcAddress(hlib,'mono_profiler_install_statistical');
  pointer(mono_profiler_install_statistical_call_chain):=GetProcAddress(hlib,'mono_profiler_install_statistical_call_chain');
  pointer(mono_profiler_install_exception):=GetProcAddress(hlib,'mono_profiler_install_exception');
  pointer(mono_profiler_install_coverage_filter):=GetProcAddress(hlib,'mono_profiler_install_coverage_filter');
  pointer(mono_profiler_coverage_get):=GetProcAddress(hlib,'mono_profiler_coverage_get');
  pointer(mono_profiler_install_gc):=GetProcAddress(hlib,'mono_profiler_install_gc');
  pointer(mono_profiler_install_gc_moves):=GetProcAddress(hlib,'mono_profiler_install_gc_moves');
  pointer(mono_profiler_install_gc_roots):=GetProcAddress(hlib,'mono_profiler_install_gc_roots');
  pointer(mono_profiler_install_gc_finalize):=GetProcAddress(hlib,'mono_profiler_install_gc_finalize');
  pointer(mono_profiler_install_runtime_initialized):=GetProcAddress(hlib,'mono_profiler_install_runtime_initialized');
  pointer(mono_profiler_install_code_chunk_new):=GetProcAddress(hlib,'mono_profiler_install_code_chunk_new');
  pointer(mono_profiler_install_code_chunk_destroy):=GetProcAddress(hlib,'mono_profiler_install_code_chunk_destroy');
  pointer(mono_profiler_install_code_buffer_new):=GetProcAddress(hlib,'mono_profiler_install_code_buffer_new');
  pointer(mono_profiler_install_iomap):=GetProcAddress(hlib,'mono_profiler_install_iomap');
  pointer(mono_profiler_load):=GetProcAddress(hlib,'mono_profiler_load');
  pointer(mono_profiler_set_statistical_mode):=GetProcAddress(hlib,'mono_profiler_set_statistical_mode');
end;


end.
