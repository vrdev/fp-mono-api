{$mode objfpc}
unit mono_counters;
interface
uses
  mono_publib;


type
  TMonoCounterType =  Longint;
const
  MONO_COUNTER_INT = 0;
  MONO_COUNTER_UINT = 1;
  MONO_COUNTER_WORD = 2;
  MONO_COUNTER_LONG = 3;
  MONO_COUNTER_ULONG = 4;
  MONO_COUNTER_DOUBLE = 5;
  MONO_COUNTER_STRING = 6;
  MONO_COUNTER_TIME_INTERVAL = 7;
  MONO_COUNTER_TYPE_MASK = $f;
  MONO_COUNTER_CALLBACK = 128;
  MONO_COUNTER_SECTION_MASK = $00ffff00;
  MONO_COUNTER_JIT = 1 shl 8;
  MONO_COUNTER_GC = 1 shl 9;
  MONO_COUNTER_METADATA = 1 shl 10;
  MONO_COUNTER_GENERICS = 1 shl 11;
  MONO_COUNTER_SECURITY = 1 shl 12;
  MONO_COUNTER_RUNTIME = 1 shl 13;
  MONO_COUNTER_SYSTEM = 1 shl 14;
  MONO_COUNTER_PERFCOUNTERS = 1 shl 15;
  MONO_COUNTER_PROFILER = 1 shl 16;
  MONO_COUNTER_LAST_SECTION = (1 shl 16)+1;
  MONO_COUNTER_UNIT_SHIFT = 24;
  MONO_COUNTER_UNIT_MASK = $F shl MONO_COUNTER_UNIT_SHIFT;
  MONO_COUNTER_RAW = 0 shl 24;
  MONO_COUNTER_BYTES = 1 shl 24;
  MONO_COUNTER_TIME = 2 shl 24;
  MONO_COUNTER_COUNT = 3 shl 24;
  MONO_COUNTER_PERCENTAGE = 4 shl 24;
  MONO_COUNTER_VARIANCE_SHIFT = 28;
  MONO_COUNTER_VARIANCE_MASK = $F shl MONO_COUNTER_VARIANCE_SHIFT;
  MONO_COUNTER_MONOTONIC = 1 shl 28;
  MONO_COUNTER_CONSTANT = 1 shl 29;
  MONO_COUNTER_VARIABLE = 1 shl 30;

type
  PFILE  = ^FILE;
  PMonoCounter  = ^MonoCounter;
  MonoCounter = record
  end;

type
  PMonoResourceType = ^MonoResourceType;
  MonoResourceType =  Longint;
const
  MONO_RESOURCE_JIT_CODE = 0;
  MONO_RESOURCE_METADATA = 1;
  MONO_RESOURCE_GC_HEAP = 2;
  MONO_RESOURCE_COUNT = 3;

var
  mono_counters_enable : procedure(section_mask:longint);cdecl;
  mono_counters_init : procedure;cdecl;
  {
  * register addr as the address of a counter of type type.
  * It may be a function pointer if MONO_COUNTER_CALLBACK is specified:
  * the function should return the value and take no arguments.
  }
  mono_counters_register : procedure(descr:Pchar; _type:longint; addr:pointer);cdecl;
  mono_counters_register_with_size : procedure(name:Pchar; _type:longint; addr:pointer; size:longint);cdecl;

type
  MonoCounterRegisterCallback = procedure (_para1:PMonoCounter);cdecl;

var
  mono_counters_on_register : procedure(callback:MonoCounterRegisterCallback);cdecl;
  {
  * Create a readable dump of the counters for section_mask sections (ORed section values)
  }
  mono_counters_dump : procedure(section_mask:longint; outfile:PFILE);cdecl;
  mono_counters_cleanup : procedure;cdecl;

type
  CountersEnumCallback = function (counter:PMonoCounter; user_data:pointer):mono_bool;cdecl;

