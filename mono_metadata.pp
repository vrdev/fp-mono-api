{$mode objfpc}
unit mono_metadata;

interface

uses
  mono_publib, mono_image;

type

  PPMonoClass = ^PMonoClass;
  PMonoClass = ^MonoClass;
  MonoClass = record
  end;

  PMonoDomain = ^MonoDomain;
  MonoDomain = record
  end;

  PPMonoMethod = ^PMonoMethod;
  PMonoMethod = ^MonoMethod;
  MonoMethod = record
  end;

  PMonoMethodHeader = ^MonoMethodHeader;
  MonoMethodHeader = record
  end;

  PPMonoType = ^PMonoType;
  PMonoType = ^MonoType;
  MonoType = record
  end;

  PMonoGenericInst = ^MonoGenericInst;
  MonoGenericInst = record
  end;

  PMonoGenericClass = ^MonoGenericClass;
  MonoGenericClass = record
  end;

  PMonoDynamicGenericClass = ^MonoDynamicGenericClass;
  MonoDynamicGenericClass = record
  end;

  PMonoGenericContext = ^MonoGenericContext;
  MonoGenericContext = record
  end;

  PMonoGenericContainer = ^MonoGenericContainer;
  MonoGenericContainer = record
  end;

  PMonoGenericParam = ^MonoGenericParam;
  MonoGenericParam = record
  end;

  PMonoMethodSignature = ^MonoMethodSignature;
  MonoMethodSignature = record
  end;

  PMonoGenericMethod = ^MonoGenericMethod;
  MonoGenericMethod = record
  end;

type
  MonoMarshalNative =  Longint;
  Const
    MONO_NATIVE_BOOLEAN = $02;
    MONO_NATIVE_I1 = $03;
    MONO_NATIVE_U1 = $04;
    MONO_NATIVE_I2 = $05;
    MONO_NATIVE_U2 = $06;
    MONO_NATIVE_I4 = $07;
    MONO_NATIVE_U4 = $08;
    MONO_NATIVE_I8 = $09;
    MONO_NATIVE_U8 = $0a;
    MONO_NATIVE_R4 = $0b;
    MONO_NATIVE_R8 = $0c;
    MONO_NATIVE_CURRENCY = $0f;
    MONO_NATIVE_BSTR = $13;
    MONO_NATIVE_LPSTR = $14;
    MONO_NATIVE_LPWSTR = $15;
    MONO_NATIVE_LPTSTR = $16;
    MONO_NATIVE_BYVALTSTR = $17;
    MONO_NATIVE_IUNKNOWN = $19;
    MONO_NATIVE_IDISPATCH = $1a;
    MONO_NATIVE_STRUCT = $1b;
    MONO_NATIVE_INTERFACE = $1c;
    MONO_NATIVE_SAFEARRAY = $1d;
    MONO_NATIVE_BYVALARRAY = $1e;
    MONO_NATIVE_INT = $1f;
    MONO_NATIVE_UINT = $20;
    MONO_NATIVE_VBBYREFSTR = $22;
    MONO_NATIVE_ANSIBSTR = $23;
    MONO_NATIVE_TBSTR = $24;
    MONO_NATIVE_VARIANTBOOL = $25;
    MONO_NATIVE_FUNC = $26;
    MONO_NATIVE_ASANY = $28;
    MONO_NATIVE_LPARRAY = $2a;
    MONO_NATIVE_LPSTRUCT = $2b;
    MONO_NATIVE_CUSTOM = $2c;
    MONO_NATIVE_ERROR = $2d;
    MONO_NATIVE_MAX = $50;

type
  MonoMarshalVariant =  Longint;
