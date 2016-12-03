{$mode objfpc}
unit mono_image;
interface

uses mono_publib;

type

  PMonoImage = ^MonoImage;
  MonoImage = record
  end;

  PMonoAssembly = ^MonoAssembly;
  MonoAssembly = record
  end;

  PMonoAssemblyName = ^MonoAssemblyName;
  MonoAssemblyName = record
  end;

  PMonoTableInfo = ^MonoTableInfo;
  MonoTableInfo = record
  end;

type
  PMonoImageOpenStatus = ^MonoImageOpenStatus;
  MonoImageOpenStatus = Longint;
const
  MONO_IMAGE_OK = 0;
  MONO_IMAGE_ERROR_ERRNO = 1;
  MONO_IMAGE_MISSING_ASSEMBLYREF = 2;
  MONO_IMAGE_IMAGE_INVALID = 3;

var
  mono_images_init : procedure;cdecl;
  mono_images_cleanup : procedure;cdecl;
  mono_image_open : function(fname:Pchar; status:PMonoImageOpenStatus):PMonoImage;cdecl;
  mono_image_open_full : function(fname:Pchar; status:PMonoImageOpenStatus; refonly:mono_bool):PMonoImage;cdecl;
  mono_pe_file_open : function(fname:Pchar; status:PMonoImageOpenStatus):PMonoImage;cdecl;
  mono_image_open_from_data : function(data:Pchar; data_len:uint32_t; need_copy:mono_bool; status:PMonoImageOpenStatus):PMonoImage;cdecl;
  mono_image_open_from_data_full : function(data:Pchar; data_len:uint32_t; need_copy:mono_bool; status:PMonoImageOpenStatus; refonly:mono_bool):PMonoImage;cdecl;
  mono_image_open_from_data_with_name : function(data:Pchar; data_len:uint32_t; need_copy:mono_bool; status:PMonoImageOpenStatus; refonly:mono_bool;
  name:Pchar):PMonoImage;cdecl;
  mono_image_fixup_vtable : procedure(image:PMonoImage);cdecl;
  mono_image_loaded : function(name:Pchar):PMonoImage;cdecl;
  mono_image_loaded_full : function(name:Pchar; refonly:mono_bool):PMonoImage;cdecl;
  mono_image_loaded_by_guid : function(guid:Pchar):PMonoImage;cdecl;
  mono_image_loaded_by_guid_full : function(guid:Pchar; refonly:mono_bool):PMonoImage;cdecl;
  mono_image_init : procedure(image:PMonoImage);cdecl;
  mono_image_close : procedure(image:PMonoImage);cdecl;
  mono_image_addref : procedure(image:PMonoImage);cdecl;
  mono_image_strerror : function(status:MonoImageOpenStatus):Pchar;cdecl;
  mono_image_ensure_section : function(image:PMonoImage; section:Pchar):longint;cdecl;
  mono_image_ensure_section_idx : function(image:PMonoImage; section:longint):longint;cdecl;
  mono_image_get_entry_point : function(image:PMonoImage):uint32_t;cdecl;
  mono_image_get_resource : function(image:PMonoImage; offset:uint32_t; size:Puint32_t):Pchar;cdecl;
  mono_image_load_file_for_image : function(image:PMonoImage; fileidx:longint):PMonoImage;cdecl;
  mono_image_load_module : function(image:PMonoImage; idx:longint):PMonoImage;cdecl;
  mono_image_get_name : function(image:PMonoImage):Pchar;cdecl;
  mono_image_get_filename : function(image:PMonoImage):Pchar;cdecl;
  mono_image_get_guid : function(image:PMonoImage):Pchar;cdecl;
  mono_image_get_assembly : function(image:PMonoImage):PMonoAssembly;cdecl;
  mono_image_is_dynamic : function(image:PMonoImage):mono_bool;cdecl;
  mono_image_rva_map : function(image:PMonoImage; rva:uint32_t):Pchar;cdecl;
  mono_image_get_table_info : function(image:PMonoImage; table_id:longint):PMonoTableInfo;cdecl;
  mono_image_get_table_rows : function(image:PMonoImage; table_id:longint):longint;cdecl;
  mono_table_info_get_rows : function(table:PMonoTableInfo):longint;cdecl;
  { This actually returns a MonoPEResourceDataEntry *, but declaring it
      * causes an include file loop. }
  mono_image_lookup_resource : function(image:PMonoImage; res_id:uint32_t; lang_id:uint32_t; name:Pmono_unichar2):pointer;cdecl;
  mono_image_get_public_key : function(image:PMonoImage; size:Puint32_t):Pchar;cdecl;
  mono_image_get_strong_name : function(image:PMonoImage; size:Puint32_t):Pchar;cdecl;
  mono_image_strong_name_position : function(image:PMonoImage; size:Puint32_t):uint32_t;cdecl;
  mono_image_add_to_name_cache : procedure(image:PMonoImage; nspace:Pchar; name:Pchar; idx:uint32_t);cdecl;
  mono_image_has_authenticode_entry : function(image:PMonoImage):mono_bool;cdecl;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation


