{$mode objfpc}
unit mono_debug;

interface
uses
  mono_publib, mono_metadata, mono_appdomain;

{
* This header is only installed for use by the debugger:
* the structures and the API declared here are not supported.
}

type

  PMonoDebugDataTable = ^MonoDebugDataTable;
  MonoDebugDataTable = record
  end;

  PMonoSymbolFile = ^MonoSymbolFile;
  MonoSymbolFile = record
  end;

  PMonoPPDBFile = ^MonoPPDBFile;
  MonoPPDBFile = record
  end;

  PMonoDebugLineNumberEntry = ^MonoDebugLineNumberEntry;
  MonoDebugLineNumberEntry = record
  end;

  PMonoDebugMethodAddress = ^MonoDebugMethodAddress;
  MonoDebugMethodAddress = record
  end;

  PMonoDebugClassEntry = ^MonoDebugClassEntry;
  MonoDebugClassEntry = record
  end;

  PMonoDebugMethodInfo = ^MonoDebugMethodInfo;
  MonoDebugMethodInfo = record
  end;

  PMonoDebugLocalsInfo = ^MonoDebugLocalsInfo;
  MonoDebugLocalsInfo = record
  end;

type
  PMonoDebugFormat = ^MonoDebugFormat;
  MonoDebugFormat =  Longint;
const
  MONO_DEBUG_FORMAT_NONE = 0;
  MONO_DEBUG_FORMAT_MONO = 1;
  MONO_DEBUG_FORMAT_DEBUGGER = 2;

{
* NOTE:
* We intentionally do not use GList here since the debugger needs to know about
* the layout of the fields.
}

type
  PMonoDebugList  = ^MonoDebugList;
  MonoDebugList = record
    next : PMonoDebugList;
    data : pointer;
  end;

  PMonoDebugHandle = ^MonoDebugHandle;
  MonoDebugHandle = record
      index : uint32_t;
      image_file : Pchar;
      image : PMonoImage;
      type_table : PMonoDebugDataTable;
      symfile : PMonoSymbolFile;
      ppdb : PMonoPPDBFile;
    end;

  PMonoSymbolTable = ^MonoSymbolTable;
  MonoSymbolTable = record
    magic : uint64_t;
    version : uint32_t;
    total_size : uint32_t;
    corlib : PMonoDebugHandle;
    global_data_table : PMonoDebugDataTable;
    data_tables : PMonoDebugList;
    symbol_files : PMonoDebugList;
  end;

  PMonoDebugVarInfo = ^MonoDebugVarInfo;
  MonoDebugVarInfo = record
    index : uint32_t;
    offset : uint32_t;
    size : uint32_t;
    begin_scope : uint32_t;
    end_scope : uint32_t;
    _type : PMonoType;
  end;

  PMonoDebugMethodJitInfo = ^MonoDebugMethodJitInfo;
  MonoDebugMethodJitInfo = record
    code_start : Pmono_byte;
    code_size : uint32_t;
    prologue_end : uint32_t;
    epilogue_begin : uint32_t;
    wrapper_addr : Pmono_byte;
    num_line_numbers : uint32_t;
    line_numbers : PMonoDebugLineNumberEntry;
    has_var_info : uint32_t;
    num_params : uint32_t;
    this_var : PMonoDebugVarInfo;
    params : PMonoDebugVarInfo;
    num_locals : uint32_t;
    locals : PMonoDebugVarInfo;
    gsharedvt_info_var : PMonoDebugVarInfo;
    gsharedvt_locals_var : PMonoDebugVarInfo;
  end;

  PMonoDebugSourceLocation = ^MonoDebugSourceLocation;
  MonoDebugSourceLocation = record
    source_file : Pchar;
    row : uint32_t;
    column : uint32_t;
    il_offset : uint32_t;
  end;

  PMonoDebugMethodAddressList = ^MonoDebugMethodAddressList;
  MonoDebugMethodAddressList = record
    size : uint32_t;
    count : uint32_t;
    data : array[0..(MONO_ZERO_LEN_ARRAY)-1] of mono_byte;
  end;
  var
    mono_debug_enabled : function:mono_bool;

