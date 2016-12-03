{
* threads.h: Threading API
*
* Author:
*  Dick Porter (dick@ximian.com)
*  Patrik Torstensson (patrik.torstensson@labs2.com)
*
* (C) 2001 Ximian, Inc
}

{$mode objfpc}
unit mono_threads;

interface
uses
  mono_publib, mono_object, mono_appdomain, mono_metadata;


{ This callback should return TRUE if the runtime must wait for the thread, FALSE otherwise  }
type
  MonoThreadManageCallback = function (thread:PMonoThread):mono_bool;cdecl;

var
  mono_thread_init : procedure(start_cb:MonoThreadStartCB; attach_cb:MonoThreadAttachCB);cdecl;
  mono_thread_cleanup : procedure;cdecl;
  mono_thread_manage : procedure;cdecl;
  mono_thread_current : function:PMonoThread;cdecl;
  mono_thread_set_main : procedure(thread:PMonoThread);cdecl;
  mono_thread_get_main : function:PMonoThread;cdecl;
  mono_thread_stop : procedure(thread:PMonoThread);cdecl;
  mono_thread_new_init : procedure(tid:intptr_t; stack_start:pointer; func:pointer);cdecl;
  mono_thread_create : procedure(domain:PMonoDomain; func:pointer; arg:pointer);cdecl;
  mono_thread_attach : function(domain:PMonoDomain):PMonoThread;cdecl;
  mono_thread_detach : procedure(thread:PMonoThread);cdecl;
  mono_thread_exit : procedure;cdecl;
  mono_thread_get_name_utf8 : function(thread:PMonoThread):Pchar;cdecl;
  mono_thread_get_managed_id : function(thread:PMonoThread):int32_t;cdecl;
  mono_thread_set_manage_callback : procedure(thread:PMonoThread; func:MonoThreadManageCallback);
  mono_threads_set_default_stacksize : procedure(stacksize:uint32_t);cdecl;
  mono_threads_get_default_stacksize : function:uint32_t;cdecl;
  mono_threads_request_thread_dump : procedure;cdecl;
  mono_thread_is_foreign : function(thread:PMonoThread):mono_bool;cdecl;
  mono_thread_detach_if_exiting : function:mono_bool;cdecl;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation


procedure free_procs;
begin
  mono_thread_init:=nil;
  mono_thread_cleanup:=nil;
  mono_thread_manage:=nil;
  mono_thread_current:=nil;
  mono_thread_set_main:=nil;
  mono_thread_get_main:=nil;
  mono_thread_stop:=nil;
  mono_thread_new_init:=nil;
  mono_thread_create:=nil;
  mono_thread_attach:=nil;
  mono_thread_detach:=nil;
  mono_thread_exit:=nil;
  mono_thread_get_name_utf8:=nil;
  mono_thread_get_managed_id:=nil;
  mono_thread_set_manage_callback:=nil;
  mono_threads_set_default_stacksize:=nil;
  mono_threads_get_default_stacksize:=nil;
  mono_threads_request_thread_dump:=nil;
  mono_thread_is_foreign:=nil;
  mono_thread_detach_if_exiting:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_thread_init):=GetProcAddress(hlib,'mono_thread_init');
  pointer(mono_thread_cleanup):=GetProcAddress(hlib,'mono_thread_cleanup');
  pointer(mono_thread_manage):=GetProcAddress(hlib,'mono_thread_manage');
  pointer(mono_thread_current):=GetProcAddress(hlib,'mono_thread_current');
  pointer(mono_thread_set_main):=GetProcAddress(hlib,'mono_thread_set_main');
  pointer(mono_thread_get_main):=GetProcAddress(hlib,'mono_thread_get_main');
  pointer(mono_thread_stop):=GetProcAddress(hlib,'mono_thread_stop');
  pointer(mono_thread_new_init):=GetProcAddress(hlib,'mono_thread_new_init');
  pointer(mono_thread_create):=GetProcAddress(hlib,'mono_thread_create');
  pointer(mono_thread_attach):=GetProcAddress(hlib,'mono_thread_attach');
  pointer(mono_thread_detach):=GetProcAddress(hlib,'mono_thread_detach');
  pointer(mono_thread_exit):=GetProcAddress(hlib,'mono_thread_exit');
  pointer(mono_thread_get_name_utf8):=GetProcAddress(hlib,'mono_thread_get_name_utf8');
  pointer(mono_thread_get_managed_id):=GetProcAddress(hlib,'mono_thread_get_managed_id');
  pointer(mono_thread_set_manage_callback):=GetProcAddress(hlib,'mono_thread_set_manage_callback');
  pointer(mono_threads_set_default_stacksize):=GetProcAddress(hlib,'mono_threads_set_default_stacksize');
  pointer(mono_threads_get_default_stacksize):=GetProcAddress(hlib,'mono_threads_get_default_stacksize');
  pointer(mono_threads_request_thread_dump):=GetProcAddress(hlib,'mono_threads_request_thread_dump');
  pointer(mono_thread_is_foreign):=GetProcAddress(hlib,'mono_thread_is_foreign');
  pointer(mono_thread_detach_if_exiting):=GetProcAddress(hlib,'mono_thread_detach_if_exiting');
end;


end.
