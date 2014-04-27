module miniupnpc.upnpreplyparse;

struct NameValue {
    NameValue* le_next;
    NameValue** le_prev;
    char[64] name;
    char[64] value;
}

struct NameValueParserData {
    NameValue* lh_first;
    char[64] curelt;
	char* portListing;
	int portListingLength;
}

extern (C): nothrow:

/* ParseNameValue() */
void ParseNameValue(const char* buffer, int bufsize,
        NameValueParserData* data);

/* ClearNameValueList() */
void ClearNameValueList(NameValueParserData* pdata);

/* GetValueFromNameValueList() */
char* GetValueFromNameValueList(NameValueParserData* pdata,
        const char* Name);

/* GetValueFromNameValueListIgnoreNS() */
char* GetValueFromNameValueListIgnoreNS(NameValueParserData* pdata,
        const char* Name);

