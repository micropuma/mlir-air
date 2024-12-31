//===- AIRRtOps.td -----------------------------------------*- tablegen -*-===//
//
// Copyright (C) 2022, Xilinx Inc. All rights reserved.
// Copyright (C) 2022, Advanced Micro Devices, Inc. All rights reserved.
// SPDX-License-Identifier: MIT
//
//===----------------------------------------------------------------------===//

// 关于代码中所用到的所有traits信息，参考：
// https://mlir.llvm.org/docs/Traits/#terminator

#ifndef AIRRT_OPS
#define AIRRT_OPS

// 在cmake中，这个.td提供生成airrt cpp的所有代码
include "air/Dialect/AIRRt/AIRRtBase.td"
include "mlir/IR/SymbolInterfaces.td"

class AIRRt_Op<string mnemonic, list<Trait> traits = []>
    : Op<AIRRt_Dialect, mnemonic, traits> {
}

/// ==================================== Module, Segment, Herd Metadata ====================================
// 参考https://mlir.llvm.org/doxygen/OpDefinition_8h_source.html
// SingleBlockImplicitTerminator: 
// This class provides APIs and verifiers for ops with regions having a single block that must terminate with TerminatorOpType.
def AIRRt_ModuleMetadataOp : AIRRt_Op<"module_metadata", [
  SingleBlockImplicitTerminator<"ModuleMetadataTerminatorOp">
]> {
  let summary = "Global metadata for the module";
  let description = [{
    This op contains a region containing airrt.segment_metadata ops,
    which give information about the segments in the module.

    There is one of these per module.
  }];
  let arguments = (ins);
  let results = (outs);
  let regions = (region SizedRegion<1>:$segments);
  let hasCustomAssemblyFormat = 1;
}

// 这个op是一个terminator，用于结束ModuleMetadataOp的region
// 因此需要实现判断其parent是否为ModuleMetadataOp的trait
def AIRRt_ModuleMetadataTerminatorOp
    : AIRRt_Op<"module_metadata_terminator",
               [Terminator, HasParent<"ModuleMetadataOp">]> {
  let summary = "Implicit terminator for ModuleMetadataOp's region";
  let arguments = (ins);
  let results = (outs);
  let assemblyFormat = "attr-dict";
}

// 同样的MetadataOp，先前的是module层级，里面存放segment的metadata
// 这个是segment层级，里面存放herd的metadata
def AIRRt_SegmentMetadataOp : AIRRt_Op<"segment_metadata", [
  HasParent<"ModuleMetadataOp">,
  SingleBlockImplicitTerminator<"SegmentMetadataTerminatorOp">
]> {
  let summary = "Runtime metadata for one air region";
  let description = [{
    This op contains a region containing airrt.herd_metadata ops,
    which give information about the herds in the module.
  }];
  let arguments = (ins
    StrAttr:$sym_name
  );
  let results = (outs);

  // segement的region中包含herd的metadata
  // 1表示只有一个子操作，并不等于1表示只有一个herd
  let regions = (region SizedRegion<1>:$herds);
  let hasCustomAssemblyFormat = 1;
}

def AIRRt_SegmentMetadataTerminatorOp
    : AIRRt_Op<"segment_metadata_terminator",
               [Terminator, HasParent<"SegmentMetadataOp">]> {
  let summary = "Implicit terminator for SegmentMetadataOp's region";
  let arguments = (ins);
  let results = (outs);
  let assemblyFormat = "attr-dict";
}

def AIRRt_HerdMetadataOp
    : AIRRt_Op<"herd_metadata", [
        HasParent<"SegmentMetadataOp">,
        SingleBlockImplicitTerminator<"HerdMetadataTerminatorOp">
      ]> {
  let summary = "Runtime metadata for a single herd";
  let description = [{
    Runtime metadata for a single herd.

  }];
  let arguments = (ins
    StrAttr:$sym_name
  );
  let results = (outs);
  let assemblyFormat = "attr-dict";
}

def AIRRt_HerdMetadataTerminatorOp
    : AIRRt_Op<"herd_metadata_terminator",
               [Terminator, HasParent<"HerdMetadataOp">]> {
  let summary = "Implicit terminator for HerdMetadataOp's region";
  let arguments = (ins);
  let results = (outs);
  let assemblyFormat = "attr-dict";
}

/// ==================================== Load Operation in different hierarchy ====================================
def AIRRt_HerdLoadOp : AIRRt_Op<"herd_load", []> {
    let summary = "load a herd";
    let arguments = (ins StrAttr:$sym_name, Variadic<AnyType>:$rtp);

    // results中一个是herd的handle，一个是event
    let results = (outs I64:$h, Optional<AIRRt_Event>:$event);
    let assemblyFormat = [{
      $sym_name ` ``(` $rtp `)` attr-dict `:` functional-type($rtp, results)
    }];
}

