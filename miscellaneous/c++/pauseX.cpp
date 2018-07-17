void pauseX() {
	#if defined(__linux__) || defined(__unix__) || defined(__APPLE__)
        cout << "Implement me!\endl";
	#endif

	#if defined(_WIN32) || defined(_WIN64)
		system("PAUSE");
	#endif
}