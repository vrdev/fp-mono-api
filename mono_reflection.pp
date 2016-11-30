{$mode objfpc}
unit mono_reflection;

interface
uses
  mono_publib, mono_metadata, mono_assembly, mono_class, mono_object, mono_error;

type
  PMonoTypeNameParse = ^MonoTypeNameParse;
  MonoTypeNameParse = record
  end;


  PMonoCustomAttrEntry = ^MonoCustomAttrEntry;
  MonoCustomAttrEntry = record
    ctor : PMonoMethod;
    data_size : uint32_t;
    data : Pmono_byte;
  end;

  PMonoCustomAttrInfo = ^MonoCustomAttrInfo;
  MonoCustomAttrInfo = record
    num_attrs : longint;
    cached : longint;
    image : PMonoImage;
    attrs : array[0..(MONO_ZERO_LEN_ARRAY)-1] of MonoCustomAttrEntry;
  end;


{
* Information which isn't in the MonoMethod structure is stored here for
* dynamic methods.
}

type
  PMonoReflectionMethodAux = ^MonoReflectionMethodAux;
  MonoReflectionMethodAux = record
    param_names : ^Pchar;
    param_marshall : ^PMonoMarshalSpec;
    param_cattr : ^PMonoCustomAttrInfo;
    param_defaults : ^Puint8_t;
    param_default_types : Puint32_t;
    dllentry : Pchar;
    dll : Pchar;
  end;

  PMonoResolveTokenError = ^MonoResolveTokenError;
  MonoResolveTokenError =  Longint;
const
  ResolveTokenError_OutOfRange = 0;
  ResolveTokenError_BadTable = 1;
  ResolveTokenError_Other = 2;


{ this structure MUST be kept in synch with RuntimeDeclSecurityEntry
* located in /mcs/class/corlib/System.Security/SecurityFrame.cs  }

type
  PMonoDeclSecurityEntry = ^MonoDeclSecurityEntry;
  MonoDeclSecurityEntry = record
    blob : Pchar;
    size : uint32_t;
    index : uint32_t;
  end;

  PMonoDeclSecurityActions = ^MonoDeclSecurityActions;
  MonoDeclSecurityActions = record
    demand : MonoDeclSecurityEntry;
    noncasdemand : MonoDeclSecurityEntry;
    demandchoice : MonoDeclSecurityEntry;
  end;


const
  MONO_DECLSEC_ACTION_MIN = $1;
  MONO_DECLSEC_ACTION_MAX = $12;

type
  MonoDeclFlags =  Longint;
const
  MONO_DECLSEC_FLAG_REQUEST = $00000001;
  MONO_DECLSEC_FLAG_DEMAND = $00000002;
  MONO_DECLSEC_FLAG_ASSERT = $00000004;
  MONO_DECLSEC_FLAG_DENY = $00000008;
  MONO_DECLSEC_FLAG_PERMITONLY = $00000010;
  MONO_DECLSEC_FLAG_LINKDEMAND = $00000020;
  MONO_DECLSEC_FLAG_INHERITANCEDEMAND = $00000040;
  MONO_DECLSEC_FLAG_REQUEST_MINIMUM = $00000080;
  MONO_DECLSEC_FLAG_REQUEST_OPTIONAL = $00000100;
  MONO_DECLSEC_FLAG_REQUEST_REFUSE = $00000200;
  MONO_DECLSEC_FLAG_PREJIT_GRANT = $00000400;
  MONO_DECLSEC_FLAG_PREJIT_DENY = $00000800;
  MONO_DECLSEC_FLAG_NONCAS_DEMAND = $00001000;
  MONO_DECLSEC_FLAG_NONCAS_LINKDEMAND = $00002000;
  MONO_DECLSEC_FLAG_NONCAS_INHERITANCEDEMAND = $00004000;
  MONO_DECLSEC_FLAG_LINKDEMAND_CHOICE = $00008000;
  MONO_DECLSEC_FLAG_INHERITANCEDEMAND_CHOICE = $00010000;
  MONO_DECLSEC_FLAG_DEMAND_CHOICE = $00020000;