const
  MONO_VARIANT_EMPTY = $00;
  MONO_VARIANT_NULL = $01;
  MONO_VARIANT_I2 = $02;
  MONO_VARIANT_I4 = $03;
  MONO_VARIANT_R4 = $04;
  MONO_VARIANT_R8 = $05;
  MONO_VARIANT_CY = $06;
  MONO_VARIANT_DATE = $07;
  MONO_VARIANT_BSTR = $08;
  MONO_VARIANT_DISPATCH = $09;
  MONO_VARIANT_ERROR = $0a;
  MONO_VARIANT_BOOL = $0b;
  MONO_VARIANT_VARIANT = $0c;
  MONO_VARIANT_UNKNOWN = $0d;
  MONO_VARIANT_DECIMAL = $0e;
  MONO_VARIANT_I1 = $10;
  MONO_VARIANT_UI1 = $11;
  MONO_VARIANT_UI2 = $12;
  MONO_VARIANT_UI4 = $13;
  MONO_VARIANT_I8 = $14;
  MONO_VARIANT_UI8 = $15;
  MONO_VARIANT_INT = $16;
  MONO_VARIANT_UINT = $17;
  MONO_VARIANT_VOID = $18;
  MONO_VARIANT_HRESULT = $19;
  MONO_VARIANT_PTR = $1a;
  MONO_VARIANT_SAFEARRAY = $1b;
  MONO_VARIANT_CARRAY = $1c;
  MONO_VARIANT_USERDEFINED = $1d;
  MONO_VARIANT_LPSTR = $1e;
  MONO_VARIANT_LPWSTR = $1f;
  MONO_VARIANT_RECORD = $24;
  MONO_VARIANT_FILETIME = $40;
  MONO_VARIANT_BLOB = $41;
  MONO_VARIANT_STREAM = $42;
  MONO_VARIANT_STORAGE = $43;
  MONO_VARIANT_STREAMED_OBJECT = $44;
  MONO_VARIANT_STORED_OBJECT = $45;
  MONO_VARIANT_BLOB_OBJECT = $46;
  MONO_VARIANT_CF = $47;
  MONO_VARIANT_CLSID = $48;
  MONO_VARIANT_VECTOR = $1000;
  MONO_VARIANT_ARRAY = $2000;
  MONO_VARIANT_BYREF = $4000;


type
  PPMonoMarshalSpec = ^PMonoMarshalSpec;
  PMonoMarshalSpec = ^MonoMarshalSpec;
  MonoMarshalSpec = record
      native : MonoMarshalNative;
      data : record
          case longint of
            0 : ( array_data : record
                elem_type : MonoMarshalNative;
                num_elem : int32_t;
                param_num : int16_t;
                elem_mult : int16_t;
              end );
            1 : ( custom_data : record
                custom_name : Pchar;
                cookie : Pchar;
                image : PMonoImage;
              end );
            2 : ( safearray_data : record
                elem_type : MonoMarshalVariant;
                num_elem : int32_t;
              end );
          end;
    end;

type
  PMonoCustomMod = ^MonoCustomMod;
  MonoCustomMod = record
    flag0 : longint;
  end;

  PMonoArrayType = ^MonoArrayType;
  MonoArrayType = record
    eklass : PMonoClass;
    rank : uint8_t;
    numsizes : uint8_t;
    numlobounds : uint8_t;
    sizes : Plongint;
    lobounds : Plongint;
  end;

type
  PMonoExceptionClause = ^MonoExceptionClause;
  MonoExceptionClause = record
    flags : uint32_t;
    try_offset : uint32_t;
    try_len : uint32_t;
    handler_offset : uint32_t;
    handler_len : uint32_t;
    data : record
      case longint of
        0 : ( filter_offset : uint32_t );
        1 : ( catch_class : PMonoClass );
      end;
  end;

type
  MonoExceptionEnum =  Longint;
const
  MONO_EXCEPTION_CLAUSE_NONE = 0;
  MONO_EXCEPTION_CLAUSE_FILTER = 1;
  MONO_EXCEPTION_CLAUSE_FINALLY = 2;
  MONO_EXCEPTION_CLAUSE_FAULT = 4;


type
  MonoCallConvention = Longint;
const
  MONO_CALL_DEFAULT = 0;
  MONO_CALL_C = 1;
  MONO_CALL_STDCALL = 2;
  MONO_CALL_THISCALL = 3;
  MONO_CALL_FASTCALL = 4;
  MONO_CALL_VARARG = 5;

type
  MonoMarshalConv =  Longint;
