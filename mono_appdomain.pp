{*
* appdomain.h: AppDomain functions
*
* Author:
* Dietmar Maurer (dietmar@ximian.com)
*
* (C) 2001 Ximian, Inc.
*}

{$mode objfpc}
unit mono_appdomain;

interface

uses
  mono_publib, mono_image, mono_metadata, mono_object;

type


  PMonoAppDomain = ^MonoAppDomain;
  MonoAppDomain = record
  end;

  PMonoJitInfo = ^MonoJitInfo;
  MonoJitInfo = record
  end;

  MonoThreadStartCB = procedure (tid:intptr_t; stack_start:pointer; func:pointer);cdecl;
  MonoThreadAttachCB = procedure (tid:intptr_t; stack_start:pointer);cdecl;
  MonoDomainFunc = procedure (domain:PMonoDomain; user_data:pointer);cdecl;
 
var
  mono_init : function(filename:Pchar):PMonoDomain;
  mono_init_from_assembly : function(domain_name:Pchar; filename:Pchar):PMonoDomain;
  mono_init_version : function(domain_name:Pchar; version:Pchar):PMonoDomain;
  mono_get_root_domain : function:PMonoDomain;
  mono_runtime_init : procedure(domain:PMonoDomain; start_cb:MonoThreadStartCB; attach_cb:MonoThreadAttachCB);
  mono_runtime_cleanup : procedure(domain:PMonoDomain);
  mono_install_runtime_cleanup : procedure(func:MonoDomainFunc);
  mono_runtime_quit : procedure;
  mono_runtime_set_shutting_down : procedure;
  mono_runtime_is_shutting_down : function:mono_bool;
  mono_check_corlib_version : function:Pchar;
  mono_domain_create : function:PMonoDomain;
  mono_domain_create_appdomain : function(friendly_name:Pchar; configuration_file:Pchar):PMonoDomain;
  mono_domain_set_config : procedure(domain:PMonoDomain; base_dir:Pchar; config_file_name:Pchar);
  mono_domain_get : function:PMonoDomain;
  mono_domain_get_by_id : function(domainid:int32_t):PMonoDomain;
  mono_domain_get_id : function(domain:PMonoDomain):int32_t;
  mono_domain_get_friendly_name : function(domain:PMonoDomain):Pchar;
  mono_domain_set : function(domain:PMonoDomain; force:mono_bool):mono_bool;
  mono_domain_set_internal : procedure(domain:PMonoDomain);
  mono_domain_unload : procedure(domain:PMonoDomain);
  mono_domain_try_unload : procedure(domain:PMonoDomain; exc:PPMonoObject);
  mono_domain_is_unloading : function(domain:PMonoDomain):mono_bool;
  mono_domain_from_appdomain : function(appdomain:PMonoAppDomain):PMonoDomain;
  mono_domain_foreach : procedure(func:MonoDomainFunc; user_data:pointer);
  mono_domain_assembly_open : function(domain:PMonoDomain; name:Pchar):PMonoAssembly;
  mono_domain_finalize : function(domain:PMonoDomain; timeout:uint32_t):mono_bool;
  mono_domain_free : procedure(domain:PMonoDomain; force:mono_bool);
  mono_domain_has_type_resolve : function(domain:PMonoDomain):mono_bool;
  mono_domain_try_type_resolve : function(domain:PMonoDomain; name:Pchar; tb:PMonoObject):PMonoReflectionAssembly;
  mono_domain_owns_vtable_slot : function(domain:PMonoDomain; vtable_slot:pointer):mono_bool;
  mono_context_init : procedure(domain:PMonoDomain);
  mono_context_set : procedure(new_context:PMonoAppContext);
  mono_context_get : function:PMonoAppContext;
  mono_context_get_id : function(context:PMonoAppContext):int32_t;
  mono_context_get_domain_id : function(context:PMonoAppContext):int32_t;
  mono_jit_info_table_find : function(domain:PMonoDomain; addr:Pchar):PMonoJitInfo;
  { MonoJitInfo accessors  }
  mono_jit_info_get_code_start : function(ji:PMonoJitInfo):pointer;
  mono_jit_info_get_code_size : function(ji:PMonoJitInfo):longint;
  mono_jit_info_get_method : function(ji:PMonoJitInfo):PMonoMethod;
  mono_get_corlib : function:PMonoImage;
  mono_get_object_class : function:PMonoClass;
  mono_get_byte_class : function:PMonoClass;
  mono_get_void_class : function:PMonoClass;
  mono_get_boolean_class : function:PMonoClass;
  mono_get_sbyte_class : function:PMonoClass;
  mono_get_int16_class : function:PMonoClass;
  mono_get_uint16_class : function:PMonoClass;
  mono_get_int32_class : function:PMonoClass;
  mono_get_uint32_class : function:PMonoClass;
  mono_get_intptr_class : function:PMonoClass;
  mono_get_uintptr_class : function:PMonoClass;
  mono_get_int64_class : function:PMonoClass;
  mono_get_uint64_class : function:PMonoClass;
  mono_get_single_class : function:PMonoClass;
  mono_get_double_class : function:PMonoClass;
  mono_get_char_class : function:PMonoClass;
  mono_get_string_class : function:PMonoClass;
  mono_get_enum_class : function:PMonoClass;
  mono_get_array_class : function:PMonoClass;
  mono_get_thread_class : function:PMonoClass;
  mono_get_exception_class : function:PMonoClass;
  mono_security_enable_core_clr : procedure;

