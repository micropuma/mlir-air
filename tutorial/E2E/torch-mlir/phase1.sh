air-opt input2.mlir \
  --air-insert-launch-and-segment-around-herd \
  --air-lower-herd-parallel \
  --canonicalize \
  --cse \
  --air-specialize-channel-wrap-and-stride \
  --air-renumber-dma \
  --convert-linalg-to-loops \
  --mlir-print-ir-after-all \
  -o output1.mlir \
  2>&1 | tee output.dump

air-opt output1.mlir \
  --air-place-herds="num-rows=6 num-cols=10 row-anchor=2 col-anchor=7" \
  -o output2.mlir

air-opt output2.mlir \
  --air-to-aie="emit-while-loop=true row-offset=2 col-offset=7 device=xcvc1902" \
  -o output3.mlir