const
  MONO_MARSHAL_CONV_NONE = 0;
  MONO_MARSHAL_CONV_BOOL_VARIANTBOOL = 1;
  MONO_MARSHAL_CONV_BOOL_I4 = 2;
  MONO_MARSHAL_CONV_STR_BSTR = 3;
  MONO_MARSHAL_CONV_STR_LPSTR = 4;
  MONO_MARSHAL_CONV_LPSTR_STR = 5;
  MONO_MARSHAL_CONV_LPTSTR_STR = 6;
  MONO_MARSHAL_CONV_STR_LPWSTR = 7;
  MONO_MARSHAL_CONV_LPWSTR_STR = 8;
  MONO_MARSHAL_CONV_STR_LPTSTR = 9;
  MONO_MARSHAL_CONV_STR_ANSIBSTR = 10;
  MONO_MARSHAL_CONV_STR_TBSTR = 11;
  MONO_MARSHAL_CONV_STR_BYVALSTR = 12;
  MONO_MARSHAL_CONV_STR_BYVALWSTR = 13;
  MONO_MARSHAL_CONV_SB_LPSTR = 14;
  MONO_MARSHAL_CONV_SB_LPTSTR = 15;
  MONO_MARSHAL_CONV_SB_LPWSTR = 16;
  MONO_MARSHAL_CONV_LPSTR_SB = 17;
  MONO_MARSHAL_CONV_LPTSTR_SB = 18;
  MONO_MARSHAL_CONV_LPWSTR_SB = 19;
  MONO_MARSHAL_CONV_ARRAY_BYVALARRAY = 20;
  MONO_MARSHAL_CONV_ARRAY_BYVALCHARARRAY = 21;
  MONO_MARSHAL_CONV_ARRAY_SAVEARRAY = 22;
  MONO_MARSHAL_CONV_ARRAY_LPARRAY = 23;
  MONO_MARSHAL_FREE_LPARRAY = 24;
  MONO_MARSHAL_CONV_OBJECT_INTERFACE = 25;
  MONO_MARSHAL_CONV_OBJECT_IDISPATCH = 26;
  MONO_MARSHAL_CONV_OBJECT_IUNKNOWN = 27;
  MONO_MARSHAL_CONV_OBJECT_STRUCT = 28;
  MONO_MARSHAL_CONV_DEL_FTN = 29;
  MONO_MARSHAL_CONV_FTN_DEL = 30;
  MONO_MARSHAL_FREE_ARRAY = 31;
  MONO_MARSHAL_CONV_BSTR_STR = 32;
  MONO_MARSHAL_CONV_SAFEHANDLE = 33;
  MONO_MARSHAL_CONV_HANDLEREF = 34;

type
  PMonoParseTypeMode = ^MonoParseTypeMode;
  MonoParseTypeMode =  Longint;
const
  MONO_PARSE_TYPE = 0;
  MONO_PARSE_MOD_TYPE = 1;
  MONO_PARSE_LOCAL = 2;
  MONO_PARSE_PARAM = 3;
  MONO_PARSE_RET = 4;
  MONO_PARSE_FIELD = 5;


type
  PMonoCallConvention  = ^MonoCallConvention;
  PMonoExceptionEnum  = ^MonoExceptionEnum;
  PMonoImage  = ^MonoImage;
  PMonoMarshalConv  = ^MonoMarshalConv;
  PMonoMarshalNative  = ^MonoMarshalNative;
  PMonoMarshalVariant  = ^MonoMarshalVariant;
  PMonoTableInfo  = ^MonoTableInfo;

const
  bm_MonoCustomMod_required = $1;
  bp_MonoCustomMod_required = 0;
  bm_MonoCustomMod_token = $FFFFFFFE;
  bp_MonoCustomMod_token = 1;

