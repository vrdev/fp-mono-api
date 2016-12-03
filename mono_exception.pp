{$mode objfpc}
unit mono_exception;


interface
uses
  mono_publib, mono_object, mono_metadata;

var
  mono_exception_from_name : function(image:PMonoImage; name_space:Pchar; name:Pchar):PMonoException;cdecl;
  mono_exception_from_token : function(image:PMonoImage; token:uint32_t):PMonoException;cdecl;
  mono_exception_from_name_two_strings : function(image:PMonoImage; name_space:Pchar; name:Pchar; a1:PMonoString; a2:PMonoString):PMonoException;cdecl;
  mono_exception_from_name_msg : function(image:PMonoImage; name_space:Pchar; name:Pchar; msg:Pchar):PMonoException;cdecl;
  mono_exception_from_token_two_strings : function(image:PMonoImage; token:uint32_t; a1:PMonoString; a2:PMonoString):PMonoException;cdecl;
  mono_exception_from_name_domain : function(domain:PMonoDomain; image:PMonoImage; name_space:Pchar; name:Pchar):PMonoException;cdecl;
  mono_get_exception_divide_by_zero : function:PMonoException;cdecl;
  mono_get_exception_security : function:PMonoException;cdecl;
  mono_get_exception_arithmetic : function:PMonoException;cdecl;
  mono_get_exception_overflow : function:PMonoException;cdecl;
  mono_get_exception_null_reference : function:PMonoException;cdecl;
  mono_get_exception_execution_engine : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_thread_abort : function:PMonoException;cdecl;
  mono_get_exception_thread_state : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_thread_interrupted : function:PMonoException;cdecl;
  mono_get_exception_serialization : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_invalid_cast : function:PMonoException;cdecl;
  mono_get_exception_invalid_operation : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_index_out_of_range : function:PMonoException;cdecl;
  mono_get_exception_array_type_mismatch : function:PMonoException;cdecl;
  mono_get_exception_type_load : function(class_name:PMonoString; assembly_name:Pchar):PMonoException;cdecl;
  mono_get_exception_missing_method : function(class_name:Pchar; member_name:Pchar):PMonoException;cdecl;
  mono_get_exception_missing_field : function(class_name:Pchar; member_name:Pchar):PMonoException;cdecl;
  mono_get_exception_not_implemented : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_not_supported : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_argument_null : function(arg:Pchar):PMonoException;cdecl;
  mono_get_exception_argument : function(arg:Pchar; msg:Pchar):PMonoException;cdecl;
  mono_get_exception_argument_out_of_range : function(arg:Pchar):PMonoException;cdecl;
  mono_get_exception_io : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_file_not_found : function(fname:PMonoString):PMonoException;cdecl;
  mono_get_exception_file_not_found2 : function(msg:Pchar; fname:PMonoString):PMonoException;cdecl;
  mono_get_exception_type_initialization : function(type_name:Pchar; inner:PMonoException):PMonoException;cdecl;
  mono_get_exception_synchronization_lock : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_cannot_unload_appdomain : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_appdomain_unloaded : function:PMonoException;cdecl;
  mono_get_exception_bad_image_format : function(msg:Pchar):PMonoException;cdecl;
  mono_get_exception_bad_image_format2 : function(msg:Pchar; fname:PMonoString):PMonoException;cdecl;
  mono_get_exception_stack_overflow : function:PMonoException;cdecl;
  mono_get_exception_out_of_memory : function:PMonoException;cdecl;
  mono_get_exception_field_access : function:PMonoException;cdecl;
  mono_get_exception_method_access : function:PMonoException;cdecl;
  mono_get_exception_reflection_type_load : function(types:PMonoArray; exceptions:PMonoArray):PMonoException;cdecl;
  mono_get_exception_runtime_wrapped : function(wrapped_exception:PMonoObject):PMonoException;cdecl;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   

implementation