def AIRRt_SegmentLoadOp : AIRRt_Op<"segment_load", []> {
    let summary = "load a segment";
    let arguments = (ins StrAttr:$sym_name);
    let results = (outs I64:$p, Optional<AIRRt_Event>:$event);
    let assemblyFormat = [{
      $sym_name attr-dict `:` type($p) (`,` type($event)^)?
    }];
}

/// ==================================== dma copy op ====================================
// DmaMemcpyNdOp是一个dma操作，用于将数据从一个内存区域复制到另一个内存区域
// 无关乎是Segment还是herd
def AIRRt_DmaMemcpyNdOp: AIRRt_Op<"dma_memcpy_nd", []> {
  let summary = "dma operator";
  let arguments = (
    ins I32:$id,
        I64:$x,
        I64:$y,
        AnyMemRef:$memref,
        I64:$offset3,
        I64:$offset2,
        I64:$offset1,
        I64:$offset0,
        I64:$length3,
        I64:$length2,
        I64:$length1,
        I64:$length0,
        I64:$stride3,
        I64:$stride2,
        I64:$stride1
  );

  // result返回的都是以event的方式返回的
  let results = (outs Optional<AIRRt_Event>:$event);
  let assemblyFormat = [{
    `(` $id `,`$x `,`$y `,`$memref
    `[` $offset3`,`$offset2`,`$offset1`,`$offset0 `]` `,`
    `[` $length3`,`$length2`,`$length1`,`$length0 `]` `,`
    `[` $stride3`,`$stride2`,`$stride1 `]` `)` attr-dict `:`
    `(` type($id)`,`type($x)`,`type($y)`,`type($memref)`,`
    `[` type($offset3)`,`type($offset2)`,`type($offset1)`,` type($offset0) `]` `,`
    `[` type($length3)`,`type($length2)`,`type($length1)`,` type($length0) `]` `,`
    `[` type($stride3)`,`type($stride2)`,`type($stride1) `]` `)` (`:` type($event)^)?
  }];
  let description = [{
    nd half dma operator
  }];
}

def AIRRt_MemcpyNdOp: AIRRt_Op<"memcpy_nd", []> {
  let summary = "dma operator";
  let arguments = (
    ins AnyMemRef:$dst,
        AnyMemRef:$src,
        I64:$offset3,
        I64:$offset2,
        I64:$offset1,
        I64:$offset0,
        I64:$length3,
        I64:$length2,
        I64:$length1,
        I64:$length0,
        I64:$stride3,
        I64:$stride2,
        I64:$stride1
  );
  let results = (outs Optional<AIRRt_Event>:$event);
  let assemblyFormat = [{
    `(` $dst`,`$src`,`
    `[` $offset3`,`$offset2`,`$offset1`,`$offset0 `]` `,`
    `[` $length3`,`$length2`,`$length1`,`$length0 `]` `,`
    `[` $stride3`,`$stride2`,`$stride1 `]` `)` attr-dict `:`
    `(` type($dst)`,`type($src)`,`
    `[` type($offset3)`,`type($offset2)`,`type($offset1)`,` type($offset0) `]` `,`
    `[` type($length3)`,`type($length2)`,`type($length1)`,` type($length0) `]` `,`
    `[` type($stride3)`,`type($stride2)`,`type($stride1) `]` `)`  (`:` type($event)^)?
  }];
  let description = [{
    nd memcpy operator
  }];
}

/// ==================================== alloc op ====================================
def AIRRt_AllocOp: AIRRt_Op<"alloc", []> {
  let summary = "AIRRt Allocation Op";
  let arguments = (ins);
  let results = (outs AnyMemRef:$result);
  let assemblyFormat = [{
    attr-dict `:` type($result)
  }];
  let description = [{
    AIRRt Allocation Op
  }];
  let hasCanonicalizer  = 1;
}

def AIRRt_DeallocOp: AIRRt_Op<"dealloc", []> {
  let summary = "AIRRt Deallocation Op";
  let arguments = (ins AnyMemRef:$memref);
  let results = (outs);
  let assemblyFormat = [{
    attr-dict $memref `:` type($memref)
  }];
  let description = [{
    AIRRt Deallocation Op
  }];
  let hasCanonicalizer  = 1;
}

/// ==================================== wait op ====================================
def AIRRt_WaitAllOp : AIRRt_Op<"wait_all", []> {
  let arguments = (ins Variadic<AIRRt_Event>:$events);
  let results = (outs Optional<AIRRt_Event>:$event);
  let summary = "wait for all operator";
  let description = [{
    Block and wait for all events before preceding.
    Optionally return an event.
  }];
  let assemblyFormat = [{
    ($events^)? attr-dict (`:` type($event)^)?
  }];
  let hasCanonicalizer  = 1;
}

#endif // #ifndef AIRRT_OPS
