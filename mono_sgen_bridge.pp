{
* Copyright 2011 Novell, Inc.
*
* Licensed under the MIT license. See LICENSE file in the project root for full license information.
}
{
* The bridge is a mechanism for SGen to let clients override the death of some
* unreachable objects.  We use it in monodroid to do garbage collection across
* the Mono and Java heaps.
*
* The client can designate some objects as "bridged", which means that they
* participate in the bridge processing step once SGen considers them
* unreachable, i.e., dead.  Bridged objects must be registered for
* finalization.
*
* When SGen is done marking, it puts together a list of all dead bridged
* objects and then does a strongly connected component analysis over their
* object graph.  That graph will usually contain non-bridged objects, too.
*
* The output of the SCC analysis is passed to the `cross_references()`
* callback.  It is expected to set the `is_alive` flag on those strongly
* connected components that it wishes to be kept alive.  Only bridged objects
* will be reported to the callback, i.e., non-bridged objects are removed from
* the callback graph.
*
* In monodroid each bridged object has a corresponding Java mirror object.  In
* the bridge callback it reifies the Mono object graph in the Java heap so that
* the full, combined object graph is now instantiated on the Java side.  Then
* it triggers a Java GC, waits for it to finish, and checks which of the Java
* mirror objects are still alive.  For those it sets the `is_alive` flag and
* returns from the callback.
*
* The SCC analysis is done while the world is stopped, but the callback is made
* with the world running again.  Weak links to bridged objects and other
* objects reachable from them are kept until the callback returns, at which
* point all links to bridged objects that don't have `is_alive` set are nulled.
* Note that weak links to non-bridged objects reachable from bridged objects
* are not nulled.  This might be considered a bug.
}

{$mode objfpc}
unit mono_sgen_bridge;

interface
uses
  mono_publib, mono_metadata, mono_object;



type
  _SGEN_BRIDGE =  Longint;
const
  SGEN_BRIDGE_VERSION = 4;

type
  PMonoGCBridgeObjectKind = ^MonoGCBridgeObjectKind;
  MonoGCBridgeObjectKind =  Longint;
const
  { Instances of this class should be scanned when computing the transitive dependency among bridges. E.g. List<object> }
  GC_BRIDGE_TRANSPARENT_CLASS = 0;
  { Instances of this class should not be scanned when computing the transitive dependency among bridges. E.g. String }
  GC_BRIDGE_OPAQUE_CLASS = 1;
  { Instances of this class should be bridged and have their dependency computed.  }
  GC_BRIDGE_TRANSPARENT_BRIDGE_CLASS = 2;
  { Instances of this class should be bridged but no dependencies should not be calculated.  }
  GC_BRIDGE_OPAQUE_BRIDGE_CLASS = 3;

  { to be set by the cross reference callback  }
type
  PPMonoGCBridgeSCC = ^PMonoGCBridgeSCC;
  PMonoGCBridgeSCC = ^MonoGCBridgeSCC;
  MonoGCBridgeSCC = record
    is_alive : mono_bool;
    num_objs : longint;
    objs : array[0..(MONO_ZERO_LEN_ARRAY)-1] of PMonoObject;
  end;

  PMonoGCBridgeXRef = ^MonoGCBridgeXRef;
  MonoGCBridgeXRef = record
    src_scc_index : longint;
    dst_scc_index : longint;
  end;

  PMonoGCBridgeCallbacks = ^MonoGCBridgeCallbacks;
  MonoGCBridgeCallbacks = record
    bridge_version : longint;
    {
    * Tells the runtime which classes to even consider when looking for
    * bridged objects.  If subclasses are to be considered as well, the
    * subclass check must be done in the callback.
    }
    bridge_class_kind : function (klass:PMonoClass):MonoGCBridgeObjectKind;cdecl;
    {
    * This is only called on objects for whose classes
    * `bridge_class_kind()` returned `XXX_BRIDGE_CLASS`.
    }
    is_bridge_object : function (pobject:PMonoObject):mono_bool;cdecl;
    cross_references : procedure (num_sccs:longint; sccs:PPMonoGCBridgeSCC; num_xrefs:longint; xrefs:PMonoGCBridgeXRef);cdecl;
  end;


{
* Note: This may be called at any time, but cannot be called concurrently
* with (during and on a separate thread from) sgen init. Callers are
* responsible for enforcing this.
}
var
  mono_gc_register_bridge_callbacks : procedure(callbacks:PMonoGCBridgeCallbacks);
  mono_gc_wait_for_bridge_processing : procedure;

  
  procedure bind_procs(hLib : TLibHandle);
  procedure free_procs;   
  
implementation

procedure free_procs;
begin
  mono_gc_register_bridge_callbacks:=nil;
  mono_gc_wait_for_bridge_processing:=nil;
end;


procedure bind_procs(hLib : TLibHandle);
begin
  free_procs;
  pointer(mono_gc_register_bridge_callbacks):=GetProcAddress(hlib,'mono_gc_register_bridge_callbacks');
  pointer(mono_gc_wait_for_bridge_processing):=GetProcAddress(hlib,'mono_gc_wait_for_bridge_processing');
end;


end.