var
  mono_metadata_init : procedure;cdecl;
  mono_metadata_decode_row : procedure(t:PMonoTableInfo; idx:longint; res:Puint32_t; res_size:longint);cdecl;
  mono_metadata_decode_row_col : function(t:PMonoTableInfo; idx:longint; col:dword):uint32_t;cdecl;
  mono_metadata_compute_size : function(meta:PMonoImage; tableindex:longint; result_bitfield:Puint32_t):longint;cdecl;
  mono_metadata_locate : function(meta:PMonoImage; table:longint; idx:longint):Pchar;cdecl;
  mono_metadata_locate_token : function(meta:PMonoImage; token:uint32_t):Pchar;cdecl;
  mono_metadata_string_heap : function(meta:PMonoImage; table_index:uint32_t):Pchar;cdecl;
  mono_metadata_blob_heap : function(meta:PMonoImage; table_index:uint32_t):Pchar;cdecl;
  mono_metadata_user_string : function(meta:PMonoImage; table_index:uint32_t):Pchar;cdecl;
  mono_metadata_guid_heap : function(meta:PMonoImage; table_index:uint32_t):Pchar;cdecl;
  mono_metadata_typedef_from_field : function(meta:PMonoImage; table_index:uint32_t):uint32_t;cdecl;
  mono_metadata_typedef_from_method : function(meta:PMonoImage; table_index:uint32_t):uint32_t;cdecl;
  mono_metadata_nested_in_typedef : function(meta:PMonoImage; table_index:uint32_t):uint32_t;cdecl;
  mono_metadata_nesting_typedef : function(meta:PMonoImage; table_index:uint32_t; start_index:uint32_t):uint32_t;cdecl;
  mono_metadata_interfaces_from_typedef : function(meta:PMonoImage; table_index:uint32_t; count:Pdword):PPMonoClass;cdecl;
  mono_metadata_events_from_typedef : function(meta:PMonoImage; table_index:uint32_t; end_idx:Pdword):uint32_t;cdecl;
  mono_metadata_methods_from_event : function(meta:PMonoImage; table_index:uint32_t; pend:Pdword):uint32_t;cdecl;
  mono_metadata_properties_from_typedef : function(meta:PMonoImage; table_index:uint32_t; pend:Pdword):uint32_t;cdecl;
  mono_metadata_methods_from_property : function(meta:PMonoImage; table_index:uint32_t; pend:Pdword):uint32_t;cdecl;
  mono_metadata_packing_from_typedef : function(meta:PMonoImage; table_index:uint32_t; packing:Puint32_t; size:Puint32_t):uint32_t;cdecl;
  mono_metadata_get_marshal_info : function(meta:PMonoImage; idx:uint32_t; is_field:mono_bool):Pchar;cdecl;
  mono_metadata_custom_attrs_from_index : function(meta:PMonoImage; cattr_index:uint32_t):uint32_t;cdecl;
  mono_metadata_parse_marshal_spec : function(image:PMonoImage; ptr:Pchar):PMonoMarshalSpec;cdecl;
  mono_metadata_free_marshal_spec : procedure(spec:PMonoMarshalSpec);cdecl;
  mono_metadata_implmap_from_method : function(meta:PMonoImage; method_idx:uint32_t):uint32_t;cdecl;
  mono_metadata_field_info : procedure(meta:PMonoImage; table_index:uint32_t; offset:Puint32_t; rva:Puint32_t; marshal_spec:PPMonoMarshalSpec);cdecl;
  mono_metadata_get_constant_index : function(meta:PMonoImage; token:uint32_t; hint:uint32_t):uint32_t;cdecl;
  {
  * Functions to extract information from the Blobs
  }
  mono_metadata_decode_value : function(ptr:Pchar; rptr:PPchar):uint32_t;cdecl;
  mono_metadata_decode_signed_value : function(ptr:Pchar; rptr:PPchar):int32_t;cdecl;
  mono_metadata_decode_blob_size : function(ptr:Pchar; rptr:PPchar):uint32_t;cdecl;
  mono_metadata_encode_value : procedure(value:uint32_t; bug:Pchar; endbuf:PPchar);cdecl;
  mono_type_is_byref : function(_type:PMonoType):mono_bool;cdecl;
  mono_type_get_type : function(_type:PMonoType):longint;cdecl;
  { For MONO_TYPE_FNPTR  }
  mono_type_get_signature : function(_type:PMonoType):PMonoMethodSignature;cdecl;
  { For MONO_TYPE_CLASS, VALUETYPE  }
  mono_type_get_class : function(_type:PMonoType):PMonoClass;cdecl;
  mono_type_get_array_type : function(_type:PMonoType):PMonoArrayType;cdecl;
  { For MONO_TYPE_PTR  }
  mono_type_get_ptr_type : function(_type:PMonoType):PMonoType;cdecl;
  mono_type_get_modifiers : function(_type:PMonoType; is_required:Pmono_bool; iter:Ppointer):PMonoClass;cdecl;
  mono_type_is_struct : function(_type:PMonoType):mono_bool;cdecl;
  mono_type_is_void : function(_type:PMonoType):mono_bool;cdecl;
  mono_type_is_pointer : function(_type:PMonoType):mono_bool;cdecl;
  mono_type_is_reference : function(_type:PMonoType):mono_bool;cdecl;
  mono_signature_get_return_type : function(sig:PMonoMethodSignature):PMonoType;cdecl;
  mono_signature_get_params : function(sig:PMonoMethodSignature; iter:Ppointer):PMonoType;cdecl;
  mono_signature_get_param_count : function(sig:PMonoMethodSignature):uint32_t;cdecl;
  mono_signature_get_call_conv : function(sig:PMonoMethodSignature):uint32_t;cdecl;
  mono_signature_vararg_start : function(sig:PMonoMethodSignature):longint;cdecl;
  mono_signature_is_instance : function(sig:PMonoMethodSignature):mono_bool;cdecl;
  mono_signature_explicit_this : function(sig:PMonoMethodSignature):mono_bool;cdecl;
  mono_signature_param_is_out : function(sig:PMonoMethodSignature; param_num:longint):mono_bool;cdecl;
  mono_metadata_parse_typedef_or_ref : function(m:PMonoImage; ptr:Pchar; rptr:PPchar):uint32_t;cdecl;
  mono_metadata_parse_custom_mod : function(m:PMonoImage; dest:PMonoCustomMod; ptr:Pchar; rptr:PPchar):longint;cdecl;
  mono_metadata_parse_array : function(m:PMonoImage; ptr:Pchar; rptr:PPchar):PMonoArrayType;cdecl;
  mono_metadata_free_array : procedure(parray:PMonoArrayType);cdecl;
  mono_metadata_parse_type : function(m:PMonoImage; mode:MonoParseTypeMode; opt_attrs:smallint; ptr:Pchar; rptr:PPchar):PMonoType;cdecl;
  mono_metadata_parse_param : function(m:PMonoImage; ptr:Pchar; rptr:PPchar):PMonoType;cdecl;
  mono_metadata_parse_ret_type : function(m:PMonoImage; ptr:Pchar; rptr:PPchar):PMonoType;cdecl;
  mono_metadata_parse_field_type : function(m:PMonoImage; field_flags:smallint; ptr:Pchar; rptr:PPchar):PMonoType;cdecl;
  mono_type_create_from_typespec : function(image:PMonoImage; type_spec:uint32_t):PMonoType;cdecl;
  mono_metadata_free_type : procedure(_type:PMonoType);cdecl;
  mono_type_size : function(_type:PMonoType; alignment:Plongint):longint;cdecl;
  mono_type_stack_size : function(_type:PMonoType; alignment:Plongint):longint;cdecl;
  mono_type_generic_inst_is_valuetype : function(_type:PMonoType):mono_bool;cdecl;
  mono_metadata_generic_class_is_valuetype : function(gclass:PMonoGenericClass):mono_bool;cdecl;
  mono_metadata_generic_class_hash : function(gclass:PMonoGenericClass):dword;cdecl;
  mono_metadata_generic_class_equal : function(g1:PMonoGenericClass; g2:PMonoGenericClass):mono_bool;cdecl;
  mono_metadata_type_hash : function(t1:PMonoType):dword;cdecl;
  mono_metadata_type_equal : function(t1:PMonoType; t2:PMonoType):mono_bool;cdecl;
  mono_metadata_signature_alloc : function(image:PMonoImage; nparams:uint32_t):PMonoMethodSignature;cdecl;
  mono_metadata_signature_dup : function(sig:PMonoMethodSignature):PMonoMethodSignature;cdecl;
  mono_metadata_parse_signature : function(image:PMonoImage; token:uint32_t):PMonoMethodSignature;cdecl;
  mono_metadata_parse_method_signature : function(m:PMonoImage; def:longint; ptr:Pchar; rptr:PPchar):PMonoMethodSignature;cdecl;
  mono_metadata_free_method_signature : procedure(method:PMonoMethodSignature);cdecl;
  mono_metadata_signature_equal : function(sig1:PMonoMethodSignature; sig2:PMonoMethodSignature):mono_bool;cdecl;
  mono_signature_hash : function(sig:PMonoMethodSignature):dword;cdecl;
  mono_metadata_parse_mh : function(m:PMonoImage; ptr:Pchar):PMonoMethodHeader;cdecl;
  mono_metadata_free_mh : procedure(mh:PMonoMethodHeader);cdecl;
  mono_method_header_get_code : function(header:PMonoMethodHeader; code_size:Puint32_t; max_stack:Puint32_t):Pbyte;cdecl;
  mono_method_header_get_locals : function(header:PMonoMethodHeader; num_locals:Puint32_t; init_locals:Pmono_bool):PPMonoType;cdecl;
  mono_method_header_get_num_clauses : function(header:PMonoMethodHeader):longint;cdecl;
  mono_method_header_get_clauses : function(header:PMonoMethodHeader; method:PMonoMethod; iter:Ppointer; clause:PMonoExceptionClause):longint;cdecl;
  mono_type_to_unmanaged : function(_type:PMonoType; mspec:PMonoMarshalSpec; as_field:mono_bool; unicode:mono_bool; conv:PMonoMarshalConv):uint32_t;cdecl;
  mono_metadata_token_from_dor : function(dor_index:uint32_t):uint32_t;cdecl;
  mono_guid_to_string : function(guid:Puint8_t):Pchar;cdecl;
  mono_guid_to_string_minimal : function(guid:Puint8_t):Pchar;cdecl;
  mono_metadata_declsec_from_index : function(meta:PMonoImage; idx:uint32_t):uint32_t;cdecl;
  mono_metadata_translate_token_index : function(image:PMonoImage; table:longint; idx:uint32_t):uint32_t;cdecl;
  mono_metadata_decode_table_row : procedure(image:PMonoImage; table:longint; idx:longint; res:Puint32_t; res_size:longint);cdecl;
  mono_metadata_decode_table_row_col : function(image:PMonoImage; table:longint; idx:longint; col:dword):uint32_t;cdecl;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation

