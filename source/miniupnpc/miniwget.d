module miniupnpc.miniwget;

extern (C): nothrow:

void* getHTTPResponse(int s, int* size);

void* miniwget(const char*, int*, uint);

void* miniwget_getaddr(const char*, int *, char*, int, uint);

int parseURL(const char*, char*, ushort *, char**, uint*);
