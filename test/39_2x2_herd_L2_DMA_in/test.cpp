// (c) Copyright 2020 Xilinx Inc. All Rights Reserved.

#include <cstdio>
#include <cassert>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

#include "air_host.h"
#include "test_library.h"

#define XAIE_NUM_ROWS            8
#define XAIE_NUM_COLS           50
#define XAIE_ADDR_ARRAY_OFF     0x800

#define HIGH_ADDR(addr)	((addr & 0xffffffff00000000) >> 32)
#define LOW_ADDR(addr)	(addr & 0x00000000ffffffff)

#include "aie_inc.cpp"

#define L2_DMA_BASE 0x020240000000LL
#define SHMEM_BASE  0x020100000000LL

struct dma_cmd_t {
  uint8_t select;
  uint16_t length;
  uint16_t uram_addr;
  uint8_t id;
};

struct dma_rsp_t {
	uint8_t id;
};

int main(int argc, char *argv[])
{

  aie_libxaie_ctx_t *xaie = mlir_aie_init_libxaie();
  mlir_aie_init_device(xaie);

  mlir_aie_configure_cores(xaie);
  mlir_aie_configure_switchboxes(xaie);
  mlir_aie_initialize_locks(xaie);
  mlir_aie_configure_dmas(xaie);
  mlir_aie_start_cores(xaie);

  for (int i=0; i<32; i++) {
    mlir_aie_write_buffer_a71(xaie, i, 0xcafe0a71);
    mlir_aie_write_buffer_b71(xaie, i, 0xcafe0b71);
    mlir_aie_write_buffer_a72(xaie, i, 0xcafe0a72);
    mlir_aie_write_buffer_b72(xaie, i, 0xcafe0b72);
    mlir_aie_write_buffer_a81(xaie, i, 0xcafe0a81);
    mlir_aie_write_buffer_b81(xaie, i, 0xcafe0b81);
    mlir_aie_write_buffer_a82(xaie, i, 0xcafe0a82);
    mlir_aie_write_buffer_b82(xaie, i, 0xcafe0b82);
  }

  mlir_aie_print_dma_status(xaie, 7, 1);
  mlir_aie_print_dma_status(xaie, 7, 1);
  mlir_aie_print_dma_status(xaie, 8, 1);
  mlir_aie_print_dma_status(xaie, 8, 2);

  XAieGbl_Write32(xaie->TileInst[7][0].TileAddr + 0x00033008, 0xFF);
  XAieGbl_Write32(xaie->TileInst[8][0].TileAddr + 0x00033008, 0xFF);
  XAieGbl_Write32(xaie->TileInst[9][0].TileAddr + 0x00033008, 0xFF);
  XAieGbl_Write32(xaie->TileInst[10][0].TileAddr + 0x00033008, 0xFF);

  int fd = open("/dev/mem", O_RDWR | O_SYNC);
  if (fd == -1)
    return -1;

  uint32_t *bank0_ptr = (uint32_t *)mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, L2_DMA_BASE+0*0x20000);
  uint32_t *bank1_ptr = (uint32_t *)mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, L2_DMA_BASE+1*0x20000);
  uint32_t *bank2_ptr = (uint32_t *)mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, L2_DMA_BASE+2*0x20000);
  uint32_t *bank3_ptr = (uint32_t *)mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, L2_DMA_BASE+3*0x20000);
  uint32_t *bank4_ptr = (uint32_t *)mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, L2_DMA_BASE+4*0x20000);
  uint32_t *bank5_ptr = (uint32_t *)mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, L2_DMA_BASE+5*0x20000);
  uint32_t *bank6_ptr = (uint32_t *)mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, L2_DMA_BASE+6*0x20000);
  uint32_t *bank7_ptr = (uint32_t *)mmap(NULL, 0x20000, PROT_READ|PROT_WRITE, MAP_SHARED, fd, L2_DMA_BASE+7*0x20000);

  // Write an ascending pattern value into the memories
  // Also stamp with 1 for the lower memory, and 1 for the upper memory as it goes in
  for (int i=0;i<32;i++) {
    uint32_t upper_lower = (i%8)/4;
    uint32_t first128_second128 = i%2;
    uint32_t first64_second64 = (i%16)/8;
    uint32_t first32_second32 = (i/2)%2;
    uint32_t offset = (first128_second128)*4;
    offset += (first64_second64)*2;
    offset += first32_second32;
    offset += (i/16)*8;
    uint32_t toWrite = i + (((upper_lower)+1) << 28);

    printf("%d : %d %d %d %d %d %08X\n",i,upper_lower, first128_second128, first64_second64, first32_second32, offset, toWrite);
    if (upper_lower) {
      toWrite += (0x100000);
      bank1_ptr[offset] = toWrite;
      toWrite += (0x200000);
      bank3_ptr[offset] = toWrite;
      toWrite += (0x400000);
      bank5_ptr[offset] = toWrite;
      toWrite += (0x800000);
      bank7_ptr[offset] = toWrite;
    }
    else {
      toWrite += (0x100000);
      bank0_ptr[offset] = toWrite;
      toWrite += (0x200000);
      bank2_ptr[offset] = toWrite;
      toWrite += (0x400000);
      bank4_ptr[offset] = toWrite;
      toWrite += (0x800000);
      bank6_ptr[offset] = toWrite;
    }
  }
  
  for (int i=0;i<16;i++) {
    uint32_t word0 = bank0_ptr[i];
    uint32_t word1 = bank1_ptr[i];

    printf("%x %08X %08X\r\n", i, word0, word1);
  }

  // create the queue
  queue_t *q = nullptr;
  auto ret = air_queue_create(MB_QUEUE_SIZE, HSA_QUEUE_TYPE_SINGLE, &q, AIR_VCK190_SHMEM_BASE);
  assert(ret == 0 && "failed to create queue!");

  uint64_t wr_idx = queue_add_write_index(q, 1);
  uint64_t packet_id = wr_idx % q->size;

  dispatch_packet_t *pkt = (dispatch_packet_t*)(q->base_address_vaddr) + packet_id;
  initialize_packet(pkt);
  pkt->type = HSA_PACKET_TYPE_AGENT_DISPATCH;

  //
  // Set up a 2x2 herd starting 7,1
  //

  pkt->arg[0]  = AIR_PKT_TYPE_HERD_INITIALIZE;
  pkt->arg[0] |= (AIR_ADDRESS_ABSOLUTE_RANGE << 48);
  pkt->arg[0] |= (2L << 40);
  pkt->arg[0] |= (7L << 32);
  pkt->arg[0] |= (2L << 24);
  pkt->arg[0] |= (1L << 16);
  
  pkt->arg[1] = 0;  // Herd ID 0
  pkt->arg[2] = 0;
  pkt->arg[3] = 0;

  // dispatch packet
  signal_create(1, 0, NULL, (signal_t*)&pkt->completion_signal);
  signal_create(0, 0, NULL, (signal_t*)&q->doorbell);
  
  for (int stream=0; stream<4; stream++) {
    // globally bypass headers
    wr_idx = queue_add_write_index(q, 1);
    packet_id = wr_idx % q->size;

    pkt = (dispatch_packet_t*)(q->base_address_vaddr) + packet_id;
    initialize_packet(pkt);
    pkt->type = HSA_PACKET_TYPE_AGENT_DISPATCH;
    pkt->arg[0] = AIR_PKT_TYPE_PUT_STREAM;


    static dma_cmd_t cmd;
    cmd.select = 7;
    cmd.length = 0;
    cmd.uram_addr = 1;
    cmd.id = 0;

    pkt->arg[1] = stream;
    pkt->arg[2] = 0;
    pkt->arg[2] |= ((uint64_t)cmd.select) << 32;
    pkt->arg[2] |= cmd.length << 18;
    pkt->arg[2] |= cmd.uram_addr << 5;
    pkt->arg[2] |= cmd.id;

    signal_create(1, 0, NULL, (signal_t*)&pkt->completion_signal);
    signal_store_release((signal_t*)&q->doorbell, wr_idx);
  }

  //
  // send the data
  //

  for (int stream=0; stream<4; stream++) {

    wr_idx = queue_add_write_index(q, 1);
    packet_id = wr_idx % q->size;

    pkt = (dispatch_packet_t*)(q->base_address_vaddr) + packet_id;
    initialize_packet(pkt);
    pkt->type = HSA_PACKET_TYPE_AGENT_DISPATCH;
    pkt->arg[0] = AIR_PKT_TYPE_PUT_STREAM;

    static dma_cmd_t cmd;
    cmd.select = 0;
    cmd.length = 4;
    cmd.uram_addr = 0;
    cmd.id = stream;

    pkt->arg[1] = stream;
    pkt->arg[2] = 0;
    pkt->arg[2] |= ((uint64_t)cmd.select) << 32;
    pkt->arg[2] |= cmd.length << 18;
    pkt->arg[2] |= cmd.uram_addr << 5;
    pkt->arg[2] |= cmd.id;

    signal_create(1, 0, NULL, (signal_t*)&pkt->completion_signal);
    if (stream == 3) {
      signal_store_release((signal_t*)&q->doorbell, wr_idx);
      while (signal_wait_aquire((signal_t*)&pkt->completion_signal, HSA_SIGNAL_CONDITION_EQ, 0, 0x80000, HSA_WAIT_STATE_ACTIVE) != 0) {
        printf("packet completion signal timeout!\n");
        printf("%x\n", pkt->header);
        printf("%x\n", pkt->type);
        printf("%lx\n", pkt->completion_signal);
        break;
      }
    }
  }

  sleep(1);
  mlir_aie_print_dma_status(xaie, 7, 1);
  mlir_aie_print_dma_status(xaie, 7, 2);
  mlir_aie_print_dma_status(xaie, 8, 1);
  mlir_aie_print_dma_status(xaie, 8, 2);

  printf("\nChecking the output...\n");

  // Note: this is going to be wildly off.  We need to take into account the broadcast pattern
  uint32_t errs = 0;
  for (int i=0; i<32; i++) {
    uint32_t d;
    if (i<16)
      d = mlir_aie_read_buffer_a71(xaie, i) - 0x100000;
    else 
      d = mlir_aie_read_buffer_b71(xaie, i-16) - 0x100000;
    if ((d & 0x0fffffff) != (i)) {
      printf("[7,1] Word %i : Expect %d, got %08X\n",i, i, d);
      errs++;
    }
  }
  for (int i=0; i<32; i++) {
    uint32_t d;
    if (i<16)
      d = mlir_aie_read_buffer_a72(xaie, i) - 0x300000;
    else 
      d = mlir_aie_read_buffer_b72(xaie, i-16) - 0x300000;
    if ((d & 0x0fffffff) != (i)) {
      printf("[7,2] Word %i : Expect %d, got %08X\n",i, i, d);
      errs++;
    }
  }
  for (int i=0; i<32; i++) {
    uint32_t d;
    if (i<16)
      d = mlir_aie_read_buffer_a81(xaie, i) - 0x700000;
    else 
      d = mlir_aie_read_buffer_b81(xaie, i-16) - 0x700000;
    if ((d & 0x0fffffff) != (i)) {
      printf("[8,1] Word %i : Expect %d, got %08X\n",i, i, d);
      errs++;
    }
  }
  for (int i=0; i<32; i++) {
    uint32_t d;
    if (i<16)
      d = mlir_aie_read_buffer_a82(xaie, i) - 0xf00000;
    else 
      d = mlir_aie_read_buffer_b82(xaie, i-16) - 0xf00000;
    if ((d & 0x0fffffff) != (i)) {
      printf("[8,2] Word %i : Expect %d, got %08X\n",i, i, d);
      errs++;
    }
  }
  
  if (errs) {
    printf("FAIL: %d errors\n", errs);
    return -1;
  }
  else {
    printf("PASS!\n");
    return 0;
  }
}