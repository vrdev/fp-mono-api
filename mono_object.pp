{$mode objfpc}
unit mono_object;

interface

uses
  mono_publib, mono_metadata, mono_class, mono_error;


type

  MonoBoolean = mono_bool;

  PMonoString = ^MonoString;
  MonoString = record
  end;

  PMonoArray = ^MonoArray;
  MonoArray = record
  end;

  PMonoReflectionMethod = ^MonoReflectionMethod;
  MonoReflectionMethod = record
  end;

  PMonoReflectionAssembly = ^MonoReflectionAssembly;
  MonoReflectionAssembly = record
  end;

  PMonoReflectionModule = ^MonoReflectionModule;
  MonoReflectionModule = record
  end;

  PMonoReflectionField = ^MonoReflectionField;
  MonoReflectionField = record
  end;

  PMonoReflectionProperty = ^MonoReflectionProperty;
  MonoReflectionProperty = record
  end;

  PMonoReflectionEvent = ^MonoReflectionEvent;
  MonoReflectionEvent = record
  end;

  PMonoReflectionType = ^MonoReflectionType;
  MonoReflectionType = record
  end;

  PMonoDelegate = ^MonoDelegate;
  MonoDelegate = record
  end;

  PMonoException = ^MonoException;
  MonoException = record
  end;

  PMonoThreadsSync = ^MonoThreadsSync;
  MonoThreadsSync = record
  end;

  PMonoThread = ^MonoThread;
  MonoThread = record
  end;

  PMonoDynamicAssembly = ^MonoDynamicAssembly;
  MonoDynamicAssembly = record
  end;

  PMonoDynamicImage = ^MonoDynamicImage;
  MonoDynamicImage = record
  end;

  PMonoReflectionMethodBody = ^MonoReflectionMethodBody;
  MonoReflectionMethodBody = record
  end;

  PMonoAppContext = ^MonoAppContext;
  MonoAppContext = record
  end;

  PMonoReferenceQueue = ^MonoReferenceQueue;
  MonoReferenceQueue = record
  end;

  PPMonoObject = ^PMonoObject;
  PMonoObject = ^MonoObject;
  MonoObject = record
    vtable : PMonoVTable;
    synchronisation : PMonoThreadsSync;
  end;


  PMonoInvokeFunc = ^MonoInvokeFunc;
  MonoInvokeFunc = function (method:PMonoMethod; obj:pointer; params:Ppointer; exc:PPMonoObject; error:PMonoError):PMonoObject;cdecl;

  PMonoCompileFunc = ^MonoCompileFunc;
  MonoCompileFunc = function (method:PMonoMethod):pointer;cdecl;

  MonoMainThreadFunc = procedure (user_data:pointer);cdecl;

