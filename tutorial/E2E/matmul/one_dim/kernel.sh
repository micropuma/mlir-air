# output2的演变过程
# 1. 做placement：/placed.output2.mlir
# 2. 做segment化，做air-to-aie，包含AIE module和AIRRt dialect：aie.ouput2.mlir
# 3. 做lower airrt_to_airhost：
#        * AIR herd launch变成host端的launch代码，生成llvm
#        * AIR 中的memory cpy变成airrt的
#        ：生成aie_ctrl.output2.mlir
#        * 将ctrl变成llvm dialect
# 4. 根据airrt的生成，生成kernel端的mlir代码
# 5. 配置aie环境，利用aiecc.py工具生成elf文件

aircc.py -v output2.mlir -o test.a
