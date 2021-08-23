#ifndef AIR_CONVERSION_PASSES_H
#define AIR_CONVERSION_PASSES_H

#include "air/Conversion/AffineToAIRPass.h"
#include "air/Conversion/AIRLoweringPass.h"
#include "air/Conversion/AIRToAIEPass.h"
#include "air/Conversion/AIRRtToLLVMPass.h"
namespace xilinx {
namespace air {

void registerConversionPasses();

} // namespace air
} // namespace xilinx

#endif // AIR_CONVERSION_PASSES_H