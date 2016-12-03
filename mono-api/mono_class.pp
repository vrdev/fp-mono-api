{$mode objfpc}
unit mono_class;

interface
uses
  mono_publib, mono_metadata, mono_image, mono_error;


type

  PMonoClassField = ^MonoClassField;
  MonoClassField = record
  end;

  PMonoProperty = ^MonoProperty;
  MonoProperty = record
  end;

  PMonoEvent = ^MonoEvent;
  MonoEvent = record
  end;

  PMonoVTable = ^MonoVTable;
  MonoVTable = record
  end;

var
  mono_class_get : function(image:PMonoImage; type_token:uint32_t):PMonoClass;cdecl;
  mono_class_get_full : function(image:PMonoImage; type_token:uint32_t; context:PMonoGenericContext):PMonoClass;cdecl;
  mono_class_init : function(klass:PMonoClass):mono_bool;cdecl;
  mono_class_vtable : function(domain:PMonoDomain; klass:PMonoClass):PMonoVTable;cdecl;
  mono_class_from_name : function(image:PMonoImage; name_space:Pchar; name:Pchar):PMonoClass;cdecl;
  mono_class_from_name_case : function(image:PMonoImage; name_space:Pchar; name:Pchar):PMonoClass;cdecl;
  mono_class_get_method_from_name_flags : function(klass:PMonoClass; name:Pchar; param_count:longint; flags:longint):PMonoMethod;cdecl;
  mono_class_from_typeref : function(image:PMonoImage; type_token:uint32_t):PMonoClass;cdecl;
  mono_class_from_typeref_checked : function(image:PMonoImage; type_token:uint32_t; error:PMonoError):PMonoClass;cdecl;
  mono_class_from_generic_parameter : function(param:PMonoGenericParam; image:PMonoImage; is_mvar:mono_bool):PMonoClass;cdecl;
  { MONO_DEPRECATED  }
  mono_class_inflate_generic_type : function(_type:PMonoType; context:PMonoGenericContext):PMonoType;cdecl;
  mono_class_inflate_generic_method : function(method:PMonoMethod; context:PMonoGenericContext):PMonoMethod;cdecl;
  mono_get_inflated_method : function(method:PMonoMethod):PMonoMethod;cdecl;
  mono_field_from_token : function(image:PMonoImage; token:uint32_t; retklass:PPMonoClass; context:PMonoGenericContext):PMonoClassField;cdecl;
  mono_bounded_array_class_get : function(element_class:PMonoClass; rank:uint32_t; bounded:mono_bool):PMonoClass;cdecl;
  mono_array_class_get : function(element_class:PMonoClass; rank:uint32_t):PMonoClass;cdecl;
  mono_ptr_class_get : function(_type:PMonoType):PMonoClass;cdecl;
  mono_class_get_field : function(klass:PMonoClass; field_token:uint32_t):PMonoClassField;cdecl;
  mono_class_get_field_from_name : function(klass:PMonoClass; name:Pchar):PMonoClassField;cdecl;
  mono_class_get_field_token : function(field:PMonoClassField):uint32_t;cdecl;
  mono_class_get_event_token : function(event:PMonoEvent):uint32_t;cdecl;
  mono_class_get_property_from_name : function(klass:PMonoClass; name:Pchar):PMonoProperty;cdecl;
  mono_class_get_property_token : function(prop:PMonoProperty):uint32_t;cdecl;
  mono_array_element_size : function(ac:PMonoClass):int32_t;cdecl;
  mono_class_instance_size : function(klass:PMonoClass):int32_t;cdecl;
  mono_class_array_element_size : function(klass:PMonoClass):int32_t;cdecl;
  mono_class_data_size : function(klass:PMonoClass):int32_t;cdecl;
  mono_class_value_size : function(klass:PMonoClass; align:Puint32_t):int32_t;cdecl;
  mono_class_min_align : function(klass:PMonoClass):int32_t;cdecl;
  mono_class_from_mono_type : function(_type:PMonoType):PMonoClass;cdecl;
  mono_class_is_subclass_of : function(klass:PMonoClass; klassc:PMonoClass; check_interfaces:mono_bool):mono_bool;cdecl;
  mono_class_is_assignable_from : function(klass:PMonoClass; oklass:PMonoClass):mono_bool;cdecl;
  mono_ldtoken : function(image:PMonoImage; token:uint32_t; retclass:PPMonoClass; context:PMonoGenericContext):pointer;cdecl;
  mono_type_get_name : function(_type:PMonoType):Pchar;cdecl;
  mono_type_get_underlying_type : function(_type:PMonoType):PMonoType;cdecl;
  { MonoClass accessors  }
  mono_class_get_image : function(klass:PMonoClass):PMonoImage;cdecl;
  mono_class_get_element_class : function(klass:PMonoClass):PMonoClass;cdecl;
  mono_class_is_valuetype : function(klass:PMonoClass):mono_bool;cdecl;
  mono_class_is_enum : function(klass:PMonoClass):mono_bool;cdecl;
  mono_class_enum_basetype : function(klass:PMonoClass):PMonoType;cdecl;
  mono_class_get_parent : function(klass:PMonoClass):PMonoClass;cdecl;
  mono_class_get_nesting_type : function(klass:PMonoClass):PMonoClass;cdecl;
  mono_class_get_rank : function(klass:PMonoClass):longint;cdecl;
  mono_class_get_flags : function(klass:PMonoClass):uint32_t;cdecl;
  mono_class_get_name : function(klass:PMonoClass):Pchar;cdecl;
  mono_class_get_namespace : function(klass:PMonoClass):Pchar;cdecl;
  mono_class_get_type : function(klass:PMonoClass):PMonoType;cdecl;
  mono_class_get_type_token : function(klass:PMonoClass):uint32_t;cdecl;
  mono_class_get_byref_type : function(klass:PMonoClass):PMonoType;cdecl;
  mono_class_num_fields : function(klass:PMonoClass):longint;cdecl;
  mono_class_num_methods : function(klass:PMonoClass):longint;cdecl;
  mono_class_num_properties : function(klass:PMonoClass):longint;cdecl;
  mono_class_num_events : function(klass:PMonoClass):longint;cdecl;
  mono_class_get_fields : function(klass:PMonoClass; iter:Ppointer):PMonoClassField;cdecl;
  mono_class_get_methods : function(klass:PMonoClass; iter:Ppointer):PMonoMethod;cdecl;
  mono_class_get_properties : function(klass:PMonoClass; iter:Ppointer):PMonoProperty;cdecl;
  mono_class_get_events : function(klass:PMonoClass; iter:Ppointer):PMonoEvent;cdecl;
  mono_class_get_interfaces : function(klass:PMonoClass; iter:Ppointer):PMonoClass;cdecl;
  mono_class_get_nested_types : function(klass:PMonoClass; iter:Ppointer):PMonoClass;cdecl;
  mono_class_is_delegate : function(klass:PMonoClass):mono_bool;cdecl;
  mono_class_implements_interface : function(klass:PMonoClass; iface:PMonoClass):mono_bool;cdecl;
  { MonoClassField accessors  }
  mono_field_get_name : function(field:PMonoClassField):Pchar;cdecl;
  mono_field_get_type : function(field:PMonoClassField):PMonoType;cdecl;
  mono_field_get_parent : function(field:PMonoClassField):PMonoClass;cdecl;
  mono_field_get_flags : function(field:PMonoClassField):uint32_t;cdecl;
  mono_field_get_offset : function(field:PMonoClassField):uint32_t;cdecl;
  mono_field_get_data : function(field:PMonoClassField):Pchar;cdecl;
  { MonoProperty acessors  }
  mono_property_get_name : function(prop:PMonoProperty):Pchar;cdecl;
  mono_property_get_set_method : function(prop:PMonoProperty):PMonoMethod;cdecl;
  mono_property_get_get_method : function(prop:PMonoProperty):PMonoMethod;cdecl;
  mono_property_get_parent : function(prop:PMonoProperty):PMonoClass;cdecl;
  mono_property_get_flags : function(prop:PMonoProperty):uint32_t;cdecl;
  { MonoEvent accessors  }
  mono_event_get_name : function(event:PMonoEvent):Pchar;cdecl;
  mono_event_get_add_method : function(event:PMonoEvent):PMonoMethod;cdecl;
  mono_event_get_remove_method : function(event:PMonoEvent):PMonoMethod;cdecl;
  mono_event_get_raise_method : function(event:PMonoEvent):PMonoMethod;cdecl;
  mono_event_get_parent : function(event:PMonoEvent):PMonoClass;cdecl;
  mono_event_get_flags : function(event:PMonoEvent):uint32_t;cdecl;
  mono_class_get_method_from_name : function(klass:PMonoClass; name:Pchar; param_count:longint):PMonoMethod;cdecl;
  mono_class_name_from_token : function(image:PMonoImage; type_token:uint32_t):Pchar;cdecl;
  mono_method_can_access_field : function(method:PMonoMethod; field:PMonoClassField):mono_bool;cdecl;
  mono_method_can_access_method : function(method:PMonoMethod; called:PMonoMethod):mono_bool;cdecl;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   

