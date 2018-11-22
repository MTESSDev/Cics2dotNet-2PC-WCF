# Cics2dotNet-2PC-WCF
Here a working cobol program to show how to do 2PC from CICS requester to IIS. You only need to correctly configure custom binding and extract the SingleWSDL from your service (.svc) and run that on mainframe side to create COBOL structures.


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
