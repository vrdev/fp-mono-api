{$mode objfpc}
unit mono_verify;

interface
uses
  mono_publib, mono_metadata;

type
  PMonoVerifyStatus = ^MonoVerifyStatus;
  MonoVerifyStatus =  Longint;
const
  MONO_VERIFY_OK = 0;
  MONO_VERIFY_ERROR = 1;
  MONO_VERIFY_WARNING = 2;
  MONO_VERIFY_CLS = 4;
  MONO_VERIFY_ALL = 7;
  { Status signaling code that is not verifiable. }
  MONO_VERIFY_NOT_VERIFIABLE = 8;
  { OR it with other flags }

  {
    Abort the verification if the code is not verifiable.
    The standard behavior is to abort if the code is not valid.
  }
  MONO_VERIFY_FAIL_FAST = 16;

  { Perform less verification of the code. This flag should be used
  * if one wants the verifier to be more compatible to the MS runtime.
  * Mind that this is not to be more compatible with MS peverify, but
  * with the runtime itself, that has a less strict verifier.
  }

  MONO_VERIFY_NON_STRICT = 32;
  {*Skip all visibility related checks*}
  MONO_VERIFY_SKIP_VISIBILITY = 64;
  {*Skip all visibility related checks*}
  MONO_VERIFY_REPORT_ALL_ERRORS = 128;


type
  PMonoVerifyInfo = ^MonoVerifyInfo;
  MonoVerifyInfo = record
    message : Pchar;
    status : MonoVerifyStatus;
  end;

  {should be one of MONO_EXCEPTION_*  }

  PMonoVerifyInfoExtended = ^MonoVerifyInfoExtended;
  MonoVerifyInfoExtended = record
    info : MonoVerifyInfo;
    exception_type : int8_t;
  end;

var
  mono_method_verify : function(method:PMonoMethod; level:longint):PGSList;
  mono_free_verify_list : procedure(list:PGSList);
  mono_verify_corlib : function:Pchar;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation

procedure free_procs;
begin
  mono_method_verify:=nil;
  mono_free_verify_list:=nil;
  mono_verify_corlib:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_method_verify):=GetProcAddress(hlib,'mono_method_verify');
  pointer(mono_free_verify_list):=GetProcAddress(hlib,'mono_free_verify_list');
  pointer(mono_verify_corlib):=GetProcAddress(hlib,'mono_verify_corlib');
end;


end.