procedure free_procs;
begin
  mono_exception_from_name:=nil;
  mono_exception_from_token:=nil;
  mono_exception_from_name_two_strings:=nil;
  mono_exception_from_name_msg:=nil;
  mono_exception_from_token_two_strings:=nil;
  mono_exception_from_name_domain:=nil;
  mono_get_exception_divide_by_zero:=nil;
  mono_get_exception_security:=nil;
  mono_get_exception_arithmetic:=nil;
  mono_get_exception_overflow:=nil;
  mono_get_exception_null_reference:=nil;
  mono_get_exception_execution_engine:=nil;
  mono_get_exception_thread_abort:=nil;
  mono_get_exception_thread_state:=nil;
  mono_get_exception_thread_interrupted:=nil;
  mono_get_exception_serialization:=nil;
  mono_get_exception_invalid_cast:=nil;
  mono_get_exception_invalid_operation:=nil;
  mono_get_exception_index_out_of_range:=nil;
  mono_get_exception_array_type_mismatch:=nil;
  mono_get_exception_type_load:=nil;
  mono_get_exception_missing_method:=nil;
  mono_get_exception_missing_field:=nil;
  mono_get_exception_not_implemented:=nil;
  mono_get_exception_not_supported:=nil;
  mono_get_exception_argument_null:=nil;
  mono_get_exception_argument:=nil;
  mono_get_exception_argument_out_of_range:=nil;
  mono_get_exception_io:=nil;
  mono_get_exception_file_not_found:=nil;
  mono_get_exception_file_not_found2:=nil;
  mono_get_exception_type_initialization:=nil;
  mono_get_exception_synchronization_lock:=nil;
  mono_get_exception_cannot_unload_appdomain:=nil;
  mono_get_exception_appdomain_unloaded:=nil;
  mono_get_exception_bad_image_format:=nil;
  mono_get_exception_bad_image_format2:=nil;
  mono_get_exception_stack_overflow:=nil;
  mono_get_exception_out_of_memory:=nil;
  mono_get_exception_field_access:=nil;
  mono_get_exception_method_access:=nil;
  mono_get_exception_reflection_type_load:=nil;
  mono_get_exception_runtime_wrapped:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_exception_from_name):=GetProcAddress(hlib,'mono_exception_from_name');
  pointer(mono_exception_from_token):=GetProcAddress(hlib,'mono_exception_from_token');
  pointer(mono_exception_from_name_two_strings):=GetProcAddress(hlib,'mono_exception_from_name_two_strings');
  pointer(mono_exception_from_name_msg):=GetProcAddress(hlib,'mono_exception_from_name_msg');
  pointer(mono_exception_from_token_two_strings):=GetProcAddress(hlib,'mono_exception_from_token_two_strings');
  pointer(mono_exception_from_name_domain):=GetProcAddress(hlib,'mono_exception_from_name_domain');
  pointer(mono_get_exception_divide_by_zero):=GetProcAddress(hlib,'mono_get_exception_divide_by_zero');
  pointer(mono_get_exception_security):=GetProcAddress(hlib,'mono_get_exception_security');
  pointer(mono_get_exception_arithmetic):=GetProcAddress(hlib,'mono_get_exception_arithmetic');
  pointer(mono_get_exception_overflow):=GetProcAddress(hlib,'mono_get_exception_overflow');
  pointer(mono_get_exception_null_reference):=GetProcAddress(hlib,'mono_get_exception_null_reference');
  pointer(mono_get_exception_execution_engine):=GetProcAddress(hlib,'mono_get_exception_execution_engine');
  pointer(mono_get_exception_thread_abort):=GetProcAddress(hlib,'mono_get_exception_thread_abort');
  pointer(mono_get_exception_thread_state):=GetProcAddress(hlib,'mono_get_exception_thread_state');
  pointer(mono_get_exception_thread_interrupted):=GetProcAddress(hlib,'mono_get_exception_thread_interrupted');
  pointer(mono_get_exception_serialization):=GetProcAddress(hlib,'mono_get_exception_serialization');
  pointer(mono_get_exception_invalid_cast):=GetProcAddress(hlib,'mono_get_exception_invalid_cast');
  pointer(mono_get_exception_invalid_operation):=GetProcAddress(hlib,'mono_get_exception_invalid_operation');
  pointer(mono_get_exception_index_out_of_range):=GetProcAddress(hlib,'mono_get_exception_index_out_of_range');
  pointer(mono_get_exception_array_type_mismatch):=GetProcAddress(hlib,'mono_get_exception_array_type_mismatch');
  pointer(mono_get_exception_type_load):=GetProcAddress(hlib,'mono_get_exception_type_load');
  pointer(mono_get_exception_missing_method):=GetProcAddress(hlib,'mono_get_exception_missing_method');
  pointer(mono_get_exception_missing_field):=GetProcAddress(hlib,'mono_get_exception_missing_field');
  pointer(mono_get_exception_not_implemented):=GetProcAddress(hlib,'mono_get_exception_not_implemented');
  pointer(mono_get_exception_not_supported):=GetProcAddress(hlib,'mono_get_exception_not_supported');
  pointer(mono_get_exception_argument_null):=GetProcAddress(hlib,'mono_get_exception_argument_null');
  pointer(mono_get_exception_argument):=GetProcAddress(hlib,'mono_get_exception_argument');
  pointer(mono_get_exception_argument_out_of_range):=GetProcAddress(hlib,'mono_get_exception_argument_out_of_range');
  pointer(mono_get_exception_io):=GetProcAddress(hlib,'mono_get_exception_io');
  pointer(mono_get_exception_file_not_found):=GetProcAddress(hlib,'mono_get_exception_file_not_found');
  pointer(mono_get_exception_file_not_found2):=GetProcAddress(hlib,'mono_get_exception_file_not_found2');
  pointer(mono_get_exception_type_initialization):=GetProcAddress(hlib,'mono_get_exception_type_initialization');
  pointer(mono_get_exception_synchronization_lock):=GetProcAddress(hlib,'mono_get_exception_synchronization_lock');
  pointer(mono_get_exception_cannot_unload_appdomain):=GetProcAddress(hlib,'mono_get_exception_cannot_unload_appdomain');
  pointer(mono_get_exception_appdomain_unloaded):=GetProcAddress(hlib,'mono_get_exception_appdomain_unloaded');
  pointer(mono_get_exception_bad_image_format):=GetProcAddress(hlib,'mono_get_exception_bad_image_format');
  pointer(mono_get_exception_bad_image_format2):=GetProcAddress(hlib,'mono_get_exception_bad_image_format2');
  pointer(mono_get_exception_stack_overflow):=GetProcAddress(hlib,'mono_get_exception_stack_overflow');
  pointer(mono_get_exception_out_of_memory):=GetProcAddress(hlib,'mono_get_exception_out_of_memory');
  pointer(mono_get_exception_field_access):=GetProcAddress(hlib,'mono_get_exception_field_access');
  pointer(mono_get_exception_method_access):=GetProcAddress(hlib,'mono_get_exception_method_access');
  pointer(mono_get_exception_reflection_type_load):=GetProcAddress(hlib,'mono_get_exception_reflection_type_load');
  pointer(mono_get_exception_runtime_wrapped):=GetProcAddress(hlib,'mono_get_exception_runtime_wrapped');
end;


end.