{
* These bits of the MonoDebugLocalInfo's "index" field are flags specifying
* where the variable is actually stored.
*
* See relocate_variable() in debug-symfile.c for more info.
}

const
  MONO_DEBUG_VAR_ADDRESS_MODE_FLAGS = $f0000000;
  { The variable is in register "index".  }
  MONO_DEBUG_VAR_ADDRESS_MODE_REGISTER = 0;
  { The variable is at offset "offset" from register "index".  }
  MONO_DEBUG_VAR_ADDRESS_MODE_REGOFFSET = $10000000;
  { The variable is in the two registers "offset" and "index".  }
  MONO_DEBUG_VAR_ADDRESS_MODE_TWO_REGISTERS = $20000000;
  { The variable is dead.  }
  MONO_DEBUG_VAR_ADDRESS_MODE_DEAD = $30000000;
  { Same as REGOFFSET, but do an indirection  }
  MONO_DEBUG_VAR_ADDRESS_MODE_REGOFFSET_INDIR = $40000000;
  { gsharedvt local  }
  MONO_DEBUG_VAR_ADDRESS_MODE_GSHAREDVT_LOCAL = $50000000;
  { variable is a vt address  }
  MONO_DEBUG_VAR_ADDRESS_MODE_VTADDR = $60000000;

const
  MONO_DEBUGGER_MAJOR_VERSION = 81;
  MONO_DEBUGGER_MINOR_VERSION = 6;
  MONO_DEBUGGER_MAGIC = $7aff65af4253d427;

var
  mono_debug_init : procedure(format:MonoDebugFormat);
  mono_debug_open_image_from_memory : procedure(image:PMonoImage; raw_contents:Pmono_byte; size:longint);
  mono_debug_cleanup : procedure;
  mono_debug_close_image : procedure(image:PMonoImage);
  mono_debug_domain_unload : procedure(domain:PMonoDomain);
  mono_debug_domain_create : procedure(domain:PMonoDomain);
  mono_debug_add_method : function(method:PMonoMethod; jit:PMonoDebugMethodJitInfo; domain:PMonoDomain):PMonoDebugMethodAddress;
  mono_debug_remove_method : procedure(method:PMonoMethod; domain:PMonoDomain);
  mono_debug_lookup_method : function(method:PMonoMethod):PMonoDebugMethodInfo;
  mono_debug_lookup_method_addresses : function(method:PMonoMethod):PMonoDebugMethodAddressList;
  mono_debug_find_method : function(method:PMonoMethod; domain:PMonoDomain):PMonoDebugMethodJitInfo;
  mono_debug_free_method_jit_info : procedure(jit:PMonoDebugMethodJitInfo);
  mono_debug_add_delegate_trampoline : procedure(code:pointer; size:longint);
  mono_debug_lookup_locals : function(method:PMonoMethod):PMonoDebugLocalsInfo;
  mono_debug_method_lookup_location : function(minfo:PMonoDebugMethodInfo; il_offset:longint):PMonoDebugSourceLocation;
  {
  * Line number support.
  }
  mono_debug_lookup_source_location : function(method:PMonoMethod; address:uint32_t; domain:PMonoDomain):PMonoDebugSourceLocation;
  mono_debug_il_offset_from_address : function(method:PMonoMethod; domain:PMonoDomain; native_offset:uint32_t):int32_t;
  mono_debug_free_source_location : procedure(location:PMonoDebugSourceLocation);
  mono_debug_print_stack_frame : function(method:PMonoMethod; native_offset:uint32_t; domain:PMonoDomain):Pchar;
  {
  * Mono Debugger support functions
  * These methods are used by the JIT while running inside the Mono Debugger.
  }
  mono_debugger_method_has_breakpoint : function(method:PMonoMethod):longint;
  mono_debugger_insert_breakpoint : function(method_name:Pchar; include_namespace:mono_bool):longint;
  mono_set_is_debugger_attached : procedure(attached:mono_bool);
  mono_is_debugger_attached : function:mono_bool;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
  