var
  mono_string_chars : function(s:PMonoString):Pmono_unichar2;cdecl;
  mono_string_length : function(s:PMonoString):longint;cdecl;
  mono_object_new : function(domain:PMonoDomain; klass:PMonoClass):PMonoObject;cdecl;
  mono_object_new_specific : function(vtable:PMonoVTable):PMonoObject;cdecl;
  { can be used for classes without finalizer in non-profiling mode  }
  mono_object_new_fast : function(vtable:PMonoVTable):PMonoObject;cdecl;
  mono_object_new_alloc_specific : function(vtable:PMonoVTable):PMonoObject;cdecl;
  mono_object_new_from_token : function(domain:PMonoDomain; image:PMonoImage; token:uint32_t):PMonoObject;cdecl;
  mono_array_new : function(domain:PMonoDomain; eclass:PMonoClass; n:uintptr_t):PMonoArray;cdecl;
  mono_array_new_full : function(domain:PMonoDomain; array_class:PMonoClass; lengths:Puintptr_t; lower_bounds:Pintptr_t):PMonoArray;cdecl;
  mono_array_new_specific : function(vtable:PMonoVTable; n:uintptr_t):PMonoArray;cdecl;
  mono_array_clone : function(parray:PMonoArray):PMonoArray;cdecl;
  mono_array_addr_with_size : function(parray:PMonoArray; size:longint; idx:uintptr_t):Pchar;cdecl;
  mono_array_length : function(parray:PMonoArray):uintptr_t;cdecl;
  mono_string_new_utf16 : function(domain:PMonoDomain; text:Pmono_unichar2; len:int32_t):PMonoString;cdecl;
  mono_string_new_size : function(domain:PMonoDomain; len:int32_t):PMonoString;cdecl;
  mono_ldstr : function(domain:PMonoDomain; image:PMonoImage; str_index:uint32_t):PMonoString;cdecl;
  mono_string_is_interned : function(str:PMonoString):PMonoString;cdecl;
  mono_string_intern : function(str:PMonoString):PMonoString;cdecl;
  mono_string_new : function(domain:PMonoDomain; text:Pchar):PMonoString;cdecl;
  mono_string_new_wrapper : function(text:Pchar):PMonoString;cdecl;
  mono_string_new_len : function(domain:PMonoDomain; text:Pchar; length:dword):PMonoString;cdecl;
  mono_string_new_utf32 : function(domain:PMonoDomain; text:Pmono_unichar4; len:int32_t):PMonoString;cdecl;
  mono_string_to_utf8 : function(string_obj:PMonoString):Pchar;cdecl;
  mono_string_to_utf8_checked : function(string_obj:PMonoString; error:PMonoError):Pchar;cdecl;
  mono_string_to_utf16 : function(string_obj:PMonoString):Pmono_unichar2;cdecl;
  mono_string_to_utf32 : function(string_obj:PMonoString):Pmono_unichar4;cdecl;
  mono_string_from_utf16 : function(data:Pmono_unichar2):PMonoString;cdecl;
  mono_string_from_utf32 : function(data:Pmono_unichar4):PMonoString;cdecl;
  mono_string_equal : function(s1:PMonoString; s2:PMonoString):mono_bool;cdecl;
  mono_string_hash : function(s:PMonoString):dword;cdecl;
  mono_object_hash : function(obj:PMonoObject):longint;cdecl;
  mono_object_to_string : function(obj:PMonoObject; exc:PPMonoObject):PMonoString;cdecl;
  mono_value_box : function(domain:PMonoDomain; klass:PMonoClass; val:pointer):PMonoObject;cdecl;
  mono_value_copy : procedure(dest:pointer; src:pointer; klass:PMonoClass);cdecl;
  mono_value_copy_array : procedure(dest:PMonoArray; dest_idx:longint; src:pointer; count:longint);cdecl;
  mono_object_get_domain : function(obj:PMonoObject):PMonoDomain;cdecl;
  mono_object_get_class : function(obj:PMonoObject):PMonoClass;cdecl;
  mono_object_unbox : function(obj:PMonoObject):pointer;cdecl;
  mono_object_clone : function(obj:PMonoObject):PMonoObject;cdecl;
  mono_object_isinst : function(obj:PMonoObject; klass:PMonoClass):PMonoObject;cdecl;
  mono_object_isinst_mbyref : function(obj:PMonoObject; klass:PMonoClass):PMonoObject;cdecl;
  mono_object_castclass_mbyref : function(obj:PMonoObject; klass:PMonoClass):PMonoObject;cdecl;
  mono_monitor_try_enter : function(obj:PMonoObject; ms:uint32_t):mono_bool;cdecl;
  mono_monitor_enter : function(obj:PMonoObject):mono_bool;cdecl;
  mono_monitor_enter_v4 : procedure(obj:PMonoObject; lock_taken:Pchar);cdecl;
  mono_object_get_size : function(o:PMonoObject):dword;cdecl;
  mono_monitor_exit : procedure(obj:PMonoObject);cdecl;
  mono_raise_exception : procedure(ex:PMonoException);cdecl;
  mono_runtime_object_init : procedure(this_obj:PMonoObject);cdecl;
  mono_runtime_class_init : procedure(vtable:PMonoVTable);cdecl;
  mono_object_get_virtual_method : function(obj:PMonoObject; method:PMonoMethod):PMonoMethod;cdecl;
  mono_runtime_invoke : function(method:PMonoMethod; obj:pointer; params:Ppointer; exc:PPMonoObject):PMonoObject;cdecl;
  mono_get_delegate_invoke : function(klass:PMonoClass):PMonoMethod;cdecl;
  mono_get_delegate_begin_invoke : function(klass:PMonoClass):PMonoMethod;cdecl;
  mono_get_delegate_end_invoke : function(klass:PMonoClass):PMonoMethod;cdecl;
  mono_runtime_delegate_invoke : function(delegate:PMonoObject; params:Ppointer; exc:PPMonoObject):PMonoObject;cdecl;
  mono_runtime_invoke_array : function(method:PMonoMethod; obj:pointer; params:PMonoArray; exc:PPMonoObject):PMonoObject;cdecl;
  mono_method_get_unmanaged_thunk : function(method:PMonoMethod):pointer;cdecl;
  mono_runtime_get_main_args : function:PMonoArray;cdecl;
  mono_runtime_exec_managed_code : procedure(domain:PMonoDomain; main_func:MonoMainThreadFunc; main_args:pointer);cdecl;
  mono_runtime_run_main : function(method:PMonoMethod; argc:longint; argv:PPchar; exc:PPMonoObject):longint;cdecl;
  mono_runtime_exec_main : function(method:PMonoMethod; args:PMonoArray; exc:PPMonoObject):longint;cdecl;
  mono_runtime_set_main_args : function(argc:longint; argv:PPchar):longint;cdecl;
  { The following functions won't be available with mono was configured with remoting disabled.  }
  mono_load_remote_field : function(this_obj:PMonoObject; klass:PMonoClass; field:PMonoClassField; res:Ppointer):pointer;cdecl;
  mono_load_remote_field_new : function(this_obj:PMonoObject; klass:PMonoClass; field:PMonoClassField):PMonoObject;cdecl;
  mono_store_remote_field : procedure(this_obj:PMonoObject; klass:PMonoClass; field:PMonoClassField; val:pointer);cdecl;
  mono_store_remote_field_new : procedure(this_obj:PMonoObject; klass:PMonoClass; field:PMonoClassField; arg:PMonoObject);cdecl;
  mono_unhandled_exception : procedure(exc:PMonoObject);cdecl;
  mono_print_unhandled_exception : procedure(exc:PMonoObject);cdecl;
  mono_compile_method : function(method:PMonoMethod):pointer;cdecl;
  { accessors for fields and properties  }
  mono_field_set_value : procedure(obj:PMonoObject; field:PMonoClassField; value:pointer);cdecl;
  mono_field_static_set_value : procedure(vt:PMonoVTable; field:PMonoClassField; value:pointer);cdecl;
  mono_field_get_value : procedure(obj:PMonoObject; field:PMonoClassField; value:pointer);cdecl;
  mono_field_static_get_value : procedure(vt:PMonoVTable; field:PMonoClassField; value:pointer);cdecl;
  mono_field_get_value_object : function(domain:PMonoDomain; field:PMonoClassField; obj:PMonoObject):PMonoObject;cdecl;
  mono_property_set_value : procedure(prop:PMonoProperty; obj:pointer; params:Ppointer; exc:PPMonoObject);cdecl;
  mono_property_get_value : function(prop:PMonoProperty; obj:pointer; params:Ppointer; exc:PPMonoObject):PMonoObject;cdecl;
  { GC handles support
  *
  * A handle can be created to refer to a managed object and either prevent it
  * from being garbage collected or moved or to be able to know if it has been
  * collected or not (weak references).
  * mono_gchandle_new () is used to prevent an object from being garbage collected
  * until mono_gchandle_free() is called. Use a TRUE value for the pinned argument to
  * prevent the object from being moved (this should be avoided as much as possible
  * and this should be used only for shorts periods of time or performance will suffer).
  * To create a weakref use mono_gchandle_new_weakref (): track_resurrection should
  * usually be false (see the GC docs for more details).
  * mono_gchandle_get_target () can be used to get the object referenced by both kinds
  * of handle: for a weakref handle, if an object has been collected, it will return NULL.
  }
  mono_gchandle_new : function(obj:PMonoObject; pinned:mono_bool):uint32_t;cdecl;
  mono_gchandle_new_weakref : function(obj:PMonoObject; track_resurrection:mono_bool):uint32_t;cdecl;
  mono_gchandle_get_target : function(gchandle:uint32_t):PMonoObject;cdecl;
  mono_gchandle_free : procedure(gchandle:uint32_t);cdecl;
  { Reference queue support
  *
  * A reference queue is used to get notifications of when objects are collected.
  * Call mono_gc_reference_queue_new to create a new queue and pass the callback that
  * will be invoked when registered objects are collected.
  * Call mono_gc_reference_queue_add to register a pair of objects and data within a queue.
  * The callback will be triggered once an object is both unreachable and finalized.
  }

type

  mono_reference_queue_callback = procedure (user_data:pointer);cdecl;

var
  mono_gc_reference_queue_new : function(callback:mono_reference_queue_callback):PMonoReferenceQueue;cdecl;
  mono_gc_reference_queue_free : procedure(queue:PMonoReferenceQueue);cdecl;
  mono_gc_reference_queue_add : function(queue:PMonoReferenceQueue; obj:PMonoObject; user_data:pointer):mono_bool;cdecl;
  { GC write barriers support  }
  mono_gc_wbarrier_set_field : procedure(obj:PMonoObject; field_ptr:pointer; value:PMonoObject);cdecl;
  mono_gc_wbarrier_set_arrayref : procedure(arr:PMonoArray; slot_ptr:pointer; value:PMonoObject);cdecl;
  mono_gc_wbarrier_arrayref_copy : procedure(dest_ptr:pointer; src_ptr:pointer; count:longint);cdecl;
  mono_gc_wbarrier_generic_store : procedure(ptr:pointer; value:PMonoObject);cdecl;
  mono_gc_wbarrier_generic_store_atomic : procedure(ptr:pointer; value:PMonoObject);cdecl;
  mono_gc_wbarrier_generic_nostore : procedure(ptr:pointer);cdecl;
  mono_gc_wbarrier_value_copy : procedure(dest:pointer; src:pointer; count:longint; klass:PMonoClass);cdecl;
  mono_gc_wbarrier_object_copy : procedure(obj:PMonoObject; src:PMonoObject);cdecl;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation

procedure free_procs;
begin
  mono_string_chars:=nil;
  mono_string_length:=nil;
  mono_object_new:=nil;
  mono_object_new_specific:=nil;
  mono_object_new_fast:=nil;
  mono_object_new_alloc_specific:=nil;
  mono_object_new_from_token:=nil;
  mono_array_new:=nil;
  mono_array_new_full:=nil;
  mono_array_new_specific:=nil;
  mono_array_clone:=nil;
  mono_array_addr_with_size:=nil;
  mono_array_length:=nil;
  mono_string_new_utf16:=nil;
  mono_string_new_size:=nil;
  mono_ldstr:=nil;
  mono_string_is_interned:=nil;
  mono_string_intern:=nil;
  mono_string_new:=nil;
  mono_string_new_wrapper:=nil;
  mono_string_new_len:=nil;
  mono_string_new_utf32:=nil;
  mono_string_to_utf8:=nil;
  mono_string_to_utf8_checked:=nil;
  mono_string_to_utf16:=nil;
  mono_string_to_utf32:=nil;
  mono_string_from_utf16:=nil;
  mono_string_from_utf32:=nil;
  mono_string_equal:=nil;
  mono_string_hash:=nil;
  mono_object_hash:=nil;
  mono_object_to_string:=nil;
  mono_value_box:=nil;
  mono_value_copy:=nil;
  mono_value_copy_array:=nil;
  mono_object_get_domain:=nil;
  mono_object_get_class:=nil;
  mono_object_unbox:=nil;
  mono_object_clone:=nil;
  mono_object_isinst:=nil;
  mono_object_isinst_mbyref:=nil;
  mono_object_castclass_mbyref:=nil;
  mono_monitor_try_enter:=nil;
  mono_monitor_enter:=nil;
  mono_monitor_enter_v4:=nil;
  mono_object_get_size:=nil;
  mono_monitor_exit:=nil;
  mono_raise_exception:=nil;
  mono_runtime_object_init:=nil;
  mono_runtime_class_init:=nil;
  mono_object_get_virtual_method:=nil;
  mono_runtime_invoke:=nil;
  mono_get_delegate_invoke:=nil;
  mono_get_delegate_begin_invoke:=nil;
  mono_get_delegate_end_invoke:=nil;
  mono_runtime_delegate_invoke:=nil;
  mono_runtime_invoke_array:=nil;
  mono_method_get_unmanaged_thunk:=nil;
  mono_runtime_get_main_args:=nil;
  mono_runtime_exec_managed_code:=nil;
  mono_runtime_run_main:=nil;
  mono_runtime_exec_main:=nil;
  mono_runtime_set_main_args:=nil;
  mono_load_remote_field:=nil;
  mono_load_remote_field_new:=nil;
  mono_store_remote_field:=nil;
  mono_store_remote_field_new:=nil;
  mono_unhandled_exception:=nil;
  mono_print_unhandled_exception:=nil;
  mono_compile_method:=nil;
  mono_field_set_value:=nil;
  mono_field_static_set_value:=nil;
  mono_field_get_value:=nil;
  mono_field_static_get_value:=nil;
  mono_field_get_value_object:=nil;
  mono_property_set_value:=nil;
  mono_property_get_value:=nil;
  mono_gchandle_new:=nil;
  mono_gchandle_new_weakref:=nil;
  mono_gchandle_get_target:=nil;
  mono_gchandle_free:=nil;
  mono_gc_reference_queue_new:=nil;
  mono_gc_reference_queue_free:=nil;
  mono_gc_reference_queue_add:=nil;
  mono_gc_wbarrier_set_field:=nil;
  mono_gc_wbarrier_set_arrayref:=nil;
  mono_gc_wbarrier_arrayref_copy:=nil;
  mono_gc_wbarrier_generic_store:=nil;
  mono_gc_wbarrier_generic_store_atomic:=nil;
  mono_gc_wbarrier_generic_nostore:=nil;
  mono_gc_wbarrier_value_copy:=nil;
  mono_gc_wbarrier_object_copy:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_string_chars):=GetProcAddress(hlib,'mono_string_chars');
  pointer(mono_string_length):=GetProcAddress(hlib,'mono_string_length');
  pointer(mono_object_new):=GetProcAddress(hlib,'mono_object_new');
  pointer(mono_object_new_specific):=GetProcAddress(hlib,'mono_object_new_specific');
  pointer(mono_object_new_fast):=GetProcAddress(hlib,'mono_object_new_fast');
  pointer(mono_object_new_alloc_specific):=GetProcAddress(hlib,'mono_object_new_alloc_specific');
  pointer(mono_object_new_from_token):=GetProcAddress(hlib,'mono_object_new_from_token');
  pointer(mono_array_new):=GetProcAddress(hlib,'mono_array_new');
  pointer(mono_array_new_full):=GetProcAddress(hlib,'mono_array_new_full');
  pointer(mono_array_new_specific):=GetProcAddress(hlib,'mono_array_new_specific');
  pointer(mono_array_clone):=GetProcAddress(hlib,'mono_array_clone');
  pointer(mono_array_addr_with_size):=GetProcAddress(hlib,'mono_array_addr_with_size');
  pointer(mono_array_length):=GetProcAddress(hlib,'mono_array_length');
  pointer(mono_string_new_utf16):=GetProcAddress(hlib,'mono_string_new_utf16');
  pointer(mono_string_new_size):=GetProcAddress(hlib,'mono_string_new_size');
  pointer(mono_ldstr):=GetProcAddress(hlib,'mono_ldstr');
  pointer(mono_string_is_interned):=GetProcAddress(hlib,'mono_string_is_interned');
  pointer(mono_string_intern):=GetProcAddress(hlib,'mono_string_intern');
  pointer(mono_string_new):=GetProcAddress(hlib,'mono_string_new');
  pointer(mono_string_new_wrapper):=GetProcAddress(hlib,'mono_string_new_wrapper');
  pointer(mono_string_new_len):=GetProcAddress(hlib,'mono_string_new_len');
  pointer(mono_string_new_utf32):=GetProcAddress(hlib,'mono_string_new_utf32');
  pointer(mono_string_to_utf8):=GetProcAddress(hlib,'mono_string_to_utf8');
  pointer(mono_string_to_utf8_checked):=GetProcAddress(hlib,'mono_string_to_utf8_checked');
  pointer(mono_string_to_utf16):=GetProcAddress(hlib,'mono_string_to_utf16');
  pointer(mono_string_to_utf32):=GetProcAddress(hlib,'mono_string_to_utf32');
  pointer(mono_string_from_utf16):=GetProcAddress(hlib,'mono_string_from_utf16');
  pointer(mono_string_from_utf32):=GetProcAddress(hlib,'mono_string_from_utf32');
  pointer(mono_string_equal):=GetProcAddress(hlib,'mono_string_equal');
  pointer(mono_string_hash):=GetProcAddress(hlib,'mono_string_hash');
  pointer(mono_object_hash):=GetProcAddress(hlib,'mono_object_hash');
  pointer(mono_object_to_string):=GetProcAddress(hlib,'mono_object_to_string');
  pointer(mono_value_box):=GetProcAddress(hlib,'mono_value_box');
  pointer(mono_value_copy):=GetProcAddress(hlib,'mono_value_copy');
  pointer(mono_value_copy_array):=GetProcAddress(hlib,'mono_value_copy_array');
  pointer(mono_object_get_domain):=GetProcAddress(hlib,'mono_object_get_domain');
  pointer(mono_object_get_class):=GetProcAddress(hlib,'mono_object_get_class');
  pointer(mono_object_unbox):=GetProcAddress(hlib,'mono_object_unbox');
  pointer(mono_object_clone):=GetProcAddress(hlib,'mono_object_clone');
  pointer(mono_object_isinst):=GetProcAddress(hlib,'mono_object_isinst');
  pointer(mono_object_isinst_mbyref):=GetProcAddress(hlib,'mono_object_isinst_mbyref');
  pointer(mono_object_castclass_mbyref):=GetProcAddress(hlib,'mono_object_castclass_mbyref');
  pointer(mono_monitor_try_enter):=GetProcAddress(hlib,'mono_monitor_try_enter');
  pointer(mono_monitor_enter):=GetProcAddress(hlib,'mono_monitor_enter');
  pointer(mono_monitor_enter_v4):=GetProcAddress(hlib,'mono_monitor_enter_v4');
  pointer(mono_object_get_size):=GetProcAddress(hlib,'mono_object_get_size');
  pointer(mono_monitor_exit):=GetProcAddress(hlib,'mono_monitor_exit');
  pointer(mono_raise_exception):=GetProcAddress(hlib,'mono_raise_exception');
  pointer(mono_runtime_object_init):=GetProcAddress(hlib,'mono_runtime_object_init');
  pointer(mono_runtime_class_init):=GetProcAddress(hlib,'mono_runtime_class_init');
  pointer(mono_object_get_virtual_method):=GetProcAddress(hlib,'mono_object_get_virtual_method');
  pointer(mono_runtime_invoke):=GetProcAddress(hlib,'mono_runtime_invoke');
  pointer(mono_get_delegate_invoke):=GetProcAddress(hlib,'mono_get_delegate_invoke');
  pointer(mono_get_delegate_begin_invoke):=GetProcAddress(hlib,'mono_get_delegate_begin_invoke');
  pointer(mono_get_delegate_end_invoke):=GetProcAddress(hlib,'mono_get_delegate_end_invoke');
  pointer(mono_runtime_delegate_invoke):=GetProcAddress(hlib,'mono_runtime_delegate_invoke');
  pointer(mono_runtime_invoke_array):=GetProcAddress(hlib,'mono_runtime_invoke_array');
  pointer(mono_method_get_unmanaged_thunk):=GetProcAddress(hlib,'mono_method_get_unmanaged_thunk');
  pointer(mono_runtime_get_main_args):=GetProcAddress(hlib,'mono_runtime_get_main_args');
  pointer(mono_runtime_exec_managed_code):=GetProcAddress(hlib,'mono_runtime_exec_managed_code');
  pointer(mono_runtime_run_main):=GetProcAddress(hlib,'mono_runtime_run_main');
  pointer(mono_runtime_exec_main):=GetProcAddress(hlib,'mono_runtime_exec_main');
  pointer(mono_runtime_set_main_args):=GetProcAddress(hlib,'mono_runtime_set_main_args');
  pointer(mono_load_remote_field):=GetProcAddress(hlib,'mono_load_remote_field');
  pointer(mono_load_remote_field_new):=GetProcAddress(hlib,'mono_load_remote_field_new');
  pointer(mono_store_remote_field):=GetProcAddress(hlib,'mono_store_remote_field');
  pointer(mono_store_remote_field_new):=GetProcAddress(hlib,'mono_store_remote_field_new');
  pointer(mono_unhandled_exception):=GetProcAddress(hlib,'mono_unhandled_exception');
  pointer(mono_print_unhandled_exception):=GetProcAddress(hlib,'mono_print_unhandled_exception');
  pointer(mono_compile_method):=GetProcAddress(hlib,'mono_compile_method');
  pointer(mono_field_set_value):=GetProcAddress(hlib,'mono_field_set_value');
  pointer(mono_field_static_set_value):=GetProcAddress(hlib,'mono_field_static_set_value');
  pointer(mono_field_get_value):=GetProcAddress(hlib,'mono_field_get_value');
  pointer(mono_field_static_get_value):=GetProcAddress(hlib,'mono_field_static_get_value');
  pointer(mono_field_get_value_object):=GetProcAddress(hlib,'mono_field_get_value_object');
  pointer(mono_property_set_value):=GetProcAddress(hlib,'mono_property_set_value');
  pointer(mono_property_get_value):=GetProcAddress(hlib,'mono_property_get_value');
  pointer(mono_gchandle_new):=GetProcAddress(hlib,'mono_gchandle_new');
  pointer(mono_gchandle_new_weakref):=GetProcAddress(hlib,'mono_gchandle_new_weakref');
  pointer(mono_gchandle_get_target):=GetProcAddress(hlib,'mono_gchandle_get_target');
  pointer(mono_gchandle_free):=GetProcAddress(hlib,'mono_gchandle_free');
  pointer(mono_gc_reference_queue_new):=GetProcAddress(hlib,'mono_gc_reference_queue_new');
  pointer(mono_gc_reference_queue_free):=GetProcAddress(hlib,'mono_gc_reference_queue_free');
  pointer(mono_gc_reference_queue_add):=GetProcAddress(hlib,'mono_gc_reference_queue_add');
  pointer(mono_gc_wbarrier_set_field):=GetProcAddress(hlib,'mono_gc_wbarrier_set_field');
  pointer(mono_gc_wbarrier_set_arrayref):=GetProcAddress(hlib,'mono_gc_wbarrier_set_arrayref');
  pointer(mono_gc_wbarrier_arrayref_copy):=GetProcAddress(hlib,'mono_gc_wbarrier_arrayref_copy');
  pointer(mono_gc_wbarrier_generic_store):=GetProcAddress(hlib,'mono_gc_wbarrier_generic_store');
  pointer(mono_gc_wbarrier_generic_store_atomic):=GetProcAddress(hlib,'mono_gc_wbarrier_generic_store_atomic');
  pointer(mono_gc_wbarrier_generic_nostore):=GetProcAddress(hlib,'mono_gc_wbarrier_generic_nostore');
  pointer(mono_gc_wbarrier_value_copy):=GetProcAddress(hlib,'mono_gc_wbarrier_value_copy');
  pointer(mono_gc_wbarrier_object_copy):=GetProcAddress(hlib,'mono_gc_wbarrier_object_copy');
end;

end.
