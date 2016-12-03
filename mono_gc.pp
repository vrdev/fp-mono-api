{
* mono-gc.h: GC related public interface
}

{$mode objfpc}
unit mono_gc;
interface
uses
  mono_publib, mono_metadata, mono_object;

type
  MonoGCReferences = function (obj:PMonoObject; klass:PMonoClass; size:uintptr_t; num:uintptr_t; refs:PPMonoObject;
               offsets:Puintptr_t; data:pointer):longint;cdecl;
type
  PMonoGCRootSource = ^MonoGCRootSource;
  MonoGCRootSource =  Longint;
const
  MONO_ROOT_SOURCE_EXTERNAL = 0;
  MONO_ROOT_SOURCE_STACK = 1;
  MONO_ROOT_SOURCE_FINALIZER_QUEUE = 2;
  MONO_ROOT_SOURCE_STATIC = 3;
  MONO_ROOT_SOURCE_THREAD_STATIC = 4;
  MONO_ROOT_SOURCE_CONTEXT_STATIC = 5;
  MONO_ROOT_SOURCE_GC_HANDLE = 6;
  MONO_ROOT_SOURCE_JIT = 7;
  MONO_ROOT_SOURCE_THREADING = 8;
  MONO_ROOT_SOURCE_DOMAIN = 9;
  MONO_ROOT_SOURCE_REFLECTION = 10;
  MONO_ROOT_SOURCE_MARSHAL = 11;
  MONO_ROOT_SOURCE_THREAD_POOL = 12;
  MONO_ROOT_SOURCE_DEBUGGER = 13;
  MONO_ROOT_SOURCE_HANDLE = 14;

var
  mono_gc_collect : procedure(generation:longint);cdecl;
  mono_gc_max_generation : function:longint;cdecl;
  mono_gc_get_generation : function(pobject:PMonoObject):longint;cdecl;
  mono_gc_collection_count : function(generation:longint):longint;cdecl;
  mono_gc_get_used_size : function:int64_t;cdecl;
  mono_gc_get_heap_size : function:int64_t;cdecl;
  mono_gc_pending_finalizers : function:MonoBoolean;cdecl;
  mono_gc_finalize_notify : procedure;cdecl;
  mono_gc_invoke_finalizers : function:longint;cdecl;
  { heap walking is only valid in the pre-stop-world event callback  }
  mono_gc_walk_heap : function(flags:longint; callback:MonoGCReferences; data:pointer):longint;cdecl;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation


procedure free_procs;
begin
  mono_gc_collect:=nil;
  mono_gc_max_generation:=nil;
  mono_gc_get_generation:=nil;
  mono_gc_collection_count:=nil;
  mono_gc_get_used_size:=nil;
  mono_gc_get_heap_size:=nil;
  mono_gc_pending_finalizers:=nil;
  mono_gc_finalize_notify:=nil;
  mono_gc_invoke_finalizers:=nil;
  mono_gc_walk_heap:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_gc_collect):=GetProcAddress(hlib,'mono_gc_collect');
  pointer(mono_gc_max_generation):=GetProcAddress(hlib,'mono_gc_max_generation');
  pointer(mono_gc_get_generation):=GetProcAddress(hlib,'mono_gc_get_generation');
  pointer(mono_gc_collection_count):=GetProcAddress(hlib,'mono_gc_collection_count');
  pointer(mono_gc_get_used_size):=GetProcAddress(hlib,'mono_gc_get_used_size');
  pointer(mono_gc_get_heap_size):=GetProcAddress(hlib,'mono_gc_get_heap_size');
  pointer(mono_gc_pending_finalizers):=GetProcAddress(hlib,'mono_gc_pending_finalizers');
  pointer(mono_gc_finalize_notify):=GetProcAddress(hlib,'mono_gc_finalize_notify');
  pointer(mono_gc_invoke_finalizers):=GetProcAddress(hlib,'mono_gc_invoke_finalizers');
  pointer(mono_gc_walk_heap):=GetProcAddress(hlib,'mono_gc_walk_heap');
end;


end.
