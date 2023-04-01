// Liam Salass
// 20229595

#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>

int cores(int major, int minor) {
	//Define GPU arch types using SM version to determine # cores
	

	switch (major) {
	case 2:
		if (minor == 1) return 48;
		else return 32;
		break;
	case 3:
		return 192;
		break;
	case 5:
		return 128;
		break;
	case 6:
		if ((minor == 1) || (minor == 2)) return 128;
		else if (minor == 0) return 64;
		break;
	case 7:
		if ((minor == 0) || (minor == 5)) return 64;
		break;
	}
	printf("Failed to find # cores for Major = %d and Minor = %d \n", major, minor);
	printf("Returned -1\n");
	return -1;
}


int main()
{
	int nDev;

	//Get count of devices
	cudaGetDeviceCount(&nDev);

	if (nDev == 0){
		printf("No devices");
	}
	else {
		for (int i = 0; i < nDev; i++) {
			//Get information about each cuda dev
			cudaDeviceProp dp;
			cudaGetDeviceProperties(&dp, i);

			//Print information
			printf("Device Number : %d\n", i);
			printf("\tDevice Name: %s\n", dp.name);
			printf("\tClock Rate: %d\n", dp.clockRate);
			printf("\t# Multiprocessors: %d\n", dp.multiProcessorCount);
			printf("\t# CUDA cores: %d\n", dp.multiProcessorCount * cores(dp.major, dp.minor)); //Multiply number of processors by number of cores
			printf("\tWarp Size: %d\n", dp.warpSize);
			printf("\tGlobal Memory: %ld\n", dp.totalGlobalMem);
			printf("\tConstant Memory: %ld\n", dp.totalConstMem);
			printf("\tShared Memory per block: %ld\n", dp.sharedMemPerBlock);
			printf("\tRegister per block: %d\n", dp.regsPerBlock);
			printf("\tMax threads per block: %d\n", dp.maxThreadsPerBlock);
			printf("\tMax block dimensions: (%d, %d, %d)\n", 
				dp.maxThreadsDim[0],
				dp.maxThreadsDim[1],
				dp.maxThreadsDim[2]);
			printf("\tMax Grid dimensions: (%d, %d, %d)\n",
				dp.maxGridSize[0],
				dp.maxGridSize[1],
				dp.maxGridSize[2]);

		}
	}

}
