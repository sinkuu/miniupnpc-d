module miniupnpc.upnpcommands;

import miniupnpc.upnpreplyparse;
import miniupnpc.portlistingparse;

/* MiniUPnPc return codes :*/
enum UPNPCOMMAND_SUCCESS = 0;
enum UPNPCOMMAND_UNKNOWN_ERROR = -1;
enum UPNPCOMMAND_INVALID_ARGS = -2;
enum UPNPCOMMAND_HTTP_ERROR = -3;

extern(C) nothrow @nogc:

ulong UPNP_GetTotalBytesSent(const char* controlURL,
		const char* servicetype);

ulong UPNP_GetTotalBytesReceived(const char* controlURL,
		const char* servicetype);

ulong UPNP_GetTotalPacketsSent(const char* controlURL,
		const char* servicetype);

ulong UPNP_GetTotalPacketsReceived(const char* controlURL,
		const char* servicetype);

/* UPNP_GetStatusInfo()
 * status and lastconnerror are 64 byte buffers
 * Return values :
 * UPNPCOMMAND_SUCCESS, UPNPCOMMAND_INVALID_ARGS, UPNPCOMMAND_UNKNOWN_ERROR
 * or a UPnP Error code*/
int UPNP_GetStatusInfo(const char* controlURL,
		const char* servicetype,
		char* status,
		uint* uptime,
		char* lastconnerror);

/* UPNP_GetConnectionTypeInfo()
 * argument connectionType is a 64 character buffer
 * Return Values :
 * UPNPCOMMAND_SUCCESS, UPNPCOMMAND_INVALID_ARGS, UPNPCOMMAND_UNKNOWN_ERROR
 * or a UPnP Error code*/
int UPNP_GetConnectionTypeInfo(const char* controlURL,
		const char* servicetype,
		char* connectionType);

/* UPNP_GetExternalIPAddress() call the corresponding UPNP method.
 * if the third arg is not null the value is copied to it.
 * at least 16 bytes must be available
 *
 * Return values :
 * 0 : SUCCESS
 * NON ZERO : ERROR Either an UPnP error code or an unknown error.
 *
 * possible UPnP Errors :
 * 402 Invalid Args - See UPnP Device Architecture section on Control.
 * 501 Action Failed - See UPnP Device Architecture section on Control.*/
int UPNP_GetExternalIPAddress(const char* controlURL,
		const char* servicetype,
		char* extIpAdd);

/* UPNP_GetLinkLayerMaxBitRates()
 * call WANCommonInterfaceConfig:1#GetCommonLinkProperties
 *
 * return values :
 * UPNPCOMMAND_SUCCESS, UPNPCOMMAND_INVALID_ARGS, UPNPCOMMAND_UNKNOWN_ERROR
 * or a UPnP Error Code.*/
int UPNP_GetLinkLayerMaxBitRates(const char* controlURL,
		const char* servicetype,
		uint* bitrateDown,
		uint* bitrateUp);

/* UPNP_AddPortMapping()
 * if desc is NULL, it will be defaulted to "libminiupnpc"
 * remoteHost is usually NULL because IGD don't support it.
 *
 * Return values :
 * 0 : SUCCESS
 * NON ZERO : ERROR. Either an UPnP error code or an unknown error.
 *
 * List of possible UPnP errors for AddPortMapping :
 * errorCode errorDescription (short) - Description (long)
 * 402 Invalid Args - See UPnP Device Architecture section on Control.
 * 501 Action Failed - See UPnP Device Architecture section on Control.
 * 715 WildCardNotPermittedInSrcIP - The source IP address cannot be
 *                                   wild-carded
 * 716 WildCardNotPermittedInExtPort - The external port cannot be wild-carded
 * 718 ConflictInMappingEntry - The port mapping entry specified conflicts
 *                     with a mapping assigned previously to another client
 * 724 SamePortValuesRequired - Internal and External port values
 *                              must be the same
 * 725 OnlyPermanentLeasesSupported - The NAT implementation only supports
 *                  permanent lease times on port mappings
 * 726 RemoteHostOnlySupportsWildcard - RemoteHost must be a wildcard
 *                             and cannot be a specific IP address or DNS name
 * 727 ExternalPortOnlySupportsWildcard - ExternalPort must be a wildcard and
 *                                        cannot be a specific port value*/
int UPNP_AddPortMapping(const char* controlURL, const char* servicetype,
		const char* extPort,
		const char* inPort,
		const char* inClient,
		const char* desc,
		const char* proto,
		const char* remoteHost,
		const char* leaseDuration);

