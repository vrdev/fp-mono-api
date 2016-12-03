{
* opcodes.h: CIL instruction information
*
* Author:
*   Paolo Molaro (lupus@ximian.com)
*
* (C) 2002 Ximian, Inc.
}

{$mode objfpc}
unit mono_opcodes;

interface
uses
  mono_publib;

const
  MONO_CUSTOM_PREFIX = $f0;

type
  PMonoOpcodeEnum = ^MonoOpcodeEnum;
  MonoOpcodeEnum = (
    {$include mono_opcodes.inc}
    MONO_CEE_LAST
  );

type
  MonoFlow =  Longint;
const
  MONO_FLOW_NEXT = 0;
  MONO_FLOW_BRANCH = 1;
  MONO_FLOW_COND_BRANCH = 2;
  MONO_FLOW_ERROR = 3;
  MONO_FLOW_CALL = 4;
  MONO_FLOW_RETURN = 5;
  MONO_FLOW_META = 6;


type
  MonoInline =  Longint;
const
  MonoInlineNone = 0;
  MonoInlineType = 1;
  MonoInlineField = 2;
  MonoInlineMethod = 3;
  MonoInlineTok = 4;
  MonoInlineString = 5;
  MonoInlineSig = 6;
  MonoInlineVar = 7;
  MonoShortInlineVar = 8;
  MonoInlineBrTarget = 9;
  MonoShortInlineBrTarget = 10;
  MonoInlineSwitch = 11;
  MonoInlineR = 12;
  MonoShortInlineR = 13;
  MonoInlineI = 14;
  MonoShortInlineI = 15;
  MonoInlineI8 = 16;


type

  PMonoOpcode = ^MonoOpcode;
  MonoOpcode = record
    argument : byte;
    flow_type : byte;
    opval : word;
  end;

var
  mono_opcode_name : function(opcode:longint):Pchar;cdecl;
  mono_opcode_value : function(ip:PPmono_byte; pend:Pmono_byte):MonoOpcodeEnum;cdecl;

  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
  
implementation


procedure free_procs;
begin
  mono_opcode_name:=nil;
  mono_opcode_value:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_opcode_name):=GetProcAddress(hlib,'mono_opcode_name');
  pointer(mono_opcode_value):=GetProcAddress(hlib,'mono_opcode_value');
end;

end.
