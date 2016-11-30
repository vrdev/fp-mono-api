{
* This header is only installed for use by the debugger:
* the structures and the API declared here are not supported.
* Copyright 2012 Xamarin Inc (http://www.xamarin.com)
* Licensed under the MIT license. See LICENSE file in the project root for full license information.
}

{$mode objfpc}
unit mono_debug_symfile;
interface
uses
  mono_publib, mono_debug, mono_metadata;


type
  { Keep in sync with OffsetTable in mcs/class/Mono.CSharp.Debugger/MonoSymbolTable.cs  }
  PMonoSymbolFileOffsetTable = ^MonoSymbolFileOffsetTable;
  MonoSymbolFileOffsetTable = record
    _total_file_size : uint32_t;
    _data_section_offset : uint32_t;
    _data_section_size : uint32_t;
    _compile_unit_count : uint32_t;
    _compile_unit_table_offset : uint32_t;
    _compile_unit_table_size : uint32_t;
    _source_count : uint32_t;
    _source_table_offset : uint32_t;
    _source_table_size : uint32_t;
    _method_count : uint32_t;
    _method_table_offset : uint32_t;
    _method_table_size : uint32_t;
    _type_count : uint32_t;
    _anonymous_scope_count : uint32_t;
    _anonymous_scope_table_offset : uint32_t;
    _anonymous_scope_table_size : uint32_t;
    _line_number_table_line_base : uint32_t;
    _line_number_table_line_range : uint32_t;
    _line_number_table_opcode_base : uint32_t;
    _is_aspx_source : uint32_t;
  end;

  PMonoSymbolFileSourceEntry = ^MonoSymbolFileSourceEntry;
  MonoSymbolFileSourceEntry = record
    _index : uint32_t;
    _data_offset : uint32_t;
  end;

  PMonoSymbolFileMethodEntry = ^MonoSymbolFileMethodEntry;
  MonoSymbolFileMethodEntry = record
    _token : uint32_t;
    _data_offset : uint32_t;
    _line_number_table : uint32_t;
  end;

  PMonoSymbolFileMethodAddress = ^MonoSymbolFileMethodAddress;
  MonoSymbolFileMethodAddress = record
    size : uint32_t;
    start_address : Puint8_t;
    end_address : Puint8_t;
    method_start_address : Puint8_t;
    method_end_address : Puint8_t;
    wrapper_address : Puint8_t;
    has_this : uint32_t;
    num_params : uint32_t;
    variable_table_offset : uint32_t;
    type_table_offset : uint32_t;
    num_line_numbers : uint32_t;
    line_number_offset : uint32_t;
    data : array[0..(MONO_ZERO_LEN_ARRAY)-1] of uint8_t;
  end;

  PMonoDebugMethodInfo = ^MonoDebugMethodInfo;
  MonoDebugMethodInfo = record
    method : PMonoMethod;
    handle : PMonoDebugHandle;
    index : uint32_t;
    data_offset : uint32_t;
    lnt_offset : uint32_t;
  end;

  { IL offsets  }

  PMonoDebugCodeBlock = ^MonoDebugCodeBlock;
  MonoDebugCodeBlock = record
    parent : longint;
    _type : longint;
    start_offset : longint;
    end_offset : longint;
  end;
  { Might be null for the main scope  }

  PMonoDebugLocalVar = ^MonoDebugLocalVar;
  MonoDebugLocalVar = record
    name : Pchar;
    index : longint;
    block : PMonoDebugCodeBlock;
  end;
  {
  * Information about local variables retrieved from a symbol file.
  }
  PMonoDebugLocalsInfo = ^MonoDebugLocalsInfo;
  MonoDebugLocalsInfo = record
    num_locals : longint;
    locals : PMonoDebugLocalVar;
    num_blocks : longint;
    code_blocks : PMonoDebugCodeBlock;
  end;

  PMonoDebugLineNumberEntry = ^MonoDebugLineNumberEntry;
  MonoDebugLineNumberEntry = record
    il_offset : uint32_t;
    native_offset : uint32_t;
  end;

  {
  * Information about a source file retrieved from a symbol file.
  }
  { 16 byte long  }

  PMonoDebugSourceInfo = ^MonoDebugSourceInfo;
  MonoDebugSourceInfo = record
    source_file : Pchar;
    guid : Pchar;
    hash : PChar;
  end;

  PPMonoSymSeqPoint = ^PMonoSymSeqPoint;
  PMonoSymSeqPoint = ^MonoSymSeqPoint;
  MonoSymSeqPoint = record
    il_offset : longint;
    line : longint;
    column : longint;
    end_line : longint;
    end_column : longint;
  end;

const
  MONO_SYMBOL_FILE_MAJOR_VERSION = 50;
  MONO_SYMBOL_FILE_MINOR_VERSION = 0;
  MONO_SYMBOL_FILE_MAGIC = $45e82623fd7fa614;


var
  mono_debug_open_mono_symbols : function(handle:PMonoDebugHandle; raw_contents:Puint8_t; size:longint; in_the_debugger:mono_bool):PMonoSymbolFile;
  mono_debug_close_mono_symbol_file : procedure(symfile:PMonoSymbolFile);
  mono_debug_symfile_is_loaded : function(symfile:PMonoSymbolFile):mono_bool;
  mono_debug_symfile_lookup_location : function(minfo:PMonoDebugMethodInfo; offset:uint32_t):PMonoDebugSourceLocation;
  mono_debug_symfile_free_location : procedure(location:PMonoDebugSourceLocation);
  mono_debug_symfile_lookup_method : function(handle:PMonoDebugHandle; method:PMonoMethod):PMonoDebugMethodInfo;
  mono_debug_symfile_lookup_locals : function(minfo:PMonoDebugMethodInfo):PMonoDebugLocalsInfo;
  mono_debug_symfile_get_seq_points : procedure(minfo:PMonoDebugMethodInfo; source_file:PPchar; source_file_list:PPGPtrArray; source_files:PPlongint; seq_points:PPMonoSymSeqPoint;
    n_seq_points:Plongint);
  mono_debug_image_has_debug_info : function(image:PMonoImage):mono_bool;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
  
implementation

procedure free_procs;
begin
  mono_debug_open_mono_symbols:=nil;
  mono_debug_close_mono_symbol_file:=nil;
  mono_debug_symfile_is_loaded:=nil;
  mono_debug_symfile_lookup_location:=nil;
  mono_debug_symfile_free_location:=nil;
  mono_debug_symfile_lookup_method:=nil;
  mono_debug_symfile_lookup_locals:=nil;
  mono_debug_symfile_get_seq_points:=nil;
  mono_debug_image_has_debug_info:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_debug_open_mono_symbols):=GetProcAddress(hlib,'mono_debug_open_mono_symbols');
  pointer(mono_debug_close_mono_symbol_file):=GetProcAddress(hlib,'mono_debug_close_mono_symbol_file');
  pointer(mono_debug_symfile_is_loaded):=GetProcAddress(hlib,'mono_debug_symfile_is_loaded');
  pointer(mono_debug_symfile_lookup_location):=GetProcAddress(hlib,'mono_debug_symfile_lookup_location');
  pointer(mono_debug_symfile_free_location):=GetProcAddress(hlib,'mono_debug_symfile_free_location');
  pointer(mono_debug_symfile_lookup_method):=GetProcAddress(hlib,'mono_debug_symfile_lookup_method');
  pointer(mono_debug_symfile_lookup_locals):=GetProcAddress(hlib,'mono_debug_symfile_lookup_locals');
  pointer(mono_debug_symfile_get_seq_points):=GetProcAddress(hlib,'mono_debug_symfile_get_seq_points');
  pointer(mono_debug_image_has_debug_info):=GetProcAddress(hlib,'mono_debug_image_has_debug_info');
end;


end.