/* UPNP_DeletePortMapping()
 * Use same argument values as what was used for AddPortMapping().
 * remoteHost is usually NULL because IGD don't support it.
 * Return Values :
 * 0 : SUCCESS
 * NON ZERO : error. Either an UPnP error code or an undefined error.
 *
 * List of possible UPnP errors for DeletePortMapping :
 * 402 Invalid Args - See UPnP Device Architecture section on Control.
 * 714 NoSuchEntryInArray - The specified value does not exist in the array*/
int UPNP_DeletePortMapping(const char* controlURL, const char* servicetype,
		const char* extPort, const char* proto,
		const char* remoteHost);

/* UPNP_GetPortMappingNumberOfEntries()
 * not supported by all routers*/
int UPNP_GetPortMappingNumberOfEntries(const char* controlURL,
		const char* servicetype,
		uint* num);

/* UPNP_GetSpecificPortMappingEntry()
 *    retrieves an existing port mapping
 * params :
 *  in   extPort
 *  in   proto
 *  out  intClient (16 bytes)
 *  out  intPort (6 bytes)
 *  out  desc (80 bytes)
 *  out  enabled (4 bytes)
 *  out  leaseDuration (16 bytes)
 *
 * return value :
 * UPNPCOMMAND_SUCCESS, UPNPCOMMAND_INVALID_ARGS, UPNPCOMMAND_UNKNOWN_ERROR
 * or a UPnP Error Code.*/
int UPNP_GetSpecificPortMappingEntry(const char* controlURL,
		const char* servicetype,
		const char* extPort,
		const char* proto,
		char* intClient,
		char* intPort,
		char* desc,
		char* enabled,
		char* leaseDuration);

/* UPNP_GetGenericPortMappingEntry()
 * params :
 *  in   index
 *  out  extPort (6 bytes)
 *  out  intClient (16 bytes)
 *  out  intPort (6 bytes)
 *  out  protocol (4 bytes)
 *  out  desc (80 bytes)
 *  out  enabled (4 bytes)
 *  out  rHost (64 bytes)
 *  out  duration (16 bytes)
 *
 * return value :
 * UPNPCOMMAND_SUCCESS, UPNPCOMMAND_INVALID_ARGS, UPNPCOMMAND_UNKNOWN_ERROR
 * or a UPnP Error Code.
 *
 * Possible UPNP Error codes :
 * 402 Invalid Args - See UPnP Device Architecture section on Control.
 * 713 SpecifiedArrayIndexInvalid - The specified array index is out of bounds
 */
int UPNP_GetGenericPortMappingEntry(const char* controlURL,
		const char* servicetype,
		const char* index,
		char* extPort,
		char* intClient,
		char* intPort,
		char* protocol,
		char* desc,
		char* enabled,
		char* rHost,
		char* duration);

/* UPNP_GetListOfPortMappings()      Available in IGD v2
 *
 *
 * Possible UPNP Error codes :
 * 606 Action not Authorized
 * 730 PortMappingNotFound - no port mapping is found in the specified range.
 * 733 InconsistantParameters - NewStartPort and NewEndPort values are not
 *                              consistent.
 */
int UPNP_GetListOfPortMappings(const char* controlURL,
		const char* servicetype,
		const char* startPort,
		const char* endPort,
		const char* protocol,
		const char* numberOfPorts,
		PortMappingParserData* data);

/* IGD:2, functions for service WANIPv6FirewallControl:1*/
int UPNP_GetFirewallStatus(const char* controlURL,
		const char* servicetype,
		int* firewallEnabled,
		int* inboundPinholeAllowed);

int UPNP_GetOutboundPinholeTimeout(const char* controlURL, const char* servicetype,
		const char* remoteHost,
		const char* remotePort,
		const char* intClient,
		const char* intPort,
		const char* proto,
		int* opTimeout);

int UPNP_AddPinhole(const char* controlURL, const char* servicetype,
		const char* remoteHost,
		const char* remotePort,
		const char* intClient,
		const char* intPort,
		const char* proto,
		const char* leaseTime,
		char* uniqueID);

int UPNP_UpdatePinhole(const char* controlURL, const char* servicetype,
		const char* uniqueID,
		const char* leaseTime);

int UPNP_DeletePinhole(const char* controlURL, const char* servicetype, const char* uniqueID);

int UPNP_CheckPinholeWorking(const char* controlURL, const char* servicetype,
		const char* uniqueID, int* isWorking);

int UPNP_GetPinholePackets(const char* controlURL, const char* servicetype,
		const char* uniqueID, int* packets);