implementation

procedure free_procs;
begin
  mono_debug_enabled:=nil;
  mono_debug_init:=nil;
  mono_debug_open_image_from_memory:=nil;
  mono_debug_cleanup:=nil;
  mono_debug_close_image:=nil;
  mono_debug_domain_unload:=nil;
  mono_debug_domain_create:=nil;
  mono_debug_add_method:=nil;
  mono_debug_remove_method:=nil;
  mono_debug_lookup_method:=nil;
  mono_debug_lookup_method_addresses:=nil;
  mono_debug_find_method:=nil;
  mono_debug_free_method_jit_info:=nil;
  mono_debug_add_delegate_trampoline:=nil;
  mono_debug_lookup_locals:=nil;
  mono_debug_method_lookup_location:=nil;
  mono_debug_lookup_source_location:=nil;
  mono_debug_il_offset_from_address:=nil;
  mono_debug_free_source_location:=nil;
  mono_debug_print_stack_frame:=nil;
  mono_debugger_method_has_breakpoint:=nil;
  mono_debugger_insert_breakpoint:=nil;
  mono_set_is_debugger_attached:=nil;
  mono_is_debugger_attached:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_debug_enabled):=GetProcAddress(hlib,'mono_debug_enabled');
  pointer(mono_debug_init):=GetProcAddress(hlib,'mono_debug_init');
  pointer(mono_debug_open_image_from_memory):=GetProcAddress(hlib,'mono_debug_open_image_from_memory');
  pointer(mono_debug_cleanup):=GetProcAddress(hlib,'mono_debug_cleanup');
  pointer(mono_debug_close_image):=GetProcAddress(hlib,'mono_debug_close_image');
  pointer(mono_debug_domain_unload):=GetProcAddress(hlib,'mono_debug_domain_unload');
  pointer(mono_debug_domain_create):=GetProcAddress(hlib,'mono_debug_domain_create');
  pointer(mono_debug_add_method):=GetProcAddress(hlib,'mono_debug_add_method');
  pointer(mono_debug_remove_method):=GetProcAddress(hlib,'mono_debug_remove_method');
  pointer(mono_debug_lookup_method):=GetProcAddress(hlib,'mono_debug_lookup_method');
  pointer(mono_debug_lookup_method_addresses):=GetProcAddress(hlib,'mono_debug_lookup_method_addresses');
  pointer(mono_debug_find_method):=GetProcAddress(hlib,'mono_debug_find_method');
  pointer(mono_debug_free_method_jit_info):=GetProcAddress(hlib,'mono_debug_free_method_jit_info');
  pointer(mono_debug_add_delegate_trampoline):=GetProcAddress(hlib,'mono_debug_add_delegate_trampoline');
  pointer(mono_debug_lookup_locals):=GetProcAddress(hlib,'mono_debug_lookup_locals');
  pointer(mono_debug_method_lookup_location):=GetProcAddress(hlib,'mono_debug_method_lookup_location');
  pointer(mono_debug_lookup_source_location):=GetProcAddress(hlib,'mono_debug_lookup_source_location');
  pointer(mono_debug_il_offset_from_address):=GetProcAddress(hlib,'mono_debug_il_offset_from_address');
  pointer(mono_debug_free_source_location):=GetProcAddress(hlib,'mono_debug_free_source_location');
  pointer(mono_debug_print_stack_frame):=GetProcAddress(hlib,'mono_debug_print_stack_frame');
  pointer(mono_debugger_method_has_breakpoint):=GetProcAddress(hlib,'mono_debugger_method_has_breakpoint');
  pointer(mono_debugger_insert_breakpoint):=GetProcAddress(hlib,'mono_debugger_insert_breakpoint');
  pointer(mono_set_is_debugger_attached):=GetProcAddress(hlib,'mono_set_is_debugger_attached');
  pointer(mono_is_debugger_attached):=GetProcAddress(hlib,'mono_is_debugger_attached');
end;

end.