implementation

procedure free_procs;
begin
  mono_class_get:=nil;
  mono_class_get_full:=nil;
  mono_class_init:=nil;
  mono_class_vtable:=nil;
  mono_class_from_name:=nil;
  mono_class_from_name_case:=nil;
  mono_class_get_method_from_name_flags:=nil;
  mono_class_from_typeref:=nil;
  mono_class_from_typeref_checked:=nil;
  mono_class_from_generic_parameter:=nil;
  mono_class_inflate_generic_type:=nil;
  mono_class_inflate_generic_method:=nil;
  mono_get_inflated_method:=nil;
  mono_field_from_token:=nil;
  mono_bounded_array_class_get:=nil;
  mono_array_class_get:=nil;
  mono_ptr_class_get:=nil;
  mono_class_get_field:=nil;
  mono_class_get_field_from_name:=nil;
  mono_class_get_field_token:=nil;
  mono_class_get_event_token:=nil;
  mono_class_get_property_from_name:=nil;
  mono_class_get_property_token:=nil;
  mono_array_element_size:=nil;
  mono_class_instance_size:=nil;
  mono_class_array_element_size:=nil;
  mono_class_data_size:=nil;
  mono_class_value_size:=nil;
  mono_class_min_align:=nil;
  mono_class_from_mono_type:=nil;
  mono_class_is_subclass_of:=nil;
  mono_class_is_assignable_from:=nil;
  mono_ldtoken:=nil;
  mono_type_get_name:=nil;
  mono_type_get_underlying_type:=nil;
  mono_class_get_image:=nil;
  mono_class_get_element_class:=nil;
  mono_class_is_valuetype:=nil;
  mono_class_is_enum:=nil;
  mono_class_enum_basetype:=nil;
  mono_class_get_parent:=nil;
  mono_class_get_nesting_type:=nil;
  mono_class_get_rank:=nil;
  mono_class_get_flags:=nil;
  mono_class_get_name:=nil;
  mono_class_get_namespace:=nil;
  mono_class_get_type:=nil;
  mono_class_get_type_token:=nil;
  mono_class_get_byref_type:=nil;
  mono_class_num_fields:=nil;
  mono_class_num_methods:=nil;
  mono_class_num_properties:=nil;
  mono_class_num_events:=nil;
  mono_class_get_fields:=nil;
  mono_class_get_methods:=nil;
  mono_class_get_properties:=nil;
  mono_class_get_events:=nil;
  mono_class_get_interfaces:=nil;
  mono_class_get_nested_types:=nil;
  mono_class_is_delegate:=nil;
  mono_class_implements_interface:=nil;
  mono_field_get_name:=nil;
  mono_field_get_type:=nil;
  mono_field_get_parent:=nil;
  mono_field_get_flags:=nil;
  mono_field_get_offset:=nil;
  mono_field_get_data:=nil;
  mono_property_get_name:=nil;
  mono_property_get_set_method:=nil;
  mono_property_get_get_method:=nil;
  mono_property_get_parent:=nil;
  mono_property_get_flags:=nil;
  mono_event_get_name:=nil;
  mono_event_get_add_method:=nil;
  mono_event_get_remove_method:=nil;
  mono_event_get_remove_method:=nil;
  mono_event_get_raise_method:=nil;
  mono_event_get_parent:=nil;
  mono_event_get_flags:=nil;
  mono_class_get_method_from_name:=nil;
  mono_class_name_from_token:=nil;
  mono_method_can_access_field:=nil;
  mono_method_can_access_method:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_class_get):=GetProcAddress(hlib,'mono_class_get');
  pointer(mono_class_get_full):=GetProcAddress(hlib,'mono_class_get_full');
  pointer(mono_class_init):=GetProcAddress(hlib,'mono_class_init');
  pointer(mono_class_vtable):=GetProcAddress(hlib,'mono_class_vtable');
  pointer(mono_class_from_name):=GetProcAddress(hlib,'mono_class_from_name');
  pointer(mono_class_from_name_case):=GetProcAddress(hlib,'mono_class_from_name_case');
  pointer(mono_class_get_method_from_name_flags):=GetProcAddress(hlib,'mono_class_get_method_from_name_flags');
  pointer(mono_class_from_typeref):=GetProcAddress(hlib,'mono_class_from_typeref');
  pointer(mono_class_from_typeref_checked):=GetProcAddress(hlib,'mono_class_from_typeref_checked');
  pointer(mono_class_from_generic_parameter):=GetProcAddress(hlib,'mono_class_from_generic_parameter');
  pointer(mono_class_inflate_generic_type):=GetProcAddress(hlib,'mono_class_inflate_generic_type');
  pointer(mono_class_inflate_generic_method):=GetProcAddress(hlib,'mono_class_inflate_generic_method');
  pointer(mono_get_inflated_method):=GetProcAddress(hlib,'mono_get_inflated_method');
  pointer(mono_field_from_token):=GetProcAddress(hlib,'mono_field_from_token');
  pointer(mono_bounded_array_class_get):=GetProcAddress(hlib,'mono_bounded_array_class_get');
  pointer(mono_array_class_get):=GetProcAddress(hlib,'mono_array_class_get');
  pointer(mono_ptr_class_get):=GetProcAddress(hlib,'mono_ptr_class_get');
  pointer(mono_class_get_field):=GetProcAddress(hlib,'mono_class_get_field');
  pointer(mono_class_get_field_from_name):=GetProcAddress(hlib,'mono_class_get_field_from_name');
  pointer(mono_class_get_field_token):=GetProcAddress(hlib,'mono_class_get_field_token');
  pointer(mono_class_get_event_token):=GetProcAddress(hlib,'mono_class_get_event_token');
  pointer(mono_class_get_property_from_name):=GetProcAddress(hlib,'mono_class_get_property_from_name');
  pointer(mono_class_get_property_token):=GetProcAddress(hlib,'mono_class_get_property_token');
  pointer(mono_array_element_size):=GetProcAddress(hlib,'mono_array_element_size');
  pointer(mono_class_instance_size):=GetProcAddress(hlib,'mono_class_instance_size');
  pointer(mono_class_array_element_size):=GetProcAddress(hlib,'mono_class_array_element_size');
  pointer(mono_class_data_size):=GetProcAddress(hlib,'mono_class_data_size');
  pointer(mono_class_value_size):=GetProcAddress(hlib,'mono_class_value_size');
  pointer(mono_class_min_align):=GetProcAddress(hlib,'mono_class_min_align');
  pointer(mono_class_from_mono_type):=GetProcAddress(hlib,'mono_class_from_mono_type');
  pointer(mono_class_is_subclass_of):=GetProcAddress(hlib,'mono_class_is_subclass_of');
  pointer(mono_class_is_assignable_from):=GetProcAddress(hlib,'mono_class_is_assignable_from');
  pointer(mono_ldtoken):=GetProcAddress(hlib,'mono_ldtoken');
  pointer(mono_type_get_name):=GetProcAddress(hlib,'mono_type_get_name');
  pointer(mono_type_get_underlying_type):=GetProcAddress(hlib,'mono_type_get_underlying_type');
  pointer(mono_class_get_image):=GetProcAddress(hlib,'mono_class_get_image');
  pointer(mono_class_get_element_class):=GetProcAddress(hlib,'mono_class_get_element_class');
  pointer(mono_class_is_valuetype):=GetProcAddress(hlib,'mono_class_is_valuetype');
  pointer(mono_class_is_enum):=GetProcAddress(hlib,'mono_class_is_enum');
  pointer(mono_class_enum_basetype):=GetProcAddress(hlib,'mono_class_enum_basetype');
  pointer(mono_class_get_parent):=GetProcAddress(hlib,'mono_class_get_parent');
  pointer(mono_class_get_nesting_type):=GetProcAddress(hlib,'mono_class_get_nesting_type');
  pointer(mono_class_get_rank):=GetProcAddress(hlib,'mono_class_get_rank');
  pointer(mono_class_get_flags):=GetProcAddress(hlib,'mono_class_get_flags');
  pointer(mono_class_get_name):=GetProcAddress(hlib,'mono_class_get_name');
  pointer(mono_class_get_namespace):=GetProcAddress(hlib,'mono_class_get_namespace');
  pointer(mono_class_get_type):=GetProcAddress(hlib,'mono_class_get_type');
  pointer(mono_class_get_type_token):=GetProcAddress(hlib,'mono_class_get_type_token');
  pointer(mono_class_get_byref_type):=GetProcAddress(hlib,'mono_class_get_byref_type');
  pointer(mono_class_num_fields):=GetProcAddress(hlib,'mono_class_num_fields');
  pointer(mono_class_num_methods):=GetProcAddress(hlib,'mono_class_num_methods');
  pointer(mono_class_num_properties):=GetProcAddress(hlib,'mono_class_num_properties');
  pointer(mono_class_num_events):=GetProcAddress(hlib,'mono_class_num_events');
  pointer(mono_class_get_fields):=GetProcAddress(hlib,'mono_class_get_fields');
  pointer(mono_class_get_methods):=GetProcAddress(hlib,'mono_class_get_methods');
  pointer(mono_class_get_properties):=GetProcAddress(hlib,'mono_class_get_properties');
  pointer(mono_class_get_events):=GetProcAddress(hlib,'mono_class_get_events');
  pointer(mono_class_get_interfaces):=GetProcAddress(hlib,'mono_class_get_interfaces');
  pointer(mono_class_get_nested_types):=GetProcAddress(hlib,'mono_class_get_nested_types');
  pointer(mono_class_is_delegate):=GetProcAddress(hlib,'mono_class_is_delegate');
  pointer(mono_class_implements_interface):=GetProcAddress(hlib,'mono_class_implements_interface');
  pointer(mono_field_get_name):=GetProcAddress(hlib,'mono_field_get_name');
  pointer(mono_field_get_type):=GetProcAddress(hlib,'mono_field_get_type');
  pointer(mono_field_get_parent):=GetProcAddress(hlib,'mono_field_get_parent');
  pointer(mono_field_get_flags):=GetProcAddress(hlib,'mono_field_get_flags');
  pointer(mono_field_get_offset):=GetProcAddress(hlib,'mono_field_get_offset');
  pointer(mono_field_get_data):=GetProcAddress(hlib,'mono_field_get_data');
  pointer(mono_property_get_name):=GetProcAddress(hlib,'mono_property_get_name');
  pointer(mono_property_get_set_method):=GetProcAddress(hlib,'mono_property_get_set_method');
  pointer(mono_property_get_get_method):=GetProcAddress(hlib,'mono_property_get_get_method');
  pointer(mono_property_get_parent):=GetProcAddress(hlib,'mono_property_get_parent');
  pointer(mono_property_get_flags):=GetProcAddress(hlib,'mono_property_get_flags');
  pointer(mono_event_get_name):=GetProcAddress(hlib,'mono_event_get_name');
  pointer(mono_event_get_add_method):=GetProcAddress(hlib,'mono_event_get_add_method');
  pointer(mono_event_get_remove_method):=GetProcAddress(hlib,'mono_event_get_remove_method');
  pointer(mono_event_get_remove_method):=GetProcAddress(hlib,'mono_event_get_remove_method');
  pointer(mono_event_get_raise_method):=GetProcAddress(hlib,'mono_event_get_raise_method');
  pointer(mono_event_get_parent):=GetProcAddress(hlib,'mono_event_get_parent');
  pointer(mono_event_get_flags):=GetProcAddress(hlib,'mono_event_get_flags');
  pointer(mono_class_get_method_from_name):=GetProcAddress(hlib,'mono_class_get_method_from_name');
  pointer(mono_class_name_from_token):=GetProcAddress(hlib,'mono_class_name_from_token');
  pointer(mono_method_can_access_field):=GetProcAddress(hlib,'mono_method_can_access_field');
  pointer(mono_method_can_access_method):=GetProcAddress(hlib,'mono_method_can_access_method');
end;

end.