var
  mono_reflection_parse_type : function(name:Pchar; info:PMonoTypeNameParse):longint;
  mono_reflection_get_type : function(image:PMonoImage; info:PMonoTypeNameParse; ignorecase:mono_bool; type_resolve:Pmono_bool):PMonoType;
  mono_reflection_free_type_info : procedure(info:PMonoTypeNameParse);
  mono_reflection_type_from_name : function(name:Pchar; image:PMonoImage):PMonoType;
  mono_reflection_get_token : function(obj:PMonoObject):uint32_t;
  mono_assembly_get_object : function(domain:PMonoDomain; assembly:PMonoAssembly):PMonoReflectionAssembly;
  mono_module_get_object : function(domain:PMonoDomain; image:PMonoImage):PMonoReflectionModule;
  mono_module_file_get_object : function(domain:PMonoDomain; image:PMonoImage; table_index:longint):PMonoReflectionModule;
  mono_type_get_object : function(domain:PMonoDomain; _type:PMonoType):PMonoReflectionType;
  mono_method_get_object : function(domain:PMonoDomain; method:PMonoMethod; refclass:PMonoClass):PMonoReflectionMethod;
  mono_field_get_object : function(domain:PMonoDomain; klass:PMonoClass; field:PMonoClassField):PMonoReflectionField;
  mono_property_get_object : function(domain:PMonoDomain; klass:PMonoClass; _property:PMonoProperty):PMonoReflectionProperty;
  mono_event_get_object : function(domain:PMonoDomain; klass:PMonoClass; event:PMonoEvent):PMonoReflectionEvent;
  { note: this one is slightly different: we keep the whole array of params in the cache  }
  mono_param_get_objects : function(domain:PMonoDomain; method:PMonoMethod):PMonoArray;
  mono_method_body_get_object : function(domain:PMonoDomain; method:PMonoMethod):PMonoReflectionMethodBody;
  mono_get_dbnull_object : function(domain:PMonoDomain):PMonoObject;
  mono_reflection_get_custom_attrs_by_type : function(obj:PMonoObject; attr_klass:PMonoClass; error:PMonoError):PMonoArray;
  mono_reflection_get_custom_attrs : function(obj:PMonoObject):PMonoArray;
  mono_reflection_get_custom_attrs_data : function(obj:PMonoObject):PMonoArray;
  mono_reflection_get_custom_attrs_blob : function(assembly:PMonoReflectionAssembly; ctor:PMonoObject; ctorArgs:PMonoArray; properties:PMonoArray; porpValues:PMonoArray;
    fields:PMonoArray; fieldValues:PMonoArray):PMonoArray;
  mono_reflection_get_custom_attrs_info : function(obj:PMonoObject):PMonoCustomAttrInfo;
  mono_custom_attrs_construct : function(cinfo:PMonoCustomAttrInfo):PMonoArray;
  mono_custom_attrs_from_index : function(image:PMonoImage; idx:uint32_t):PMonoCustomAttrInfo;
  mono_custom_attrs_from_method : function(method:PMonoMethod):PMonoCustomAttrInfo;
  mono_custom_attrs_from_class : function(klass:PMonoClass):PMonoCustomAttrInfo;
  mono_custom_attrs_from_assembly : function(assembly:PMonoAssembly):PMonoCustomAttrInfo;
  mono_custom_attrs_from_property : function(klass:PMonoClass; _property:PMonoProperty):PMonoCustomAttrInfo;
  mono_custom_attrs_from_event : function(klass:PMonoClass; event:PMonoEvent):PMonoCustomAttrInfo;
  mono_custom_attrs_from_field : function(klass:PMonoClass; field:PMonoClassField):PMonoCustomAttrInfo;
  mono_custom_attrs_from_param : function(method:PMonoMethod; param:uint32_t):PMonoCustomAttrInfo;
  mono_custom_attrs_has_attr : function(ainfo:PMonoCustomAttrInfo; attr_klass:PMonoClass):mono_bool;
  mono_custom_attrs_get_attr : function(ainfo:PMonoCustomAttrInfo; attr_klass:PMonoClass):PMonoObject;
  mono_custom_attrs_free : procedure(ainfo:PMonoCustomAttrInfo);
  mono_declsec_flags_from_method : function(method:PMonoMethod):uint32_t;
  mono_declsec_flags_from_class : function(klass:PMonoClass):uint32_t;
  mono_declsec_flags_from_assembly : function(assembly:PMonoAssembly):uint32_t;
  mono_declsec_get_demands : function(callee:PMonoMethod; demands:PMonoDeclSecurityActions):MonoBoolean;
  mono_declsec_get_linkdemands : function(callee:PMonoMethod; klass:PMonoDeclSecurityActions; cmethod:PMonoDeclSecurityActions):MonoBoolean;
  mono_declsec_get_inheritdemands_class : function(klass:PMonoClass; demands:PMonoDeclSecurityActions):MonoBoolean;
  mono_declsec_get_inheritdemands_method : function(callee:PMonoMethod; demands:PMonoDeclSecurityActions):MonoBoolean;
  mono_declsec_get_method_action : function(method:PMonoMethod; action:uint32_t; entry:PMonoDeclSecurityEntry):MonoBoolean;
  mono_declsec_get_class_action : function(klass:PMonoClass; action:uint32_t; entry:PMonoDeclSecurityEntry):MonoBoolean;
  mono_declsec_get_assembly_action : function(assembly:PMonoAssembly; action:uint32_t; entry:PMonoDeclSecurityEntry):MonoBoolean;
  mono_reflection_type_get_type : function(reftype:PMonoReflectionType):PMonoType;
  mono_reflection_assembly_get_assembly : function(refassembly:PMonoReflectionAssembly):PMonoAssembly;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation


