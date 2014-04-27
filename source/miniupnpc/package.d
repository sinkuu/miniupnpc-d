// #include "declspec.h"
// #include "igd_desc_parse.h"

public import miniupnpc.igd_desc_parse;

/* error codes : */
enum UPNPDISCOVER_SUCCESS = 0;
enum UPNPDISCOVER_UNKNOWN_ERROR = -1;
enum UPNPDISCOVER_SOCKET_ERROR = -101;
enum UPNPDISCOVER_MEMORY_ERROR = -102;

/* versions : */
enum MINIUPNPC_VERSION = "1.8";
enum MINIUPNPC_API_VERSION = 9;

/* Structures definitions : */
struct UPNParg {
    const char* elt;
    const char* val;
}

struct UPNPDev {
	UPNPDev* pNext;
	char* descURL;
	char* st;
	uint scope_id;
	char[2] buffer;
}

extern (C): nothrow:

char* simpleUPnPcommand(int, const char*, const char*,
                  const char *, UPNParg*,
                  int*);


/* upnpDiscover()
 * discover UPnP devices on the network.
 * The discovered devices are returned as a chained list.
 * It is up to the caller to free the list with freeUPNPDevlist().
 * delay (in millisecond) is the maximum time for waiting any device
 * response.
 * If available, device list will be obtained from MiniSSDPd.
 * Default path for minissdpd socket will be used if minissdpdsock argument
 * is NULL.
 * If multicastif is not NULL, it will be used instead of the default
 * multicast interface for sending SSDP discover packets.
 * If sameport is not null, SSDP packets will be sent from the source port
 * 1900 (same as destination port) otherwise system assign a source port. */
UPNPDev* upnpDiscover(int delay, const char * multicastif,
             const char * minissdpdsock, int sameport,
             int ipv6,
             int * error);
/* freeUPNPDevlist()
 * free list returned by upnpDiscover() */
void freeUPNPDevlist(UPNPDev* devlist);

/* parserootdesc() :
 * parse root XML description of a UPnP device and fill the IGDdatas
 * structure. */
void parserootdesc(const char *, int, IGDdatas*);

/* structure used to get fast access to urls
 * controlURL: controlURL of the WANIPConnection
 * ipcondescURL: url of the description of the WANIPConnection
 * controlURL_CIF: controlURL of the WANCommonInterfaceConfig
 * controlURL_6FC: controlURL of the WANIPv6FirewallControl
 */
struct UPNPUrls {
	char* controlURL;
	char* ipcondescURL;
	char* controlURL_CIF;
	char* controlURL_6FC;
	char* rootdescURL;
}

/* UPNP_GetValidIGD() :
 * return values :
 *     0 = NO IGD found
 *     1 = A valid connected IGD has been found
 *     2 = A valid IGD has been found but it reported as
 *         not connected
 *     3 = an UPnP device has been found but was not recognized as an IGD
 *
 * In any non zero return case, the urls and data structures
 * passed as parameters are set. Donc forget to call FreeUPNPUrls(urls) to
 * free allocated memory.
 */
int UPNP_GetValidIGD(UPNPDev* devlist,
                 UPNPUrls* urls,
				 IGDdatas* data,
				 char* lanaddr, int lanaddrlen);

/* UPNP_GetIGDFromUrl()
 * Used when skipping the discovery process.
 * return value :
 *   0 - Not ok
 *   1 - OK */
int UPNP_GetIGDFromUrl(const char* rootdescurl,
                   UPNPUrls* urls,
                   IGDdatas* data,
                   char* lanaddr, int lanaddrlen);

void GetUPNPUrls(UPNPUrls*, IGDdatas*,
            const char*, uint);

void FreeUPNPUrls(UPNPUrls*);

/* return 0 or 1 */
int UPNPIGD_IsConnected(UPNPUrls*, IGDdatas*);

