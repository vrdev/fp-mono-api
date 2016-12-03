{$mode objfpc}
unit mono_assembly;

interface
uses
  mono_publib, mono_image;

type
  PMonoAssembly  = ^MonoAssembly;
  PMonoAssemblyName  = ^MonoAssemblyName;

  PMonoImage  = ^MonoImage;
  PMonoImageOpenStatus  = ^MonoImageOpenStatus;

  PPMonoBundledAssembly = ^PMonoBundledAssembly;
  PMonoBundledAssembly  = ^MonoBundledAssembly;
  MonoBundledAssembly = record
    name : Pchar;
    data : Pbyte;
    size : dword;
  end;


  MonoAssemblyLoadFunc = procedure (assembly:PMonoAssembly; user_data:pointer);cdecl;

  PMonoAssemblySearchFunc  = ^MonoAssemblySearchFunc;
  MonoAssemblySearchFunc = function (aname:PMonoAssemblyName; user_data:pointer):PMonoAssembly;cdecl;

  PMonoAssemblyPreLoadFunc  = ^MonoAssemblyPreLoadFunc;
  MonoAssemblyPreLoadFunc = function (aname:PMonoAssemblyName; assemblies_path:PPchar; user_data:pointer):PMonoAssembly;cdecl;

var
  mono_assemblies_init : procedure;cdecl;
  mono_assemblies_cleanup : procedure;cdecl;
  mono_assembly_open : function(filename:Pchar; status:PMonoImageOpenStatus):PMonoAssembly;cdecl;
  mono_assembly_open_full : function(filename:Pchar; status:PMonoImageOpenStatus; refonly:mono_bool):PMonoAssembly;cdecl;
  mono_assembly_load : function(aname:PMonoAssemblyName; basedir:Pchar; status:PMonoImageOpenStatus):PMonoAssembly;cdecl;
  mono_assembly_load_full : function(aname:PMonoAssemblyName; basedir:Pchar; status:PMonoImageOpenStatus; refonly:mono_bool):PMonoAssembly;cdecl;
  mono_assembly_load_from : function(image:PMonoImage; fname:Pchar; status:PMonoImageOpenStatus):PMonoAssembly;cdecl;
  mono_assembly_load_from_full : function(image:PMonoImage; fname:Pchar; status:PMonoImageOpenStatus; refonly:mono_bool):PMonoAssembly;cdecl;
  mono_assembly_load_with_partial_name : function(name:Pchar; status:PMonoImageOpenStatus):PMonoAssembly;cdecl;
  mono_assembly_loaded : function(aname:PMonoAssemblyName):PMonoAssembly;cdecl;
  mono_assembly_loaded_full : function(aname:PMonoAssemblyName; refonly:mono_bool):PMonoAssembly;cdecl;
  mono_assembly_get_assemblyref : procedure(image:PMonoImage; index:longint; aname:PMonoAssemblyName);cdecl;
  mono_assembly_load_reference : procedure(image:PMonoImage; index:longint);cdecl;
  mono_assembly_load_references : procedure(image:PMonoImage; status:PMonoImageOpenStatus);cdecl;
  mono_assembly_load_module : function(assembly:PMonoAssembly; idx:uint32_t):PMonoImage;cdecl;
  mono_assembly_close : procedure(assembly:PMonoAssembly);cdecl;
  mono_assembly_setrootdir : procedure(root_dir:Pchar);cdecl;
  mono_assembly_getrootdir : function:Pchar;cdecl;
  mono_assembly_foreach : procedure(func:MonoFunc; user_data:pointer);cdecl;
  mono_assembly_set_main : procedure(assembly:PMonoAssembly);cdecl;
  mono_assembly_get_main : function:PMonoAssembly;cdecl;
  mono_assembly_get_image : function(assembly:PMonoAssembly):PMonoImage;cdecl;
  mono_assembly_get_name : function(assembly:PMonoAssembly):PMonoAssemblyName;cdecl;
  mono_assembly_fill_assembly_name : function(image:PMonoImage; aname:PMonoAssemblyName):mono_bool;cdecl;
  mono_assembly_names_equal : function(l:PMonoAssemblyName; r:PMonoAssemblyName):mono_bool;cdecl;
  mono_stringify_assembly_name : function(aname:PMonoAssemblyName):Pchar;cdecl;
  { Installs a function which is called each time a new assembly is loaded.  }

var
  mono_install_assembly_load_hook : procedure(func:MonoAssemblyLoadFunc; user_data:pointer);cdecl;
  {
  * Installs a new function which is used to search the list of loaded
  * assemblies for a given assembly name.
  }