type
  MonoCoreClrPlatformCB = function (image_name:Pchar):mono_bool;cdecl;
  
var
  mono_security_set_core_clr_platform_callback : procedure(callback:MonoCoreClrPlatformCB);
  

procedure bind_procs(hLib : TLibHandle);
procedure free_procs;

implementation

procedure free_procs;
begin
  mono_init:=nil;
  mono_init_from_assembly:=nil;
  mono_init_version:=nil;
  mono_get_root_domain:=nil;
  mono_runtime_init:=nil;
  mono_runtime_cleanup:=nil;
  mono_install_runtime_cleanup:=nil;
  mono_runtime_quit:=nil;
  mono_runtime_set_shutting_down:=nil;
  mono_runtime_is_shutting_down:=nil;
  mono_check_corlib_version:=nil;
  mono_domain_create:=nil;
  mono_domain_create_appdomain:=nil;
  mono_domain_set_config:=nil;
  mono_domain_get:=nil;
  mono_domain_get_by_id:=nil;
  mono_domain_get_id:=nil;
  mono_domain_get_friendly_name:=nil;
  mono_domain_set:=nil;
  mono_domain_set_internal:=nil;
  mono_domain_unload:=nil;
  mono_domain_try_unload:=nil;
  mono_domain_is_unloading:=nil;
  mono_domain_from_appdomain:=nil;
  mono_domain_foreach:=nil;
  mono_domain_assembly_open:=nil;
  mono_domain_finalize:=nil;
  mono_domain_free:=nil;
  mono_domain_has_type_resolve:=nil;
  mono_domain_try_type_resolve:=nil;
  mono_domain_owns_vtable_slot:=nil;
  mono_context_init:=nil;
  mono_context_set:=nil;
  mono_context_get:=nil;
  mono_context_get_id:=nil;
  mono_context_get_domain_id:=nil;
  mono_jit_info_table_find:=nil;
  mono_jit_info_get_code_start:=nil;
  mono_jit_info_get_code_size:=nil;
  mono_jit_info_get_method:=nil;
  mono_get_corlib:=nil;
  mono_get_object_class:=nil;
  mono_get_byte_class:=nil;
  mono_get_void_class:=nil;
  mono_get_boolean_class:=nil;
  mono_get_sbyte_class:=nil;
  mono_get_int16_class:=nil;
  mono_get_uint16_class:=nil;
  mono_get_int32_class:=nil;
  mono_get_uint32_class:=nil;
  mono_get_intptr_class:=nil;
  mono_get_uintptr_class:=nil;
  mono_get_int64_class:=nil;
  mono_get_uint64_class:=nil;
  mono_get_single_class:=nil;
  mono_get_double_class:=nil;
  mono_get_char_class:=nil;
  mono_get_string_class:=nil;
  mono_get_enum_class:=nil;
  mono_get_array_class:=nil;
  mono_get_thread_class:=nil;
  mono_get_exception_class:=nil;
  mono_security_enable_core_clr:=nil;
  mono_security_set_core_clr_platform_callback:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_init):=GetProcAddress(hlib,'mono_init');
  pointer(mono_init_from_assembly):=GetProcAddress(hlib,'mono_init_from_assembly');
  pointer(mono_init_version):=GetProcAddress(hlib,'mono_init_version');
  pointer(mono_get_root_domain):=GetProcAddress(hlib,'mono_get_root_domain');
  pointer(mono_runtime_init):=GetProcAddress(hlib,'mono_runtime_init');
  pointer(mono_runtime_cleanup):=GetProcAddress(hlib,'mono_runtime_cleanup');
  pointer(mono_install_runtime_cleanup):=GetProcAddress(hlib,'mono_install_runtime_cleanup');
  pointer(mono_runtime_quit):=GetProcAddress(hlib,'mono_runtime_quit');
  pointer(mono_runtime_set_shutting_down):=GetProcAddress(hlib,'mono_runtime_set_shutting_down');
  pointer(mono_runtime_is_shutting_down):=GetProcAddress(hlib,'mono_runtime_is_shutting_down');
  pointer(mono_check_corlib_version):=GetProcAddress(hlib,'mono_check_corlib_version');
  pointer(mono_domain_create):=GetProcAddress(hlib,'mono_domain_create');
  pointer(mono_domain_create_appdomain):=GetProcAddress(hlib,'mono_domain_create_appdomain');
  pointer(mono_domain_set_config):=GetProcAddress(hlib,'mono_domain_set_config');
  pointer(mono_domain_get):=GetProcAddress(hlib,'mono_domain_get');
  pointer(mono_domain_get_by_id):=GetProcAddress(hlib,'mono_domain_get_by_id');
  pointer(mono_domain_get_id):=GetProcAddress(hlib,'mono_domain_get_id');
  pointer(mono_domain_get_friendly_name):=GetProcAddress(hlib,'mono_domain_get_friendly_name');
  pointer(mono_domain_set):=GetProcAddress(hlib,'mono_domain_set');
  pointer(mono_domain_set_internal):=GetProcAddress(hlib,'mono_domain_set_internal');
  pointer(mono_domain_unload):=GetProcAddress(hlib,'mono_domain_unload');
  pointer(mono_domain_try_unload):=GetProcAddress(hlib,'mono_domain_try_unload');
  pointer(mono_domain_is_unloading):=GetProcAddress(hlib,'mono_domain_is_unloading');
  pointer(mono_domain_from_appdomain):=GetProcAddress(hlib,'mono_domain_from_appdomain');
  pointer(mono_domain_foreach):=GetProcAddress(hlib,'mono_domain_foreach');
  pointer(mono_domain_assembly_open):=GetProcAddress(hlib,'mono_domain_assembly_open');
  pointer(mono_domain_finalize):=GetProcAddress(hlib,'mono_domain_finalize');
  pointer(mono_domain_free):=GetProcAddress(hlib,'mono_domain_free');
  pointer(mono_domain_has_type_resolve):=GetProcAddress(hlib,'mono_domain_has_type_resolve');
  pointer(mono_domain_try_type_resolve):=GetProcAddress(hlib,'mono_domain_try_type_resolve');
  pointer(mono_domain_owns_vtable_slot):=GetProcAddress(hlib,'mono_domain_owns_vtable_slot');
  pointer(mono_context_init):=GetProcAddress(hlib,'mono_context_init');
  pointer(mono_context_set):=GetProcAddress(hlib,'mono_context_set');
  pointer(mono_context_get):=GetProcAddress(hlib,'mono_context_get');
  pointer(mono_context_get_id):=GetProcAddress(hlib,'mono_context_get_id');
  pointer(mono_context_get_domain_id):=GetProcAddress(hlib,'mono_context_get_domain_id');
  pointer(mono_jit_info_table_find):=GetProcAddress(hlib,'mono_jit_info_table_find');
  pointer(mono_jit_info_get_code_start):=GetProcAddress(hlib,'mono_jit_info_get_code_start');
  pointer(mono_jit_info_get_code_size):=GetProcAddress(hlib,'mono_jit_info_get_code_size');
  pointer(mono_jit_info_get_method):=GetProcAddress(hlib,'mono_jit_info_get_method');
  pointer(mono_get_corlib):=GetProcAddress(hlib,'mono_get_corlib');
  pointer(mono_get_object_class):=GetProcAddress(hlib,'mono_get_object_class');
  pointer(mono_get_byte_class):=GetProcAddress(hlib,'mono_get_byte_class');
  pointer(mono_get_void_class):=GetProcAddress(hlib,'mono_get_void_class');
  pointer(mono_get_boolean_class):=GetProcAddress(hlib,'mono_get_boolean_class');
  pointer(mono_get_sbyte_class):=GetProcAddress(hlib,'mono_get_sbyte_class');
  pointer(mono_get_int16_class):=GetProcAddress(hlib,'mono_get_int16_class');
  pointer(mono_get_uint16_class):=GetProcAddress(hlib,'mono_get_uint16_class');
  pointer(mono_get_int32_class):=GetProcAddress(hlib,'mono_get_int32_class');
  pointer(mono_get_uint32_class):=GetProcAddress(hlib,'mono_get_uint32_class');
  pointer(mono_get_intptr_class):=GetProcAddress(hlib,'mono_get_intptr_class');
  pointer(mono_get_uintptr_class):=GetProcAddress(hlib,'mono_get_uintptr_class');
  pointer(mono_get_int64_class):=GetProcAddress(hlib,'mono_get_int64_class');
  pointer(mono_get_uint64_class):=GetProcAddress(hlib,'mono_get_uint64_class');
  pointer(mono_get_single_class):=GetProcAddress(hlib,'mono_get_single_class');
  pointer(mono_get_double_class):=GetProcAddress(hlib,'mono_get_double_class');
  pointer(mono_get_char_class):=GetProcAddress(hlib,'mono_get_char_class');
  pointer(mono_get_string_class):=GetProcAddress(hlib,'mono_get_string_class');
  pointer(mono_get_enum_class):=GetProcAddress(hlib,'mono_get_enum_class');
  pointer(mono_get_array_class):=GetProcAddress(hlib,'mono_get_array_class');
  pointer(mono_get_thread_class):=GetProcAddress(hlib,'mono_get_thread_class');
  pointer(mono_get_exception_class):=GetProcAddress(hlib,'mono_get_exception_class');
  pointer(mono_security_enable_core_clr):=GetProcAddress(hlib,'mono_security_enable_core_clr');
  pointer(mono_security_set_core_clr_platform_callback):=GetProcAddress(hlib,'mono_security_set_core_clr_platform_callback');
end;


end.