procedure free_procs;
begin
  mono_images_init:=nil;
  mono_images_cleanup:=nil;
  mono_image_open:=nil;
  mono_image_open_full:=nil;
  mono_pe_file_open:=nil;
  mono_image_open_from_data:=nil;
  mono_image_open_from_data_full:=nil;
  mono_image_open_from_data_with_name:=nil;
  mono_image_fixup_vtable:=nil;
  mono_image_loaded:=nil;
  mono_image_loaded_full:=nil;
  mono_image_loaded_by_guid:=nil;
  mono_image_loaded_by_guid_full:=nil;
  mono_image_init:=nil;
  mono_image_close:=nil;
  mono_image_addref:=nil;
  mono_image_strerror:=nil;
  mono_image_ensure_section:=nil;
  mono_image_ensure_section_idx:=nil;
  mono_image_get_entry_point:=nil;
  mono_image_get_resource:=nil;
  mono_image_load_file_for_image:=nil;
  mono_image_load_module:=nil;
  mono_image_get_name:=nil;
  mono_image_get_filename:=nil;
  mono_image_get_guid:=nil;
  mono_image_get_assembly:=nil;
  mono_image_is_dynamic:=nil;
  mono_image_rva_map:=nil;
  mono_image_get_table_info:=nil;
  mono_image_get_table_rows:=nil;
  mono_table_info_get_rows:=nil;
  mono_image_lookup_resource:=nil;
  mono_image_get_public_key:=nil;
  mono_image_get_strong_name:=nil;
  mono_image_strong_name_position:=nil;
  mono_image_add_to_name_cache:=nil;
  mono_image_has_authenticode_entry:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_images_init):=GetProcAddress(hlib,'mono_images_init');
  pointer(mono_images_cleanup):=GetProcAddress(hlib,'mono_images_cleanup');
  pointer(mono_image_open):=GetProcAddress(hlib,'mono_image_open');
  pointer(mono_image_open_full):=GetProcAddress(hlib,'mono_image_open_full');
  pointer(mono_pe_file_open):=GetProcAddress(hlib,'mono_pe_file_open');
  pointer(mono_image_open_from_data):=GetProcAddress(hlib,'mono_image_open_from_data');
  pointer(mono_image_open_from_data_full):=GetProcAddress(hlib,'mono_image_open_from_data_full');
  pointer(mono_image_open_from_data_with_name):=GetProcAddress(hlib,'mono_image_open_from_data_with_name');
  pointer(mono_image_fixup_vtable):=GetProcAddress(hlib,'mono_image_fixup_vtable');
  pointer(mono_image_loaded):=GetProcAddress(hlib,'mono_image_loaded');
  pointer(mono_image_loaded_full):=GetProcAddress(hlib,'mono_image_loaded_full');
  pointer(mono_image_loaded_by_guid):=GetProcAddress(hlib,'mono_image_loaded_by_guid');
  pointer(mono_image_loaded_by_guid_full):=GetProcAddress(hlib,'mono_image_loaded_by_guid_full');
  pointer(mono_image_init):=GetProcAddress(hlib,'mono_image_init');
  pointer(mono_image_close):=GetProcAddress(hlib,'mono_image_close');
  pointer(mono_image_addref):=GetProcAddress(hlib,'mono_image_addref');
  pointer(mono_image_strerror):=GetProcAddress(hlib,'mono_image_strerror');
  pointer(mono_image_ensure_section):=GetProcAddress(hlib,'mono_image_ensure_section');
  pointer(mono_image_ensure_section_idx):=GetProcAddress(hlib,'mono_image_ensure_section_idx');
  pointer(mono_image_get_entry_point):=GetProcAddress(hlib,'mono_image_get_entry_point');
  pointer(mono_image_get_resource):=GetProcAddress(hlib,'mono_image_get_resource');
  pointer(mono_image_load_file_for_image):=GetProcAddress(hlib,'mono_image_load_file_for_image');
  pointer(mono_image_load_module):=GetProcAddress(hlib,'mono_image_load_module');
  pointer(mono_image_get_name):=GetProcAddress(hlib,'mono_image_get_name');
  pointer(mono_image_get_filename):=GetProcAddress(hlib,'mono_image_get_filename');
  pointer(mono_image_get_guid):=GetProcAddress(hlib,'mono_image_get_guid');
  pointer(mono_image_get_assembly):=GetProcAddress(hlib,'mono_image_get_assembly');
  pointer(mono_image_is_dynamic):=GetProcAddress(hlib,'mono_image_is_dynamic');
  pointer(mono_image_rva_map):=GetProcAddress(hlib,'mono_image_rva_map');
  pointer(mono_image_get_table_info):=GetProcAddress(hlib,'mono_image_get_table_info');
  pointer(mono_image_get_table_rows):=GetProcAddress(hlib,'mono_image_get_table_rows');
  pointer(mono_table_info_get_rows):=GetProcAddress(hlib,'mono_table_info_get_rows');
  pointer(mono_image_lookup_resource):=GetProcAddress(hlib,'mono_image_lookup_resource');
  pointer(mono_image_get_public_key):=GetProcAddress(hlib,'mono_image_get_public_key');
  pointer(mono_image_get_strong_name):=GetProcAddress(hlib,'mono_image_get_strong_name');
  pointer(mono_image_strong_name_position):=GetProcAddress(hlib,'mono_image_strong_name_position');
  pointer(mono_image_add_to_name_cache):=GetProcAddress(hlib,'mono_image_add_to_name_cache');
  pointer(mono_image_has_authenticode_entry):=GetProcAddress(hlib,'mono_image_has_authenticode_entry');
end;


end.
