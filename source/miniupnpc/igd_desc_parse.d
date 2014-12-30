module miniupnpc.igd_desc_parse;

/* Structure to store the result of the parsing of UPnP
 * descriptions of Internet Gateway Devices */
enum MINIUPNPC_URL_MAXSIZE = 128;

struct IGDdatas_service {
	char[MINIUPNPC_URL_MAXSIZE] controlurl;
	char[MINIUPNPC_URL_MAXSIZE] eventsuburl;
	char[MINIUPNPC_URL_MAXSIZE] scpdurl;
	char[MINIUPNPC_URL_MAXSIZE] servicetype;
	/*char devicetype[MINIUPNPC_URL_MAXSIZE];*/
}

struct IGDdatas {
	char[MINIUPNPC_URL_MAXSIZE] cureltname;
	char[MINIUPNPC_URL_MAXSIZE] urlbase;
	char[MINIUPNPC_URL_MAXSIZE] presentationurl;
	int level;
	/*int state;*/
	/* "urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1" */
	IGDdatas_service CIF;
	/* "urn:schemas-upnp-org:service:WANIPConnection:1"
	 * "urn:schemas-upnp-org:service:WANPPPConnection:1" */
	IGDdatas_service first;
	/* if both WANIPConnection and WANPPPConnection are present */
	IGDdatas_service second;
	/* "urn:schemas-upnp-org:service:WANIPv6FirewallControl:1" */
	IGDdatas_service IPv6FC;
	/* tmp */
	IGDdatas_service tmp;
}

extern(C) nothrow @nogc:

void IGDstartelt(void*, const char*, int);
void IGDendelt(void*, const char*, int);
void IGDdata(void*, const char*, int);
void printIGD(IGDdatas*);

