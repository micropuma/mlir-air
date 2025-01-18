air-opt input2-sync.mlir \
  --air-insert-launch-and-segment-around-herd \
  --air-lower-herd-parallel \
  --canonicalize \
  --cse \
  --air-renumber-dma \
  --convert-linalg-to-loops \
  --mlir-print-ir-after-all \
  -o output1.mlir \
  2>&1 | tee output.dump

air-opt output1.mlir \
  --air-place-herds="num-rows=6 num-cols=10 row-anchor=2 col-anchor=7" \
  -o output2.mlir