procedure free_procs;
begin
  mono_metadata_init:=nil;
  mono_metadata_decode_row:=nil;
  mono_metadata_decode_row_col:=nil;
  mono_metadata_compute_size:=nil;
  mono_metadata_locate:=nil;
  mono_metadata_locate_token:=nil;
  mono_metadata_string_heap:=nil;
  mono_metadata_blob_heap:=nil;
  mono_metadata_user_string:=nil;
  mono_metadata_guid_heap:=nil;
  mono_metadata_typedef_from_field:=nil;
  mono_metadata_typedef_from_method:=nil;
  mono_metadata_nested_in_typedef:=nil;
  mono_metadata_nesting_typedef:=nil;
  mono_metadata_interfaces_from_typedef:=nil;
  mono_metadata_events_from_typedef:=nil;
  mono_metadata_methods_from_event:=nil;
  mono_metadata_properties_from_typedef:=nil;
  mono_metadata_methods_from_property:=nil;
  mono_metadata_packing_from_typedef:=nil;
  mono_metadata_get_marshal_info:=nil;
  mono_metadata_custom_attrs_from_index:=nil;
  mono_metadata_parse_marshal_spec:=nil;
  mono_metadata_free_marshal_spec:=nil;
  mono_metadata_implmap_from_method:=nil;
  mono_metadata_field_info:=nil;
  mono_metadata_get_constant_index:=nil;
  mono_metadata_decode_value:=nil;
  mono_metadata_decode_signed_value:=nil;
  mono_metadata_decode_blob_size:=nil;
  mono_metadata_encode_value:=nil;
  mono_type_is_byref:=nil;
  mono_type_get_type:=nil;
  mono_type_get_signature:=nil;
  mono_type_get_class:=nil;
  mono_type_get_array_type:=nil;
  mono_type_get_ptr_type:=nil;
  mono_type_get_modifiers:=nil;
  mono_type_is_struct:=nil;
  mono_type_is_void:=nil;
  mono_type_is_pointer:=nil;
  mono_type_is_reference:=nil;
  mono_signature_get_return_type:=nil;
  mono_signature_get_params:=nil;
  mono_signature_get_param_count:=nil;
  mono_signature_get_call_conv:=nil;
  mono_signature_vararg_start:=nil;
  mono_signature_is_instance:=nil;
  mono_signature_explicit_this:=nil;
  mono_signature_param_is_out:=nil;
  mono_metadata_parse_typedef_or_ref:=nil;
  mono_metadata_parse_custom_mod:=nil;
  mono_metadata_parse_array:=nil;
  mono_metadata_free_array:=nil;
  mono_metadata_parse_type:=nil;
  mono_metadata_parse_param:=nil;
  mono_metadata_parse_ret_type:=nil;
  mono_metadata_parse_field_type:=nil;
  mono_type_create_from_typespec:=nil;
  mono_metadata_free_type:=nil;
  mono_type_size:=nil;
  mono_type_stack_size:=nil;
  mono_type_generic_inst_is_valuetype:=nil;
  mono_metadata_generic_class_is_valuetype:=nil;
  mono_metadata_generic_class_hash:=nil;
  mono_metadata_generic_class_equal:=nil;
  mono_metadata_type_hash:=nil;
  mono_metadata_type_equal:=nil;
  mono_metadata_signature_alloc:=nil;
  mono_metadata_signature_dup:=nil;
  mono_metadata_parse_signature:=nil;
  mono_metadata_parse_method_signature:=nil;
  mono_metadata_free_method_signature:=nil;
  mono_metadata_signature_equal:=nil;
  mono_signature_hash:=nil;
  mono_metadata_parse_mh:=nil;
  mono_metadata_free_mh:=nil;
  mono_method_header_get_code:=nil;
  mono_method_header_get_locals:=nil;
  mono_method_header_get_num_clauses:=nil;
  mono_method_header_get_clauses:=nil;
  mono_type_to_unmanaged:=nil;
  mono_metadata_token_from_dor:=nil;
  mono_guid_to_string:=nil;
  mono_guid_to_string_minimal:=nil;
  mono_metadata_declsec_from_index:=nil;
  mono_metadata_translate_token_index:=nil;
  mono_metadata_decode_table_row:=nil;
  mono_metadata_decode_table_row_col:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_metadata_init):=GetProcAddress(hlib,'mono_metadata_init');
  pointer(mono_metadata_decode_row):=GetProcAddress(hlib,'mono_metadata_decode_row');
  pointer(mono_metadata_decode_row_col):=GetProcAddress(hlib,'mono_metadata_decode_row_col');
  pointer(mono_metadata_compute_size):=GetProcAddress(hlib,'mono_metadata_compute_size');
  pointer(mono_metadata_locate):=GetProcAddress(hlib,'mono_metadata_locate');
  pointer(mono_metadata_locate_token):=GetProcAddress(hlib,'mono_metadata_locate_token');
  pointer(mono_metadata_string_heap):=GetProcAddress(hlib,'mono_metadata_string_heap');
  pointer(mono_metadata_blob_heap):=GetProcAddress(hlib,'mono_metadata_blob_heap');
  pointer(mono_metadata_user_string):=GetProcAddress(hlib,'mono_metadata_user_string');
  pointer(mono_metadata_guid_heap):=GetProcAddress(hlib,'mono_metadata_guid_heap');
  pointer(mono_metadata_typedef_from_field):=GetProcAddress(hlib,'mono_metadata_typedef_from_field');
  pointer(mono_metadata_typedef_from_method):=GetProcAddress(hlib,'mono_metadata_typedef_from_method');
  pointer(mono_metadata_nested_in_typedef):=GetProcAddress(hlib,'mono_metadata_nested_in_typedef');
  pointer(mono_metadata_nesting_typedef):=GetProcAddress(hlib,'mono_metadata_nesting_typedef');
  pointer(mono_metadata_interfaces_from_typedef):=GetProcAddress(hlib,'mono_metadata_interfaces_from_typedef');
  pointer(mono_metadata_events_from_typedef):=GetProcAddress(hlib,'mono_metadata_events_from_typedef');
  pointer(mono_metadata_methods_from_event):=GetProcAddress(hlib,'mono_metadata_methods_from_event');
  pointer(mono_metadata_properties_from_typedef):=GetProcAddress(hlib,'mono_metadata_properties_from_typedef');
  pointer(mono_metadata_methods_from_property):=GetProcAddress(hlib,'mono_metadata_methods_from_property');
  pointer(mono_metadata_packing_from_typedef):=GetProcAddress(hlib,'mono_metadata_packing_from_typedef');
  pointer(mono_metadata_get_marshal_info):=GetProcAddress(hlib,'mono_metadata_get_marshal_info');
  pointer(mono_metadata_custom_attrs_from_index):=GetProcAddress(hlib,'mono_metadata_custom_attrs_from_index');
  pointer(mono_metadata_parse_marshal_spec):=GetProcAddress(hlib,'mono_metadata_parse_marshal_spec');
  pointer(mono_metadata_free_marshal_spec):=GetProcAddress(hlib,'mono_metadata_free_marshal_spec');
  pointer(mono_metadata_implmap_from_method):=GetProcAddress(hlib,'mono_metadata_implmap_from_method');
  pointer(mono_metadata_field_info):=GetProcAddress(hlib,'mono_metadata_field_info');
  pointer(mono_metadata_get_constant_index):=GetProcAddress(hlib,'mono_metadata_get_constant_index');
  pointer(mono_metadata_decode_value):=GetProcAddress(hlib,'mono_metadata_decode_value');
  pointer(mono_metadata_decode_signed_value):=GetProcAddress(hlib,'mono_metadata_decode_signed_value');
  pointer(mono_metadata_decode_blob_size):=GetProcAddress(hlib,'mono_metadata_decode_blob_size');
  pointer(mono_metadata_encode_value):=GetProcAddress(hlib,'mono_metadata_encode_value');
  pointer(mono_type_is_byref):=GetProcAddress(hlib,'mono_type_is_byref');
  pointer(mono_type_get_type):=GetProcAddress(hlib,'mono_type_get_type');
  pointer(mono_type_get_signature):=GetProcAddress(hlib,'mono_type_get_signature');
  pointer(mono_type_get_class):=GetProcAddress(hlib,'mono_type_get_class');
  pointer(mono_type_get_array_type):=GetProcAddress(hlib,'mono_type_get_array_type');
  pointer(mono_type_get_ptr_type):=GetProcAddress(hlib,'mono_type_get_ptr_type');
  pointer(mono_type_get_modifiers):=GetProcAddress(hlib,'mono_type_get_modifiers');
  pointer(mono_type_is_struct):=GetProcAddress(hlib,'mono_type_is_struct');
  pointer(mono_type_is_void):=GetProcAddress(hlib,'mono_type_is_void');
  pointer(mono_type_is_pointer):=GetProcAddress(hlib,'mono_type_is_pointer');
  pointer(mono_type_is_reference):=GetProcAddress(hlib,'mono_type_is_reference');
  pointer(mono_signature_get_return_type):=GetProcAddress(hlib,'mono_signature_get_return_type');
  pointer(mono_signature_get_params):=GetProcAddress(hlib,'mono_signature_get_params');
  pointer(mono_signature_get_param_count):=GetProcAddress(hlib,'mono_signature_get_param_count');
  pointer(mono_signature_get_call_conv):=GetProcAddress(hlib,'mono_signature_get_call_conv');
  pointer(mono_signature_vararg_start):=GetProcAddress(hlib,'mono_signature_vararg_start');
  pointer(mono_signature_is_instance):=GetProcAddress(hlib,'mono_signature_is_instance');
  pointer(mono_signature_explicit_this):=GetProcAddress(hlib,'mono_signature_explicit_this');
  pointer(mono_signature_param_is_out):=GetProcAddress(hlib,'mono_signature_param_is_out');
  pointer(mono_metadata_parse_typedef_or_ref):=GetProcAddress(hlib,'mono_metadata_parse_typedef_or_ref');
  pointer(mono_metadata_parse_custom_mod):=GetProcAddress(hlib,'mono_metadata_parse_custom_mod');
  pointer(mono_metadata_parse_array):=GetProcAddress(hlib,'mono_metadata_parse_array');
  pointer(mono_metadata_free_array):=GetProcAddress(hlib,'mono_metadata_free_array');
  pointer(mono_metadata_parse_type):=GetProcAddress(hlib,'mono_metadata_parse_type');
  pointer(mono_metadata_parse_param):=GetProcAddress(hlib,'mono_metadata_parse_param');
  pointer(mono_metadata_parse_ret_type):=GetProcAddress(hlib,'mono_metadata_parse_ret_type');
  pointer(mono_metadata_parse_field_type):=GetProcAddress(hlib,'mono_metadata_parse_field_type');
  pointer(mono_type_create_from_typespec):=GetProcAddress(hlib,'mono_type_create_from_typespec');
  pointer(mono_metadata_free_type):=GetProcAddress(hlib,'mono_metadata_free_type');
  pointer(mono_type_size):=GetProcAddress(hlib,'mono_type_size');
  pointer(mono_type_stack_size):=GetProcAddress(hlib,'mono_type_stack_size');
  pointer(mono_type_generic_inst_is_valuetype):=GetProcAddress(hlib,'mono_type_generic_inst_is_valuetype');
  pointer(mono_metadata_generic_class_is_valuetype):=GetProcAddress(hlib,'mono_metadata_generic_class_is_valuetype');
  pointer(mono_metadata_generic_class_hash):=GetProcAddress(hlib,'mono_metadata_generic_class_hash');
  pointer(mono_metadata_generic_class_equal):=GetProcAddress(hlib,'mono_metadata_generic_class_equal');
  pointer(mono_metadata_type_hash):=GetProcAddress(hlib,'mono_metadata_type_hash');
  pointer(mono_metadata_type_equal):=GetProcAddress(hlib,'mono_metadata_type_equal');
  pointer(mono_metadata_signature_alloc):=GetProcAddress(hlib,'mono_metadata_signature_alloc');
  pointer(mono_metadata_signature_dup):=GetProcAddress(hlib,'mono_metadata_signature_dup');
  pointer(mono_metadata_parse_signature):=GetProcAddress(hlib,'mono_metadata_parse_signature');
  pointer(mono_metadata_parse_method_signature):=GetProcAddress(hlib,'mono_metadata_parse_method_signature');
  pointer(mono_metadata_free_method_signature):=GetProcAddress(hlib,'mono_metadata_free_method_signature');
  pointer(mono_metadata_signature_equal):=GetProcAddress(hlib,'mono_metadata_signature_equal');
  pointer(mono_signature_hash):=GetProcAddress(hlib,'mono_signature_hash');
  pointer(mono_metadata_parse_mh):=GetProcAddress(hlib,'mono_metadata_parse_mh');
  pointer(mono_metadata_free_mh):=GetProcAddress(hlib,'mono_metadata_free_mh');
  pointer(mono_method_header_get_code):=GetProcAddress(hlib,'mono_method_header_get_code');
  pointer(mono_method_header_get_locals):=GetProcAddress(hlib,'mono_method_header_get_locals');
  pointer(mono_method_header_get_num_clauses):=GetProcAddress(hlib,'mono_method_header_get_num_clauses');
  pointer(mono_method_header_get_clauses):=GetProcAddress(hlib,'mono_method_header_get_clauses');
  pointer(mono_type_to_unmanaged):=GetProcAddress(hlib,'mono_type_to_unmanaged');
  pointer(mono_metadata_token_from_dor):=GetProcAddress(hlib,'mono_metadata_token_from_dor');
  pointer(mono_guid_to_string):=GetProcAddress(hlib,'mono_guid_to_string');
  pointer(mono_guid_to_string_minimal):=GetProcAddress(hlib,'mono_guid_to_string_minimal');
  pointer(mono_metadata_declsec_from_index):=GetProcAddress(hlib,'mono_metadata_declsec_from_index');
  pointer(mono_metadata_translate_token_index):=GetProcAddress(hlib,'mono_metadata_translate_token_index');
  pointer(mono_metadata_decode_table_row):=GetProcAddress(hlib,'mono_metadata_decode_table_row');
  pointer(mono_metadata_decode_table_row_col):=GetProcAddress(hlib,'mono_metadata_decode_table_row_col');
end;

end.
