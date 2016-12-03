{$mode objfpc}
unit mono_debug_helpers;
interface
uses
  mono_publib, mono_class, mono_metadata;

type

  PMonoDisIndenter = ^MonoDisIndenter;
  PMonoDisTokener = ^MonoDisTokener;
  PMonoDisHelper = ^MonoDisHelper;

  MonoDisTokener = function (dh:PMonoDisHelper; method:PMonoMethod; token:uint32_t):Pchar;cdecl;
  MonoDisIndenter = function (dh:PMonoDisHelper; method:PMonoMethod; ip_offset:uint32_t):Pchar;cdecl;

  MonoDisHelper = record
    newline : Pchar;
    label_format : Pchar;
    label_target : Pchar;
    indenter : MonoDisIndenter;
    tokener : MonoDisTokener;
    user_data : pointer;
  end;

  PMonoMethodDesc = ^MonoMethodDesc;
  MonoMethodDesc = record
  end;

var
  mono_disasm_code_one : function(dh:PMonoDisHelper; method:PMonoMethod; ip:Pmono_byte; endp:PPmono_byte):Pchar;cdecl;
  mono_disasm_code : function(dh:PMonoDisHelper; method:PMonoMethod; ip:Pmono_byte; pend:Pmono_byte):Pchar;cdecl;
  mono_type_full_name : function(_type:PMonoType):Pchar;cdecl;
  mono_signature_get_desc : function(sig:PMonoMethodSignature; include_namespace:mono_bool):Pchar;cdecl;
  mono_context_get_desc : function(context:PMonoGenericContext):Pchar;cdecl;
  mono_method_desc_new : function(name:Pchar; include_namespace:mono_bool):PMonoMethodDesc;cdecl;
  mono_method_desc_from_method : function(method:PMonoMethod):PMonoMethodDesc;cdecl;
  mono_method_desc_free : procedure(desc:PMonoMethodDesc);cdecl;
  mono_method_desc_match : function(desc:PMonoMethodDesc; method:PMonoMethod):mono_bool;cdecl;
  mono_method_desc_full_match : function(desc:PMonoMethodDesc; method:PMonoMethod):mono_bool;cdecl;
  mono_method_desc_search_in_class : function(desc:PMonoMethodDesc; klass:PMonoClass):PMonoMethod;cdecl;
  mono_method_desc_search_in_image : function(desc:PMonoMethodDesc; image:PMonoImage):PMonoMethod;cdecl;
  mono_method_full_name : function(method:PMonoMethod; signature:mono_bool):Pchar;cdecl;
  mono_field_full_name : function(field:PMonoClassField):Pchar;cdecl;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation

procedure free_procs;
begin
  mono_disasm_code_one:=nil;
  mono_disasm_code:=nil;
  mono_type_full_name:=nil;
  mono_signature_get_desc:=nil;
  mono_context_get_desc:=nil;
  mono_method_desc_new:=nil;
  mono_method_desc_from_method:=nil;
  mono_method_desc_free:=nil;
  mono_method_desc_match:=nil;
  mono_method_desc_full_match:=nil;
  mono_method_desc_search_in_class:=nil;
  mono_method_desc_search_in_image:=nil;
  mono_method_full_name:=nil;
  mono_field_full_name:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_disasm_code_one):=GetProcAddress(hlib,'mono_disasm_code_one');
  pointer(mono_disasm_code):=GetProcAddress(hlib,'mono_disasm_code');
  pointer(mono_type_full_name):=GetProcAddress(hlib,'mono_type_full_name');
  pointer(mono_signature_get_desc):=GetProcAddress(hlib,'mono_signature_get_desc');
  pointer(mono_context_get_desc):=GetProcAddress(hlib,'mono_context_get_desc');
  pointer(mono_method_desc_new):=GetProcAddress(hlib,'mono_method_desc_new');
  pointer(mono_method_desc_from_method):=GetProcAddress(hlib,'mono_method_desc_from_method');
  pointer(mono_method_desc_free):=GetProcAddress(hlib,'mono_method_desc_free');
  pointer(mono_method_desc_match):=GetProcAddress(hlib,'mono_method_desc_match');
  pointer(mono_method_desc_full_match):=GetProcAddress(hlib,'mono_method_desc_full_match');
  pointer(mono_method_desc_search_in_class):=GetProcAddress(hlib,'mono_method_desc_search_in_class');
  pointer(mono_method_desc_search_in_image):=GetProcAddress(hlib,'mono_method_desc_search_in_image');
  pointer(mono_method_full_name):=GetProcAddress(hlib,'mono_method_full_name');
  pointer(mono_field_full_name):=GetProcAddress(hlib,'mono_field_full_name');
end;


end.
