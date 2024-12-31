//===- AIRRtDialect.cpp -----------------------------------------*- C++ -*-===//
//
// Copyright (C) 2021-2022, Xilinx Inc. All rights reserved.
// Copyright (C) 2022, Advanced Micro Devices, Inc. All rights reserved.
// SPDX-License-Identifier: MIT
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/TypeSwitch.h"

#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/PatternMatch.h"

#include "air/Dialect/AIRRt/AIRRtDialect.h"
#include "air/Dialect/AIRRt/AIRRtOps.h"

using namespace mlir;
using namespace xilinx::airrt;

#include "air/Dialect/AIRRt/AIRRtOpsDialect.cpp.inc"

// 这个文件定义AIRRT的许多helper function。
// 例如，initialize()函数用于初始化dialect，parseType()函数用于解析类型，printType()函数用于打印类型。

// 初始化dialect的operation和types
void AIRRtDialect::initialize() {
  addTypes<EventType>();
  addOperations<
#define GET_OP_LIST
#include "air/Dialect/AIRRt/AIRRtOps.cpp.inc"
      >();
  addTypes<TensorType>();
}

Type AIRRtDialect::parseType(DialectAsmParser &parser) const {
  // Parse the main keyword for the type.
  StringRef keyword;
  if (parser.parseKeyword(&keyword))
    return Type();
  MLIRContext *context = getContext();

  // Handle 'event' types.
  if (keyword == "event")
    return EventType::get(context);

  parser.emitError(parser.getNameLoc(), "unknown airrt type: " + keyword);
  return Type();
}

void AIRRtDialect::printType(Type type, DialectAsmPrinter &os) const {
  TypeSwitch<Type>(type)
      .Case<EventType>([&](Type) { os << "event"; })
      .Default([](Type) { llvm_unreachable("unexpected 'airrt' type"); });
}

// helper function，用来支持规范化操作
static LogicalResult FoldWaitAll(WaitAllOp op, PatternRewriter &rewriter) {
  SmallVector<Value> operands = op->getOperands();
  if (op.use_empty() && !operands.size()) {
    rewriter.eraseOp(op);
    return success();
  }

  // If an operand of a wait_all is another wait_all, then the event has
  // already completed. Remove it from the operand list.
  for (auto i = operands.begin(), e = operands.end(); i != e; ++i) {
    // 检查wait的op是否是另一个wait_all
    auto wa = llvm::dyn_cast_if_present<WaitAllOp>(i->getDefiningOp());
    if (!wa)
      continue;
    operands.erase(i);

    // todo：这样的写法是否有点太低效了？应该用一个worklist来存储比较合适吧。
    rewriter.replaceOpWithNewOp<WaitAllOp>(op, op.getResultTypes(), operands);
    return success();
  }

  /*
  smallvector<Value, 4> worklist;
  for (auto i = operands.begin(), e = operands.end(); i != e; ++i) {
    // 检查wait的op是否是另一个wait_all
    auto wa = llvm::dyn_cast_if_present<WaitAllOp>(i->getDefiningOp());
    if (!wa) {
      worklist.push_back(*i);
      continue;
    }
  }

  if (worklist.size() == operands.size()) {
    return failure();
  } else {
    rewriter.replaceOpWithNewOp<WaitAllOp>(op, op.getResultTypes(), operands);
    return success();  
  }
   */

  return failure();
}

// 如果分配的内存后面没有使用的话，
// 那么就可以删除这个分配操作
static LogicalResult FoldAlloc(AllocOp op, PatternRewriter &rewriter) {
  auto memref = op.getResult();
  if (!llvm::range_size(memref.getUsers())) {
    rewriter.eraseOp(op);
    return success();
  }
  return failure();
}

static LogicalResult FoldDealloc(DeallocOp op, PatternRewriter &rewriter) {
  auto memref = op.getOperand();

  // 如果内存释放操作后面没有使用的话，那么就可以删除这个释放操作
  if (llvm::range_size(memref.getUsers()) == 1) {
    rewriter.eraseOp(op);
    return success();
  }
  return failure();
}

// 在这几个op的.td中，定义了hasCanonicalizationPatterns()为true，表示有规范化模式
void WaitAllOp::getCanonicalizationPatterns(RewritePatternSet &patterns,
                                            MLIRContext *context) {
  patterns.add(FoldWaitAll);
}

void AllocOp::getCanonicalizationPatterns(RewritePatternSet &patterns,
                                          MLIRContext *context) {
  patterns.add(FoldAlloc);
}

void DeallocOp::getCanonicalizationPatterns(RewritePatternSet &patterns,
                                            MLIRContext *context) {
  patterns.add(FoldDealloc);
}