var
  mono_install_assembly_search_hook : procedure(func:MonoAssemblySearchFunc; user_data:pointer);cdecl;
  mono_install_assembly_refonly_search_hook : procedure(func:MonoAssemblySearchFunc; user_data:pointer);cdecl;
  mono_assembly_invoke_search_hook : function(aname:PMonoAssemblyName):PMonoAssembly;cdecl;
  {
  * Installs a new search function which is used as a last resort when loading
  * an assembly fails. This could invoke AssemblyResolve events.
  }
  mono_install_assembly_postload_search_hook : procedure(func:MonoAssemblySearchFunc; user_data:pointer);cdecl;
  mono_install_assembly_postload_refonly_search_hook : procedure(func:MonoAssemblySearchFunc; user_data:pointer);cdecl;
  { Installs a function which is called before a new assembly is loaded
  * The hook are invoked from last hooked to first. If any of them returns
  * a non-null value, that will be the value returned in mono_assembly_load  }

var
  mono_install_assembly_preload_hook : procedure(func:MonoAssemblyPreLoadFunc; user_data:pointer);cdecl;
  mono_install_assembly_refonly_preload_hook : procedure(func:MonoAssemblyPreLoadFunc; user_data:pointer);cdecl;
  mono_assembly_invoke_load_hook : procedure(ass:PMonoAssembly);cdecl;
  mono_assembly_name_new : function(name:Pchar):PMonoAssemblyName;cdecl;
  mono_assembly_name_get_name : function(aname:PMonoAssemblyName):Pchar;cdecl;
  mono_assembly_name_get_culture : function(aname:PMonoAssemblyName):Pchar;cdecl;
  mono_assembly_name_get_version : function(aname:PMonoAssemblyName; minor:Puint16_t; build:Puint16_t; revision:Puint16_t):uint16_t;cdecl;
  mono_assembly_name_get_pubkeytoken : function(aname:PMonoAssemblyName):Pmono_byte;cdecl;
  mono_assembly_name_free : procedure(aname:PMonoAssemblyName);cdecl;

var
  mono_register_bundled_assemblies : procedure(assemblies:PPMonoBundledAssembly);cdecl;
  mono_register_config_for_assembly : procedure(assembly_name:Pchar; config_xml:Pchar);cdecl;
  mono_register_symfile_for_assembly : procedure(assembly_name:Pchar; raw_contents:Pmono_byte; size:longint);cdecl;
  mono_register_machine_config : procedure(config_xml:Pchar);cdecl;
  mono_set_rootdir : procedure;cdecl;
  mono_set_dirs : procedure(assembly_dir:Pchar; config_dir:Pchar);cdecl;
  mono_set_assemblies_path : procedure(path:Pchar);cdecl;
  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation

procedure free_procs;
begin
  mono_assemblies_init:=nil;
  mono_assemblies_cleanup:=nil;
  mono_assembly_open:=nil;
  mono_assembly_open_full:=nil;
  mono_assembly_load:=nil;
  mono_assembly_load_full:=nil;
  mono_assembly_load_from:=nil;
  mono_assembly_load_from_full:=nil;
  mono_assembly_load_with_partial_name:=nil;
  mono_assembly_loaded:=nil;
  mono_assembly_loaded_full:=nil;
  mono_assembly_get_assemblyref:=nil;
  mono_assembly_load_reference:=nil;
  mono_assembly_load_references:=nil;
  mono_assembly_load_module:=nil;
  mono_assembly_close:=nil;
  mono_assembly_setrootdir:=nil;
  mono_assembly_getrootdir:=nil;
  mono_assembly_foreach:=nil;
  mono_assembly_set_main:=nil;
  mono_assembly_get_main:=nil;
  mono_assembly_get_image:=nil;
  mono_assembly_get_name:=nil;
  mono_assembly_fill_assembly_name:=nil;
  mono_assembly_names_equal:=nil;
  mono_stringify_assembly_name:=nil;
  mono_install_assembly_load_hook:=nil;
  mono_install_assembly_search_hook:=nil;
  mono_install_assembly_refonly_search_hook:=nil;
  mono_assembly_invoke_search_hook:=nil;
  mono_install_assembly_postload_search_hook:=nil;
  mono_install_assembly_postload_refonly_search_hook:=nil;
  mono_install_assembly_preload_hook:=nil;
  mono_install_assembly_refonly_preload_hook:=nil;
  mono_assembly_invoke_load_hook:=nil;
  mono_assembly_name_new:=nil;
  mono_assembly_name_get_name:=nil;
  mono_assembly_name_get_culture:=nil;
  mono_assembly_name_get_version:=nil;
  mono_assembly_name_get_pubkeytoken:=nil;
  mono_assembly_name_free:=nil;
  mono_register_bundled_assemblies:=nil;
  mono_register_config_for_assembly:=nil;
  mono_register_symfile_for_assembly:=nil;
  mono_register_machine_config:=nil;
  mono_set_rootdir:=nil;
  mono_set_dirs:=nil;
  mono_set_assemblies_path:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_assemblies_init):=GetProcAddress(hlib,'mono_assemblies_init');
  pointer(mono_assemblies_cleanup):=GetProcAddress(hlib,'mono_assemblies_cleanup');
  pointer(mono_assembly_open):=GetProcAddress(hlib,'mono_assembly_open');
  pointer(mono_assembly_open_full):=GetProcAddress(hlib,'mono_assembly_open_full');
  pointer(mono_assembly_load):=GetProcAddress(hlib,'mono_assembly_load');
  pointer(mono_assembly_load_full):=GetProcAddress(hlib,'mono_assembly_load_full');
  pointer(mono_assembly_load_from):=GetProcAddress(hlib,'mono_assembly_load_from');
  pointer(mono_assembly_load_from_full):=GetProcAddress(hlib,'mono_assembly_load_from_full');
  pointer(mono_assembly_load_with_partial_name):=GetProcAddress(hlib,'mono_assembly_load_with_partial_name');
  pointer(mono_assembly_loaded):=GetProcAddress(hlib,'mono_assembly_loaded');
  pointer(mono_assembly_loaded_full):=GetProcAddress(hlib,'mono_assembly_loaded_full');
  pointer(mono_assembly_get_assemblyref):=GetProcAddress(hlib,'mono_assembly_get_assemblyref');
  pointer(mono_assembly_load_reference):=GetProcAddress(hlib,'mono_assembly_load_reference');
  pointer(mono_assembly_load_references):=GetProcAddress(hlib,'mono_assembly_load_references');
  pointer(mono_assembly_load_module):=GetProcAddress(hlib,'mono_assembly_load_module');
  pointer(mono_assembly_close):=GetProcAddress(hlib,'mono_assembly_close');
  pointer(mono_assembly_setrootdir):=GetProcAddress(hlib,'mono_assembly_setrootdir');
  pointer(mono_assembly_getrootdir):=GetProcAddress(hlib,'mono_assembly_getrootdir');
  pointer(mono_assembly_foreach):=GetProcAddress(hlib,'mono_assembly_foreach');
  pointer(mono_assembly_set_main):=GetProcAddress(hlib,'mono_assembly_set_main');
  pointer(mono_assembly_get_main):=GetProcAddress(hlib,'mono_assembly_get_main');
  pointer(mono_assembly_get_image):=GetProcAddress(hlib,'mono_assembly_get_image');
  pointer(mono_assembly_get_name):=GetProcAddress(hlib,'mono_assembly_get_name');
  pointer(mono_assembly_fill_assembly_name):=GetProcAddress(hlib,'mono_assembly_fill_assembly_name');
  pointer(mono_assembly_names_equal):=GetProcAddress(hlib,'mono_assembly_names_equal');
  pointer(mono_stringify_assembly_name):=GetProcAddress(hlib,'mono_stringify_assembly_name');
  pointer(mono_install_assembly_load_hook):=GetProcAddress(hlib,'mono_install_assembly_load_hook');
  pointer(mono_install_assembly_search_hook):=GetProcAddress(hlib,'mono_install_assembly_search_hook');
  pointer(mono_install_assembly_refonly_search_hook):=GetProcAddress(hlib,'mono_install_assembly_refonly_search_hook');
  pointer(mono_assembly_invoke_search_hook):=GetProcAddress(hlib,'mono_assembly_invoke_search_hook');
  pointer(mono_install_assembly_postload_search_hook):=GetProcAddress(hlib,'mono_install_assembly_postload_search_hook');
  pointer(mono_install_assembly_postload_refonly_search_hook):=GetProcAddress(hlib,'mono_install_assembly_postload_refonly_search_hook');
  pointer(mono_install_assembly_preload_hook):=GetProcAddress(hlib,'mono_install_assembly_preload_hook');
  pointer(mono_install_assembly_refonly_preload_hook):=GetProcAddress(hlib,'mono_install_assembly_refonly_preload_hook');
  pointer(mono_assembly_invoke_load_hook):=GetProcAddress(hlib,'mono_assembly_invoke_load_hook');
  pointer(mono_assembly_name_new):=GetProcAddress(hlib,'mono_assembly_name_new');
  pointer(mono_assembly_name_get_name):=GetProcAddress(hlib,'mono_assembly_name_get_name');
  pointer(mono_assembly_name_get_culture):=GetProcAddress(hlib,'mono_assembly_name_get_culture');
  pointer(mono_assembly_name_get_version):=GetProcAddress(hlib,'mono_assembly_name_get_version');
  pointer(mono_assembly_name_get_pubkeytoken):=GetProcAddress(hlib,'mono_assembly_name_get_pubkeytoken');
  pointer(mono_assembly_name_free):=GetProcAddress(hlib,'mono_assembly_name_free');
  pointer(mono_register_bundled_assemblies):=GetProcAddress(hlib,'mono_register_bundled_assemblies');
  pointer(mono_register_config_for_assembly):=GetProcAddress(hlib,'mono_register_config_for_assembly');
  pointer(mono_register_symfile_for_assembly):=GetProcAddress(hlib,'mono_register_symfile_for_assembly');
  pointer(mono_register_machine_config):=GetProcAddress(hlib,'mono_register_machine_config');
  pointer(mono_set_rootdir):=GetProcAddress(hlib,'mono_set_rootdir');
  pointer(mono_set_dirs):=GetProcAddress(hlib,'mono_set_dirs');
  pointer(mono_set_assemblies_path):=GetProcAddress(hlib,'mono_set_assemblies_path');
end;

end.
