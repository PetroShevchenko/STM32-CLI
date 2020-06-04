#include <stdint.h> 
#include "pdm2pcm_glo.h"


uint32_t PDM_Filter_Init(PDM_Filter_Handler_t *pHandler)
{
	(void)pHandler;
	return PDM_FILTER_INIT_ERROR;
}

uint32_t PDM_Filter_setConfig(PDM_Filter_Handler_t *pHandler, PDM_Filter_Config_t *pConfig)
{
	(void)pHandler;
	(void)pConfig;
	return PDM_FILTER_CONFIG_ERROR;
}

uint32_t PDM_Filter(void *pDataIn, void *pDataOut, PDM_Filter_Handler_t *pHandler)
{
	(void)pDataIn;
	(void)pDataOut;
	(void)pHandler;
	return PDM_FILTER_SAMPLES_NUMBER_ERROR;
}