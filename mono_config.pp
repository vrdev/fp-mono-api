{*
 * mono-config.h
 *
 * Author: Paolo Molaro (lupus@ximian.com)
 *
 * (C) 2002 Ximian, Inc.
 *}

{$mode objfpc}
unit mono_config;

interface
uses
  mono_publib, mono_image;

var
  mono_config_get_os : function:Pchar;cdecl;
  mono_config_get_cpu : function:Pchar;cdecl;
  mono_config_get_wordsize : function:Pchar;cdecl;
  mono_get_config_dir : function:Pchar;cdecl;
  mono_set_config_dir : procedure(dir:Pchar);cdecl;
  mono_get_machine_config : function:Pchar;cdecl;
  mono_config_cleanup : procedure;cdecl;
  mono_config_parse : procedure(filename:Pchar);cdecl;
  mono_config_for_assembly : procedure(assembly:PMonoImage);cdecl;
  mono_config_parse_memory : procedure(buffer:Pchar);cdecl;
  mono_config_string_for_assembly_file : function(filename:Pchar):Pchar;cdecl;
  mono_config_set_server_mode : procedure(server_mode:mono_bool);cdecl;
  mono_config_is_server_mode : function:mono_bool;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
  
implementation

procedure free_procs;
begin
  mono_config_get_os:=nil;
  mono_config_get_cpu:=nil;
  mono_config_get_wordsize:=nil;
  mono_get_config_dir:=nil;
  mono_set_config_dir:=nil;
  mono_get_machine_config:=nil;
  mono_config_cleanup:=nil;
  mono_config_parse:=nil;
  mono_config_for_assembly:=nil;
  mono_config_parse_memory:=nil;
  mono_config_string_for_assembly_file:=nil;
  mono_config_set_server_mode:=nil;
  mono_config_is_server_mode:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_config_get_os):=GetProcAddress(hlib,'mono_config_get_os');
  pointer(mono_config_get_cpu):=GetProcAddress(hlib,'mono_config_get_cpu');
  pointer(mono_config_get_wordsize):=GetProcAddress(hlib,'mono_config_get_wordsize');
  pointer(mono_get_config_dir):=GetProcAddress(hlib,'mono_get_config_dir');
  pointer(mono_set_config_dir):=GetProcAddress(hlib,'mono_set_config_dir');
  pointer(mono_get_machine_config):=GetProcAddress(hlib,'mono_get_machine_config');
  pointer(mono_config_cleanup):=GetProcAddress(hlib,'mono_config_cleanup');
  pointer(mono_config_parse):=GetProcAddress(hlib,'mono_config_parse');
  pointer(mono_config_for_assembly):=GetProcAddress(hlib,'mono_config_for_assembly');
  pointer(mono_config_parse_memory):=GetProcAddress(hlib,'mono_config_parse_memory');
  pointer(mono_config_string_for_assembly_file):=GetProcAddress(hlib,'mono_config_string_for_assembly_file');
  pointer(mono_config_set_server_mode):=GetProcAddress(hlib,'mono_config_set_server_mode');
  pointer(mono_config_is_server_mode):=GetProcAddress(hlib,'mono_config_is_server_mode');
end;


end.
