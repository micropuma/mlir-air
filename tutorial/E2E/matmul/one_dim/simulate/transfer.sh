#!/bin/bash

air-opt input2-sync.mlir --air-insert-launch-and-segment-around-herd \
                   --air-dma-to-channel \
                   -o input2-sync.mlir