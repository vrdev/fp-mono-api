{$mode objfpc}
unit mono_loader;
interface

uses
  mono_publib, mono_metadata, mono_image, mono_error;


type
  MonoStackWalk = function (method:PMonoMethod; native_offset:int32_t; il_offset:int32_t; managed:mono_bool; data:pointer):mono_bool;cdecl;

var
  mono_get_method : function(image:PMonoImage; token:uint32_t; klass:PMonoClass):PMonoMethod;cdecl;
  mono_get_method_full : function(image:PMonoImage; token:uint32_t; klass:PMonoClass; context:PMonoGenericContext):PMonoMethod;cdecl;
  mono_get_method_constrained : function(image:PMonoImage; token:uint32_t; constrained_class:PMonoClass; context:PMonoGenericContext; cil_method:PPMonoMethod):PMonoMethod;cdecl;
  mono_free_method : procedure(method:PMonoMethod);cdecl;
  mono_method_get_signature_full : function(method:PMonoMethod; image:PMonoImage; token:uint32_t; context:PMonoGenericContext):PMonoMethodSignature;cdecl;
  mono_method_get_signature : function(method:PMonoMethod; image:PMonoImage; token:uint32_t):PMonoMethodSignature;cdecl;
  mono_method_signature : function(method:PMonoMethod):PMonoMethodSignature;cdecl;
  mono_method_get_header : function(method:PMonoMethod):PMonoMethodHeader;cdecl;
  mono_method_get_name : function(method:PMonoMethod):Pchar;cdecl;
  mono_method_get_class : function(method:PMonoMethod):PMonoClass;cdecl;
  mono_method_get_token : function(method:PMonoMethod):uint32_t;cdecl;
  mono_method_get_flags : function(method:PMonoMethod; iflags:Puint32_t):uint32_t;cdecl;
  mono_method_get_index : function(method:PMonoMethod):uint32_t;cdecl;
  mono_load_image : function(fname:Pchar; status:PMonoImageOpenStatus):PMonoImage;cdecl;
  mono_add_internal_call : procedure(name:Pchar; method:pointer);cdecl;
  mono_lookup_internal_call : function(method:PMonoMethod):pointer;cdecl;
  mono_lookup_icall_symbol : function(m:PMonoMethod):Pchar;cdecl;
  mono_dllmap_insert : procedure(assembly:PMonoImage; dll:Pchar; func:Pchar; tdll:Pchar; tfunc:Pchar);cdecl;
  mono_lookup_pinvoke_call : function(method:PMonoMethod; exc_class:PPchar; exc_arg:PPchar):pointer;cdecl;
  mono_method_get_param_names : procedure(method:PMonoMethod; names:PPchar);cdecl;
  mono_method_get_param_token : function(method:PMonoMethod; idx:longint):uint32_t;cdecl;
  mono_method_get_marshal_info : procedure(method:PMonoMethod; mspecs:PPMonoMarshalSpec);cdecl;
  mono_method_has_marshal_info : function(method:PMonoMethod):mono_bool;cdecl;
  mono_method_get_last_managed : function:PMonoMethod;cdecl;
  mono_stack_walk : procedure(func:MonoStackWalk; user_data:pointer);cdecl;
  { Use this if the IL offset is not needed: it's faster  }
  mono_stack_walk_no_il : procedure(func:MonoStackWalk; user_data:pointer); cdecl;

type
  MonoStackWalkAsyncSafe = function (method:PMonoMethod; domain:PMonoDomain; base_address:pointer; offset:longint; data:pointer):mono_bool;cdecl;

var
  mono_stack_walk_async_safe : procedure(func:MonoStackWalkAsyncSafe; initial_sig_context:pointer; user_data:pointer);cdecl;
  mono_method_get_header_checked : function(method:PMonoMethod; error:PMonoError):PMonoMethodHeader;cdecl;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   

implementation


procedure free_procs;
begin
  mono_get_method:=nil;
  mono_get_method_full:=nil;
  mono_get_method_constrained:=nil;
  mono_free_method:=nil;
  mono_method_get_signature_full:=nil;
  mono_method_get_signature:=nil;
  mono_method_signature:=nil;
  mono_method_get_header:=nil;
  mono_method_get_name:=nil;
  mono_method_get_class:=nil;
  mono_method_get_token:=nil;
  mono_method_get_flags:=nil;
  mono_method_get_index:=nil;
  mono_load_image:=nil;
  mono_add_internal_call:=nil;
  mono_lookup_internal_call:=nil;
  mono_lookup_icall_symbol:=nil;
  mono_dllmap_insert:=nil;
  mono_lookup_pinvoke_call:=nil;
  mono_method_get_param_names:=nil;
  mono_method_get_param_token:=nil;
  mono_method_get_marshal_info:=nil;
  mono_method_has_marshal_info:=nil;
  mono_method_get_last_managed:=nil;
  mono_stack_walk:=nil;
  mono_stack_walk_no_il:=nil;
  mono_stack_walk_async_safe:=nil;
  mono_method_get_header_checked:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_get_method):=GetProcAddress(hlib,'mono_get_method');
  pointer(mono_get_method_full):=GetProcAddress(hlib,'mono_get_method_full');
  pointer(mono_get_method_constrained):=GetProcAddress(hlib,'mono_get_method_constrained');
  pointer(mono_free_method):=GetProcAddress(hlib,'mono_free_method');
  pointer(mono_method_get_signature_full):=GetProcAddress(hlib,'mono_method_get_signature_full');
  pointer(mono_method_get_signature):=GetProcAddress(hlib,'mono_method_get_signature');
  pointer(mono_method_signature):=GetProcAddress(hlib,'mono_method_signature');
  pointer(mono_method_get_header):=GetProcAddress(hlib,'mono_method_get_header');
  pointer(mono_method_get_name):=GetProcAddress(hlib,'mono_method_get_name');
  pointer(mono_method_get_class):=GetProcAddress(hlib,'mono_method_get_class');
  pointer(mono_method_get_token):=GetProcAddress(hlib,'mono_method_get_token');
  pointer(mono_method_get_flags):=GetProcAddress(hlib,'mono_method_get_flags');
  pointer(mono_method_get_index):=GetProcAddress(hlib,'mono_method_get_index');
  pointer(mono_load_image):=GetProcAddress(hlib,'mono_load_image');
  pointer(mono_add_internal_call):=GetProcAddress(hlib,'mono_add_internal_call');
  pointer(mono_lookup_internal_call):=GetProcAddress(hlib,'mono_lookup_internal_call');
  pointer(mono_lookup_icall_symbol):=GetProcAddress(hlib,'mono_lookup_icall_symbol');
  pointer(mono_dllmap_insert):=GetProcAddress(hlib,'mono_dllmap_insert');
  pointer(mono_lookup_pinvoke_call):=GetProcAddress(hlib,'mono_lookup_pinvoke_call');
  pointer(mono_method_get_param_names):=GetProcAddress(hlib,'mono_method_get_param_names');
  pointer(mono_method_get_param_token):=GetProcAddress(hlib,'mono_method_get_param_token');
  pointer(mono_method_get_marshal_info):=GetProcAddress(hlib,'mono_method_get_marshal_info');
  pointer(mono_method_has_marshal_info):=GetProcAddress(hlib,'mono_method_has_marshal_info');
  pointer(mono_method_get_last_managed):=GetProcAddress(hlib,'mono_method_get_last_managed');
  pointer(mono_stack_walk):=GetProcAddress(hlib,'mono_stack_walk');
  pointer(mono_stack_walk_no_il):=GetProcAddress(hlib,'mono_stack_walk_no_il');
  pointer(mono_stack_walk_async_safe):=GetProcAddress(hlib,'mono_stack_walk_async_safe');
  pointer(mono_method_get_header_checked):=GetProcAddress(hlib,'mono_method_get_header_checked');
end;


end.
