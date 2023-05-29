	$Columns = 
	     (   "version-number",
	         "request-start-time",
	         "operation-type",
	         "request-status",
	         "http-status-code",
	         "end-to-end-latency-in-ms",
	         "server-latency-in-ms",
	         "authentication-type",
	         "requester-account-name",
	         "owner-account-name",
	         "service-type",
	         "request-url",
	         "requested-object-key",
	         "request-id-header",
	         "operation-count",
	         "requester-ip-address",
	         "request-version-header",
	         "request-header-size",
	         "request-packet-size",
	         "response-header-size",
	         "response-packet-size",
	         "request-content-length",
	         "request-md5",
	         "server-md5",
	         "etag-identifier",
	         "last-modified-time",
	         "conditions-used",
	         "user-agent-header",
	         "referrer-header",
	         "client-request-id"
	     )
	
	$logs = Import-Csv "C:\Users\hangx.REDMOND\Desktop\000000.log" -Delimiter ";" -Header $Columns
	
$logs | Out-GridView -Title "Storage Analytic Log Parser"