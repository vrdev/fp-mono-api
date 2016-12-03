{$mode objfpc} {$H+}
unit mono_publib;

interface

type
  PLongint  = ^Longint;
  PSmallInt = ^SmallInt;
  PByte     = ^Byte;
  PWord     = ^Word;
  PDWord    = ^DWord;
  PDouble   = ^Double;

type
  Pint16_t  = ^int16_t;
  Pint32_t  = ^int32_t;
  Pint64_t  = ^int64_t;
  Pint8_t  = ^int8_t;
  Pmono_bool  = ^mono_bool;
  Pmono_byte  = ^mono_byte;
  PPmono_byte  = ^Pmono_byte;
  Pmono_unichar2  = ^mono_unichar2;
  Pmono_unichar4  = ^mono_unichar4;
  Puint16_t  = ^uint16_t;
  Puint32_t  = ^uint32_t;
  Puint64_t  = ^uint64_t;
  Puint8_t  = ^uint8_t;
  Pintptr_t  = ^intptr_t;
  Puintptr_t  = ^uintptr_t;

  int8_t = shortint;
  uint8_t = byte;
  int16_t = smallint;
  uint16_t = word;
  int32_t = longint;
  uint32_t = dword;
  int64_t = int64;
  uint64_t = qword;
  intptr_t = pointer;
  uintptr_t = pointer;

  mono_bool = int32_t;
  mono_byte = uint8_t;
  mono_unichar2 = uint16_t;
  mono_uniChar4 = uint32_t;



type
  MonoFunc = procedure (data:pointer; user_data:pointer);cdecl;
  MonoHFunc = procedure (key:pointer; value:pointer; user_data:pointer);cdecl;

  PPGPtrArray = ^PGPtrArray;
  PGPtrArray = ^GPtrArray;
  GPtrArray = record
  end;

  PPGSList = ^PGSList;
  PGSList = ^GSList;
  GSList = record
  end;

var
  mono_free : procedure(_para1:pointer);cdecl;

const
  MONO_ZERO_LEN_ARRAY = 1;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation

procedure free_procs;
begin
  mono_free:=nil;
end;

procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_free):=GetProcAddress(hlib,'mono_free');
end;


end.
