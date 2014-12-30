module miniupnpc.portlistingparse;

enum portMappingElt {
	PortMappingEltNone,
	PortMappingEntry, NewRemoteHost,
	NewExternalPort, NewProtocol,
	NewInternalPort, NewInternalClient,
	NewEnabled, NewDescription,
	NewLeaseTime
}

struct PortMapping {
	PortMapping* le_prev;
	PortMapping** le_next;
	ulong leaseTime;
	ushort externalPort;
	ushort internalPort;
	char[64] remoteHost;
	char[64] internalClient;
	char[64] description;
	char[4] protocol;
	char enabled;
}

struct PortMappingParserData {
	PortMapping* lh_first;
	portMappingElt curelt;
}

extern(C) nothrow @nogc:

void ParsePortListing(const char * buffer, int bufsize,
		PortMappingParserData* pdata);

void FreePortListing(PortMappingParserData* pdata);

