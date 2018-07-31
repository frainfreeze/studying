#pragma once
#include <chrono>

class StopWatch {
public:
	void start();
	void stop();
	long get_elapsed_microseconds();
	long get_elapsed_milliseconds();

private:
	std::chrono::time_point<std::chrono::high_resolution_clock> begin;
	std::chrono::time_point<std::chrono::high_resolution_clock> end;
};

