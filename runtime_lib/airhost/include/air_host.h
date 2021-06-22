#ifndef AIR_HOST_H
#define AIR_HOST_H

#include "acdc_queue.h"
#include "hsa_defs.h"

#ifdef AIR_LIBXAIE_ENABLE
#include <xaiengine.h>
#endif

#include <stdlib.h>

extern "C" {

#define AIR_VCK190_SHMEM_BASE 0x020100000000LL

// library operations

#define XAIE_NUM_ROWS 8
#define XAIE_NUM_COLS 50

struct air_libxaie1_ctx_t {
#ifdef AIR_LIBXAIE_ENABLE
  XAieGbl_Config *AieConfigPtr;
  XAieGbl AieInst;
  XAieGbl_HwCfg AieConfig;
  XAieGbl_Tile TileInst[XAIE_NUM_COLS][XAIE_NUM_ROWS+1];
  XAieDma_Tile TileDMAInst[XAIE_NUM_COLS][XAIE_NUM_ROWS+1];
#endif
};

air_libxaie1_ctx_t *air_init_libxaie1();
void air_deinit_libxaie1(air_libxaie1_ctx_t*);

// queue operations
//

hsa_status_t air_queue_create(uint32_t size, uint32_t type, queue_t **queue, uint64_t paddr);

hsa_status_t air_queue_dispatch_and_wait(queue_t *queue, uint64_t doorbell, dispatch_packet_t *pkt);

// packet utilities
//

// initialize pkt as a herd init packet with given parameters
hsa_status_t air_packet_herd_init(dispatch_packet_t *pkt, uint16_t herd_id,
                                  uint8_t start_col, uint8_t num_cols,
                                  uint8_t start_row, uint8_t num_rows);

hsa_status_t air_packet_device_init(dispatch_packet_t *pkt, uint32_t num_cols);

hsa_status_t air_packet_aie_lock_range(dispatch_packet_t *pkt, uint16_t herd_id,
                                 uint64_t lock_id, uint64_t acq_rel, uint64_t value,
                                 uint8_t start_col, uint8_t num_cols,
                                 uint8_t start_row, uint8_t num_rows);

hsa_status_t air_packet_aie_lock(dispatch_packet_t *pkt, uint16_t herd_id,
                                 uint64_t lock_id, uint64_t acq_rel, uint64_t value,
                                 uint8_t col, uint8_t row);

hsa_status_t air_packet_nd_memcpy(dispatch_packet_t *pkt, uint16_t herd_id,
                                 uint8_t col, uint8_t direction, uint8_t channel,
                                 uint8_t burst_len, uint8_t memory_space,
                                 uint64_t phys_addr, uint32_t transfer_length1d,
                                 uint32_t transfer_length2d, uint32_t transfer_stride2d,
                                 uint32_t transfer_length3d, uint32_t transfer_stride3d,
                                 uint32_t transfer_length4d, uint32_t transfer_stride4d);

// herd descriptors generated by compiler
//

struct air_herd_shim_desc_t {
  int64_t *location_data;
  int64_t *channel_data;
};

struct air_herd_desc_t {
  int32_t name_length;
  char *name;
  air_herd_shim_desc_t *shim_desc;
};

struct air_rt_herd_desc_t {
  queue_t *q;
  air_herd_desc_t *herd_desc;
};

struct air_module_desc_t {
  uint64_t length;
  air_herd_desc_t **herd_descs;
};

// AIE config functions generated by AIE dialect lowering
struct air_rt_aie_functions_t {
  void (*configure_cores)(void);
  void (*configure_switchboxes)(void);
  void (*initialize_locks)(void);
  void (*configure_dmas)(void);
  void (*start_cores)(void);
};

// AIR module shared library helpers
//

typedef size_t air_module_handle_t;

// return 0 on failure, nonzero otherwise
air_module_handle_t air_module_load_from_file(const char* filename, queue_t *q=0);

// return 0 on success, nonzero otherwise
int32_t air_module_unload(air_module_handle_t handle);

air_module_desc_t *air_module_get_desc(air_module_handle_t handle);

air_herd_desc_t *air_herd_get_desc(air_module_handle_t handle, const char *name);

int32_t air_herd_load(const char *name);
//int32_t air_herd_load(air_herd_desc_t *herd_desc);

//typedef uint32_t air_herd_status_t;
//air_herd_status_t air_herd_status(air_herd_desc_t *herd_desc)
//bool air_herd_is_loaded(air_herd_desc_t *herd_desc);

// memory operations
//

void* air_mem_alloc(size_t size);

void* air_mem_get_paddr(void *vaddr);
void* air_mem_get_vaddr(void *paddr);

void air_mem_dealloc(void *vaddr);

}

#endif // AIR_HOST_H