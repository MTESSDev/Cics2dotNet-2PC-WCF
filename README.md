# Cics2dotNet-2PC-WCF
Here a working cobol program to show how to do 2PC from CICS requester to IIS. You only need to correctly configure custom binding and extract the SingleWSDL from your service (.svc) and run that on mainframe side to create COBOL structures.

## IIS & WCF part
### web.config highlights
The culprit is to use a customBinding in place of a standard wsHttpBinding element. Ensure you place each xml element in the correct precise order (SEE: https://docs.microsoft.com/en-us/dotnet/framework/wcf/extending/custom-bindings). 

1. Transaction Flow
2. Reliable Session
4. Security
5. Composite Duplex
6. OneWay
7. Stream Security
8. Message Encoding
9. Transport

Only the last two (Message Encoding and Transport) are required; the rest are optional.

The simplest binding definition you can do is the following one: 
```xml
<bindings>
  <customBinding>
    <binding name="CICS_WSAT_Binding">
      <transactionFlow transactionProtocol="WSAtomicTransactionOctober2004" allowWildcardAction="false" />
      <textMessageEncoding messageVersion="Soap12" writeEncoding="utf-8" />
      <httpsTransport />
    </binding>
  </customBinding>
</bindings>
```

## Cobol part

### Cics program highlights

Cobol calling web service
```cobol
EXEC CICS INVOKE             SERVICE(VAT-NM-SW)               
                             CHANNEL(VAT-SERV-CHNL)           
                             OPERATION(VAT-NM-OPERATION)      
                             NOHANDLE                         
END-EXEC.  
```

Force transaction rollback
```cobol
EXEC CICS SYNCPOINT ROLLBACK
END-EXEC. 
```

Commit transaction
```cobol
EXEC CICS SYNCPOINT
END-EXEC. 
```