var
  mono_counters_foreach : procedure(cb:CountersEnumCallback; user_data:pointer);cdecl;
  mono_counters_sample : function(counter:PMonoCounter; buffer:pointer; buffer_size:longint):longint;cdecl;
  mono_counter_get_name : function(name:PMonoCounter):Pchar;cdecl;
  mono_counter_get_type : function(counter:PMonoCounter):longint;cdecl;
  mono_counter_get_section : function(counter:PMonoCounter):longint;cdecl;
  mono_counter_get_unit : function(counter:PMonoCounter):longint;cdecl;
  mono_counter_get_variance : function(counter:PMonoCounter):longint;cdecl;
  mono_counter_get_size : function(counter:PMonoCounter):size_t;cdecl;


type
  MonoResourceCallback = procedure (resource_type:longint; value:uintptr_t; is_soft:longint);cdecl;

var
  mono_runtime_resource_limit : function(resource_type:longint; soft_limit:uintptr_t; hard_limit:uintptr_t):longint;cdecl;
  mono_runtime_resource_set_callback : procedure(callback:MonoResourceCallback);cdecl;
  mono_runtime_resource_check_limit : procedure(resource_type:longint; value:uintptr_t);cdecl;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;

implementation

procedure free_procs;
begin
  mono_counters_enable:=nil;
  mono_counters_init:=nil;
  mono_counters_register:=nil;
  mono_counters_register_with_size:=nil;
  mono_counters_on_register:=nil;
  mono_counters_dump:=nil;
  mono_counters_cleanup:=nil;
  mono_counters_foreach:=nil;
  mono_counters_sample:=nil;
  mono_counter_get_name:=nil;
  mono_counter_get_type:=nil;
  mono_counter_get_section:=nil;
  mono_counter_get_unit:=nil;
  mono_counter_get_variance:=nil;
  mono_counter_get_size:=nil;
  mono_runtime_resource_limit:=nil;
  mono_runtime_resource_set_callback:=nil;
  mono_runtime_resource_check_limit:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_counters_enable):=GetProcAddress(hlib,'mono_counters_enable');
  pointer(mono_counters_init):=GetProcAddress(hlib,'mono_counters_init');
  pointer(mono_counters_register):=GetProcAddress(hlib,'mono_counters_register');
  pointer(mono_counters_register_with_size):=GetProcAddress(hlib,'mono_counters_register_with_size');
  pointer(mono_counters_on_register):=GetProcAddress(hlib,'mono_counters_on_register');
  pointer(mono_counters_dump):=GetProcAddress(hlib,'mono_counters_dump');
  pointer(mono_counters_cleanup):=GetProcAddress(hlib,'mono_counters_cleanup');
  pointer(mono_counters_foreach):=GetProcAddress(hlib,'mono_counters_foreach');
  pointer(mono_counters_sample):=GetProcAddress(hlib,'mono_counters_sample');
  pointer(mono_counter_get_name):=GetProcAddress(hlib,'mono_counter_get_name');
  pointer(mono_counter_get_type):=GetProcAddress(hlib,'mono_counter_get_type');
  pointer(mono_counter_get_section):=GetProcAddress(hlib,'mono_counter_get_section');
  pointer(mono_counter_get_unit):=GetProcAddress(hlib,'mono_counter_get_unit');
  pointer(mono_counter_get_variance):=GetProcAddress(hlib,'mono_counter_get_variance');
  pointer(mono_counter_get_size):=GetProcAddress(hlib,'mono_counter_get_size');
  pointer(mono_runtime_resource_limit):=GetProcAddress(hlib,'mono_runtime_resource_limit');
  pointer(mono_runtime_resource_set_callback):=GetProcAddress(hlib,'mono_runtime_resource_set_callback');
  pointer(mono_runtime_resource_check_limit):=GetProcAddress(hlib,'mono_runtime_resource_check_limit');
end;


end.
