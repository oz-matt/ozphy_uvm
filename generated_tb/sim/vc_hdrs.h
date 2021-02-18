#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <dlfcn.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef _VC_TYPES_
#define _VC_TYPES_
/* common definitions shared with DirectC.h */

typedef unsigned int U;
typedef unsigned char UB;
typedef unsigned char scalar;
typedef struct { U c; U d;} vec32;

#define scalar_0 0
#define scalar_1 1
#define scalar_z 2
#define scalar_x 3

extern long long int ConvUP2LLI(U* a);
extern void ConvLLI2UP(long long int a1, U* a2);
extern long long int GetLLIresult();
extern void StoreLLIresult(const unsigned int* data);
typedef struct VeriC_Descriptor *vc_handle;

#ifndef SV_3_COMPATIBILITY
#define SV_STRING const char*
#else
#define SV_STRING char*
#endif

#endif /* _VC_TYPES_ */


 extern SV_STRING Sgetarg(/* INPUT */int i);

 extern int uvm_hdl_check_path(/* INPUT */const char* path);

 extern int uvm_hdl_deposit(/* INPUT */const char* path, const /* INPUT */svLogicVecVal *value);

 extern int uvm_hdl_force(/* INPUT */const char* path, const /* INPUT */svLogicVecVal *value);

 extern int uvm_hdl_release_and_read(/* INPUT */const char* path, /* INOUT */svLogicVecVal *value);

 extern int uvm_hdl_release(/* INPUT */const char* path);

 extern int uvm_hdl_read(/* INPUT */const char* path, /* OUTPUT */svLogicVecVal *value);

 extern SV_STRING uvm_dpi_get_next_arg_c();

 extern SV_STRING uvm_dpi_get_tool_name_c();

 extern SV_STRING uvm_dpi_get_tool_version_c();

 extern void* uvm_dpi_regcomp(/* INPUT */const char* regex);

 extern int uvm_dpi_regexec(/* INPUT */void* preg, /* INPUT */const char* str);

 extern void uvm_dpi_regfree(/* INPUT */void* preg);

 extern int uvm_re_match(/* INPUT */const char* re, /* INPUT */const char* str);

 extern void uvm_dump_re_cache();

 extern SV_STRING uvm_glob_to_re(/* INPUT */const char* glob);

 extern int SLI_Checkout(/* INPUT */int group_id, /* INPUT */int num_tokens, /* INPUT */const char* feature_list, /* INPUT */const char* serv_path, /* INOUT */SV_STRING *feat_checkedout);

 extern int SLI_Errtext(/* INPUT */int error_status, /* INOUT */SV_STRING *error_str);
void Wterminate();
int VMM_Register(const char* modelName, const char* instName, const char* cInstId, int vmtVersion, /* INOUT */int *handle);
int VMM_RunCProgram(int handle, int startMode, const char* progName, int timeLo, int timeHi);
int VMM_ModelCallBack(int handle, int flag);
int VMM_CmdFetch(int handle);
int VMM_GetError(/* INOUT */char* *errMsg);
int SLI_Checkout(int group_id, int num_tokens, const char* feature_list, const char* serv_path, /* INOUT */char* *feat_checkedout);
int SLI_Errtext(int error_status, /* INOUT */char* *error_str);
int vmtDESEncryptStr(const char* inStr, const char* key, const char* filename, int append);
int vmtDESDecryptStr(/* INOUT */char* *decStr, const char* filename, const char* key, const char* token);
int vmtSysTimeStr(/* INOUT */char* *timeStr);
void Wterminatesynch();

#ifdef __cplusplus
}
#endif

