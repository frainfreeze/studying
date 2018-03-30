#include "StopWatch.h"

void StopWatch::start()
{
	begin = std::chrono::high_resolution_clock::now();
}

void StopWatch::stop()
{
	end = std::chrono::high_resolution_clock::now();
}

long StopWatch::get_elapsed_microseconds()
{
	return std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count();
}

long StopWatch::get_elapsed_milliseconds()
{
	return std::chrono::duration_cast<std::chrono::milliseconds>(end - begin).count();
}