procedure free_procs;
begin
  mono_reflection_parse_type:=nil;
  mono_reflection_get_type:=nil;
  mono_reflection_free_type_info:=nil;
  mono_reflection_type_from_name:=nil;
  mono_reflection_get_token:=nil;
  mono_assembly_get_object:=nil;
  mono_module_get_object:=nil;
  mono_module_file_get_object:=nil;
  mono_type_get_object:=nil;
  mono_method_get_object:=nil;
  mono_field_get_object:=nil;
  mono_property_get_object:=nil;
  mono_event_get_object:=nil;
  mono_param_get_objects:=nil;
  mono_method_body_get_object:=nil;
  mono_get_dbnull_object:=nil;
  mono_reflection_get_custom_attrs_by_type:=nil;
  mono_reflection_get_custom_attrs:=nil;
  mono_reflection_get_custom_attrs_data:=nil;
  mono_reflection_get_custom_attrs_blob:=nil;
  mono_reflection_get_custom_attrs_info:=nil;
  mono_custom_attrs_construct:=nil;
  mono_custom_attrs_from_index:=nil;
  mono_custom_attrs_from_method:=nil;
  mono_custom_attrs_from_class:=nil;
  mono_custom_attrs_from_assembly:=nil;
  mono_custom_attrs_from_property:=nil;
  mono_custom_attrs_from_event:=nil;
  mono_custom_attrs_from_field:=nil;
  mono_custom_attrs_from_param:=nil;
  mono_custom_attrs_has_attr:=nil;
  mono_custom_attrs_get_attr:=nil;
  mono_custom_attrs_free:=nil;
  mono_declsec_flags_from_method:=nil;
  mono_declsec_flags_from_class:=nil;
  mono_declsec_flags_from_assembly:=nil;
  mono_declsec_get_demands:=nil;
  mono_declsec_get_linkdemands:=nil;
  mono_declsec_get_inheritdemands_class:=nil;
  mono_declsec_get_inheritdemands_method:=nil;
  mono_declsec_get_method_action:=nil;
  mono_declsec_get_class_action:=nil;
  mono_declsec_get_assembly_action:=nil;
  mono_reflection_type_get_type:=nil;
  mono_reflection_assembly_get_assembly:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_reflection_parse_type):=GetProcAddress(hlib,'mono_reflection_parse_type');
  pointer(mono_reflection_get_type):=GetProcAddress(hlib,'mono_reflection_get_type');
  pointer(mono_reflection_free_type_info):=GetProcAddress(hlib,'mono_reflection_free_type_info');
  pointer(mono_reflection_type_from_name):=GetProcAddress(hlib,'mono_reflection_type_from_name');
  pointer(mono_reflection_get_token):=GetProcAddress(hlib,'mono_reflection_get_token');
  pointer(mono_assembly_get_object):=GetProcAddress(hlib,'mono_assembly_get_object');
  pointer(mono_module_get_object):=GetProcAddress(hlib,'mono_module_get_object');
  pointer(mono_module_file_get_object):=GetProcAddress(hlib,'mono_module_file_get_object');
  pointer(mono_type_get_object):=GetProcAddress(hlib,'mono_type_get_object');
  pointer(mono_method_get_object):=GetProcAddress(hlib,'mono_method_get_object');
  pointer(mono_field_get_object):=GetProcAddress(hlib,'mono_field_get_object');
  pointer(mono_property_get_object):=GetProcAddress(hlib,'mono_property_get_object');
  pointer(mono_event_get_object):=GetProcAddress(hlib,'mono_event_get_object');
  pointer(mono_param_get_objects):=GetProcAddress(hlib,'mono_param_get_objects');
  pointer(mono_method_body_get_object):=GetProcAddress(hlib,'mono_method_body_get_object');
  pointer(mono_get_dbnull_object):=GetProcAddress(hlib,'mono_get_dbnull_object');
  pointer(mono_reflection_get_custom_attrs_by_type):=GetProcAddress(hlib,'mono_reflection_get_custom_attrs_by_type');
  pointer(mono_reflection_get_custom_attrs):=GetProcAddress(hlib,'mono_reflection_get_custom_attrs');
  pointer(mono_reflection_get_custom_attrs_data):=GetProcAddress(hlib,'mono_reflection_get_custom_attrs_data');
  pointer(mono_reflection_get_custom_attrs_blob):=GetProcAddress(hlib,'mono_reflection_get_custom_attrs_blob');
  pointer(mono_reflection_get_custom_attrs_info):=GetProcAddress(hlib,'mono_reflection_get_custom_attrs_info');
  pointer(mono_custom_attrs_construct):=GetProcAddress(hlib,'mono_custom_attrs_construct');
  pointer(mono_custom_attrs_from_index):=GetProcAddress(hlib,'mono_custom_attrs_from_index');
  pointer(mono_custom_attrs_from_method):=GetProcAddress(hlib,'mono_custom_attrs_from_method');
  pointer(mono_custom_attrs_from_class):=GetProcAddress(hlib,'mono_custom_attrs_from_class');
  pointer(mono_custom_attrs_from_assembly):=GetProcAddress(hlib,'mono_custom_attrs_from_assembly');
  pointer(mono_custom_attrs_from_property):=GetProcAddress(hlib,'mono_custom_attrs_from_property');
  pointer(mono_custom_attrs_from_event):=GetProcAddress(hlib,'mono_custom_attrs_from_event');
  pointer(mono_custom_attrs_from_field):=GetProcAddress(hlib,'mono_custom_attrs_from_field');
  pointer(mono_custom_attrs_from_param):=GetProcAddress(hlib,'mono_custom_attrs_from_param');
  pointer(mono_custom_attrs_has_attr):=GetProcAddress(hlib,'mono_custom_attrs_has_attr');
  pointer(mono_custom_attrs_get_attr):=GetProcAddress(hlib,'mono_custom_attrs_get_attr');
  pointer(mono_custom_attrs_free):=GetProcAddress(hlib,'mono_custom_attrs_free');
  pointer(mono_declsec_flags_from_method):=GetProcAddress(hlib,'mono_declsec_flags_from_method');
  pointer(mono_declsec_flags_from_class):=GetProcAddress(hlib,'mono_declsec_flags_from_class');
  pointer(mono_declsec_flags_from_assembly):=GetProcAddress(hlib,'mono_declsec_flags_from_assembly');
  pointer(mono_declsec_get_demands):=GetProcAddress(hlib,'mono_declsec_get_demands');
  pointer(mono_declsec_get_linkdemands):=GetProcAddress(hlib,'mono_declsec_get_linkdemands');
  pointer(mono_declsec_get_inheritdemands_class):=GetProcAddress(hlib,'mono_declsec_get_inheritdemands_class');
  pointer(mono_declsec_get_inheritdemands_method):=GetProcAddress(hlib,'mono_declsec_get_inheritdemands_method');
  pointer(mono_declsec_get_method_action):=GetProcAddress(hlib,'mono_declsec_get_method_action');
  pointer(mono_declsec_get_class_action):=GetProcAddress(hlib,'mono_declsec_get_class_action');
  pointer(mono_declsec_get_assembly_action):=GetProcAddress(hlib,'mono_declsec_get_assembly_action');
  pointer(mono_reflection_type_get_type):=GetProcAddress(hlib,'mono_reflection_type_get_type');
  pointer(mono_reflection_assembly_get_assembly):=GetProcAddress(hlib,'mono_reflection_assembly_get_assembly');
end;

end.
