000100 IDENTIFICATION DIVISION.                                                                                                     
000110 PROGRAM-ID.      UTSWR02 VERSION 1.                                                                                          
000120*AUTHOR.          GROUPE CSD.                                                                                                 
000130                                                                                                                              
000150*----------------------------------------------------------------*                                                            
000160*                                                                *                                                            
000170* DESC.: PILOTE DE SERVICE WEB MODE REQUESTER POUR LES DEMANDES  *                                                            
000180* -----  PREUVE DE CONCEPT AVEC ACCES A FICHIER VSAM             *                                                            
000190*        INCLUANT LE 2 PHASES COMMIT OU NON                      *                                                            
000200*----------------------------------------------------------------*                                                            
000480                                                                                                                              
000490 ENVIRONMENT                      DIVISION.                                                                                   
000500                                                                                                                              
000510 CONFIGURATION                    SECTION.                                                                                    
000520                                                                                                                              
000530 SPECIAL-NAMES.                   DECIMAL-POINT IS COMMA.                                                                     
000670*----------------------------------------------------------------*                                                            
000680 WORKING-STORAGE                  SECTION.                                                                                    
000690*----------------------------------------------------------------*                                                            
000700 01 COMMENCEMENT-DU-MODULE.                                                                                                   
001050*----------------------------------------------------------------*                                                            
001060*                                                                *                                                            
001070*                L E S   S E N T I N E L L E S                   *                                                            
001080*                                                                *                                                            
001090*----------------------------------------------------------------*                                                            
001100 01 FILLER                        PIC X(27)  VALUE                                                                            
001110         'LES SENTINELLES         -->'.                                                                                       
001200                                                                                                                              
001210 01 STL-1PC-2PC                   PIC X.                                                                                      
001220    88 MODE-2PC                              VALUE 'O'.                                                                       
001230    88 MODE-1PC                              VALUE 'N'.                                                                       
001240    88 MODE-TPC                              VALUE 'T'.                                                                       
001250                                                                                                                              
001260 01 STL-COD-ACTN                  PIC X.                                                                                      
001270    88 ACTN-AJO                              VALUE 'C'.                                                                       
001280    88 ACTN-SUP                              VALUE 'S'.                                                                       
001290    88 ACTN-OBT                              VALUE 'O'.                                                                       
001300    88 ACTN-MOD                              VALUE 'M'.                                                                       
001310                                                                                                                              
01480*----------------------------------------------------------------*                                                            
001490*                                                                *                                                            
001500*                 L E S   C O N S T A N T E S                    *                                                            
001510*                                                                *                                                            
001520*----------------------------------------------------------------*                                                            
001530 01 FILLER                        PIC X(27)  VALUE                                                                            
001540         'LES CONSTANTES          -->'.                                                                                       
001550 01 CTE-INFO-SW.                                                                                                              
001560    10 CTE-OBTENIR-EMPL           PIC X(255) VALUE                                                                            
001570                          'ObtenirInfoEmploye'.                                                                               
001580    10 CTE-AJOUTER-EMPL           PIC X(255) VALUE                                                                            
001590                          'AjouterEmploye'.                                                                                   
001600    10 CTE-MODIFIER-EMPL          PIC X(255) VALUE                                                                            
001610                          'ModifierEmploye'.                                                                                  
001620    10 CTE-SUPPRIMER-EMPL         PIC X(255) VALUE                                                                            
001630                          'SupprimerEmploye'.                                                                                 
001640    10 CTE-NM-SW-OBT              PIC X(32)  VALUE                                                                            
001650                          'UT1PCO1                         '.                                                                 
001660    10 CTE-NM-SW-AJO              PIC X(32)  VALUE                                                                            
001670                          'UT2PCO1                         '.                                                                 
001680    10 CTE-NM-SW-SUP              PIC X(32)  VALUE                                                                            
001690                          'UT2PCO1                         '.                                                                 
001700    10 CTE-NM-SW-MOD              PIC X(32)  VALUE                                                                            
001710                          'UT2PCO1                         '.                                                                 
001720    10 CTE-NM-SW-OBT-2PC          PIC X(32)  VALUE                                                                            
001730                          'UT2PCO1                         '.                                                                 
001740    10 CTE-NM-SW-AJO-2PC          PIC X(32)  VALUE                                                                            
001750                          'UT2PCA1                         '.                                                                 
001760    10 CTE-NM-SW-SUP-2PC          PIC X(32)  VALUE                                                                            
001770                          'UT2PCS1                         '.                                                                 
001780    10 CTE-NM-SW-MOD-2PC          PIC X(32)  VALUE                                                                            
001790                          'UT2PCM1                         '.                                                                 
001800    10 CTE-DFH-DATA               PIC X(16)  VALUE                                                                            
001810                          'DFHWS-DATA'.                                                                                       
001820    10 CTE-SER-CHNL               PIC X(16)  VALUE                                                                            
001830                          'SERVICE-CHANNEL'.                                                                                  
001840                                                                                                                              
001850*----------------------------------------------------------------*                                                            
001860*                                                                *                                                            
001870*            L E S   Z O N E S   D E   T R A V A I L             *                                                            
001880*                                                                *                                                            
001890*----------------------------------------------------------------*                                                            
001900 01 FILLER                        PIC X(27)  VALUE                                                                            
001910         'LES VARIABLES DE TRAVAIL-->'.                                                                                       
001920 01 VAT-TRAVAIL.                                                                                                              
001930    05 VAT-CMD-CICS-EXEC          PIC X(8).                                                                                   
001940    05 VAT-SERV-CHNL              PIC X(16)  VALUE SPACES.       
                                                             
             ...

002710 01 VAT-NO-TEL.                                                                                                               
002720    05 VAT-NO-C1-TEL-NUM          PIC 9(10).                                                                                  
002730    05 VAT-NO-C1-TEL-ALPHA        REDEFINES                                                                                   
002740                                  VAT-NO-C1-TEL-NUM PIC X(10).                                                                
002750    05 VAT-NO-C2-TEL-NUM          PIC 9(10).                                                                                  
002760    05 VAT-NO-C2-TEL-ALPHA        REDEFINES                                                                                   
002770                                  VAT-NO-C2-TEL-NUM PIC X(10).                                                                
002780                                                                                                                              
002790*----------------------------------------------------------------*                                                            
002800*                                                                *                                                            
002810*   L E S   Z O N E S   D E   C O M M U N I C A T I O N   W E B  *                                                            
002820*                                                                *                                                            
002830*----------------------------------------------------------------*                                                            
002840 01 FILLER                        PIC X(27)  VALUE                                                                            
002850         'ZONES DE COMMUNICAT. WEB-->'.                                                                                       
002860                                                                                                                              
002870* ZONES D'APPEL   Créé à partir des outils IBM DFHWS2LS                                                                       
002880* ZONES D'APPEL                                                                                                               
002890* ZONES D'APPEL                                                                                                               
002900* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              
002910                                                                                                                              
002920 01 ObtenirInfoEmploye.                                                                                                       
002930    05 numEmpl-num                       PIC S9(9) COMP-5 SYNC.                                                               
002940    05 numEmpl.                                                                                                               
002950       10 numEmpl2-length                PIC S9999 COMP-5 SYNC.                                                               
002960       10 numEmpl2                       PIC X(255).                                                                          
002970       10 attr-nil-numEmpl-value         PIC X DISPLAY.                                                                       
002980                                                                                                                              
002990* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              
003000                                                                                                                              
003010 01 AjouterEmploye.                                                                                                           
003020    05 employe2-num                      PIC S9(9) COMP-5 SYNC.                                                               
003030    05 employe2.                                                                                                              
003040       10 employe.                                                                                                            
003050          15 attr-nil-employe-value      PIC X DISPLAY.                                                                       
003060          15 DateDebEmpl-num             PIC S9(9) COMP-5 SYNC.                                                               
003070          15 DateDebEmpl                 PIC S9(9) COMP-5 SYNC.                                                               
003080          15 DateFinEmpl-num             PIC S9(9) COMP-5 SYNC.                                                               
003090          15 DateFinEmpl                 PIC S9(9) COMP-5 SYNC.                                                               
003100          15 InfoZoneRetour2-num         PIC S9(9) COMP-5 SYNC.                                                               
003110          15 InfoZoneRetour2.                                                                                                 
003120             20 InfoZoneRetour.                                                                                               
003130                25 attr-nil-InfoZoneRetou-value                                                                               
003140                                         PIC X DISPLAY.                                                                       
003150                25 CodeRetour-num        PIC S9(9) COMP-5 SYNC.                                                               
003160                25 CodeRetour.                                                                                                
003170                   30 CodeRetour2-length PIC S9999 COMP-5 SYNC.                                                               
003180                   30 CodeRetour2        PIC X(255).                                                                          
003190                   30 attr-nil-CodeRetour-value                                                                               
003200                                         PIC X DISPLAY.                                                                       
003210                25 MessageRetour-num     PIC S9(9) COMP-5 SYNC.                                                               
003220                25 MessageRetour.                                                                                             
003230                   30 MessageRetour2-length                                                                                   
003240                                         PIC S9999 COMP-5 SYNC.                                                               
003250                   30 MessageRetour2     PIC X(255).                                                                          
003260                   30 attr-nil-MessageRetour-value                                                                            
003270                                         PIC X DISPLAY.                                                                       
003280          15 NivEntr-num                 PIC S9(9) COMP-5 SYNC.                                                               
003290          15 NivEntr                     PIC S9999 COMP-5 SYNC.                                                               
003300          15 NomContEmpl1-length         PIC S9999 COMP-5 SYNC.                                                               
003310          15 NomContEmpl1                PIC X(255).                                                                          
003320          15 attr-nil-NomContEmpl1-value PIC X DISPLAY.                                                                       
003330          15 NomContEmpl2-length         PIC S9999 COMP-5 SYNC.                                                               
003340          15 NomContEmpl2                PIC X(255).                                                                          
003350          15 attr-nil-NomContEmpl2-value PIC X DISPLAY.                                                                       
003360          15 NomEmpl-num                 PIC S9(9) COMP-5 SYNC.                                                               
003370          15 NomEmpl.                                                                                                         
003380             20 NomEmpl2-length          PIC S9999 COMP-5 SYNC.                                                               
003390             20 NomEmpl2                 PIC X(255).                                                                          
003400             20 attr-nil-NomEmpl-value   PIC X DISPLAY.                                                                       
003410          15 NumEmp-num                  PIC S9(9) COMP-5 SYNC.                                                               
003420          15 NumEmp.                                                                                                          
003430             20 NumEmp2-length           PIC S9999 COMP-5 SYNC.                                                               
003440             20 NumEmp2                  PIC X(255).                                                                          
003450             20 attr-nil-NumEmp-value    PIC X DISPLAY.                                                                       
003460          15 NumTelCont1-num             PIC S9(9) COMP-5 SYNC.                                                               
003470          15 NumTelCont1                 PIC 9(9)  COMP-5 SYNC.                                                               
003480          15 NumTelCont2-num             PIC S9(9) COMP-5 SYNC.                                                               
003490          15 NumTelCont2                 PIC 9(9)  COMP-5 SYNC.                                                               
003500          15 PrenContEmpl1-length        PIC S9999 COMP-5 SYNC.                                                               
003510          15 PrenContEmpl1               PIC X(255).                                                                          
003520          15 attr-nil-PrenContEmpl1-value                                                                                     
003530                                         PIC X DISPLAY.                                                                       
003540          15 PrenContEmpl2-length        PIC S9999 COMP-5 SYNC.                                                               
003550          15 PrenContEmpl2               PIC X(255).                                                                          
003560          15 attr-nil-PrenContEmpl2-value                                                                                     
003570                                         PIC X DISPLAY.                                                                       
003580          15 PrenEmpl-num                PIC S9(9) COMP-5 SYNC.                                                               
003590          15 PrenEmpl.                                                                                                        
003600             20 PrenEmpl2-length         PIC S9999 COMP-5 SYNC.                                                               
003610             20 PrenEmpl2                PIC X(255).                                                                          
003620             20 attr-nil-PrenEmpl-value  PIC X DISPLAY.                                                                       
003630          15 SalEmpl-num                 PIC S9(9) COMP-5 SYNC.                                                               
003640          15 SalEmpl                     PIC S9(15)V9(3) COMP-3.                                                              
003650          15 champ-num                   PIC S9(9) COMP-5 SYNC.                                                               
003660          15 champ.                                                                                                           
003670             20 champ2-length            PIC S9999 COMP-5 SYNC.                                                               
003680             20 champ2                   PIC X(255).                                                                          
003690             20 attr-nil-champ-value     PIC X DISPLAY.                                                                       
003700                                                                                                                              
003710* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              
003720                                                                                                                              
003730 01 ModifierEmploye.       
                ...                                                                                   
			même déclaration que AjouterEmploye
004420          ...                                                                                                                    
004430 01 SupprimerEmploye.                                                                                                         
004440    05 numEmpl-num                       PIC S9(9) COMP-5 SYNC.                                                               
004450    05 numEmpl.                                                                                                               
004460       10 numEmpl2-length                PIC S9999 COMP-5 SYNC.                                                               
004470       10 numEmpl2                       PIC X(255).                                                                          
004480       10 attr-nil-numEmpl-value         PIC X DISPLAY.                                                                       
004490                                                                                                                              
004500                                                                                                                              
004510* ZONES DE RETOUR                                                                                                             
004520* ZONES DE RETOUR                                                                                                             
004530* ZONES DE RETOUR                                                                                                             
004540* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              
004550                                                                                                                              
004560 01 ObtenirInfoEmployeResponse.                                                                                               
004570    05 ObtenirInfoEmployeResu-num        PIC S9(9) COMP-5 SYNC.                                                               
004580    05 ObtenirInfoEmployeResult2.                                                                                             
004590       09 ObtenirInfoEmployeResult.                                                                                           
004600          15 attr-nil-ObtenirInfoEm-value                                                                                     
004610                                         PIC X DISPLAY.                                                                       
004620          15 DateDebEmpl-num             PIC S9(9) COMP-5 SYNC.                                                               
004630          15 DateDebEmpl                 PIC S9(9) COMP-5 SYNC.                                                               
004640          15 DateFinEmpl-num             PIC S9(9) COMP-5 SYNC.                                                               
004650          15 DateFinEmpl                 PIC S9(9) COMP-5 SYNC.                                                               
004660          15 InfoZoneRetour2-num         PIC S9(9) COMP-5 SYNC.                                                               
004670          15 InfoZoneRetour2.                                                                                                 
004680             20 InfoZoneRetour.                                                                                               
004690                25 attr-nil-InfoZoneRetou-value                                                                               
004700                                         PIC X DISPLAY.                                                                       
004710                25 CodeRetour-num        PIC S9(9) COMP-5 SYNC.                                                               
004720                25 CodeRetour.                                                                                                
004730                   30 CodeRetour2-length PIC S9999 COMP-5 SYNC.                                                               
004740                   30 CodeRetour2        PIC X(255).                                                                          
004750                   30 attr-nil-CodeRetour-value                                                                               
004760                                         PIC X DISPLAY.                                                                       
004770                25 MessageRetour-num     PIC S9(9) COMP-5 SYNC.                                                               
004780                25 MessageRetour.                                                                                             
004790                   30 MessageRetour2-length                                                                                   
004800                                         PIC S9999 COMP-5 SYNC.                                                               
004810                   30 MessageRetour2     PIC X(255).                                                                          
004820                   30 attr-nil-MessageRetour-value                                                                            
004830                                         PIC X DISPLAY.                                                                       
004840          15 NivEntr-num                 PIC S9(9) COMP-5 SYNC.                                                               
004850          15 NivEntr                     PIC S9999 COMP-5 SYNC.                                                               
004860          15 NomContEmpl1-length         PIC S9999 COMP-5 SYNC.                                                               
004870          15 NomContEmpl1                PIC X(255).                                                                          
004880          15 attr-nil-NomContEmpl1-value PIC X DISPLAY.                                                                       
004890          15 NomContEmpl2-length         PIC S9999 COMP-5 SYNC.                                                               
004900          15 NomContEmpl2                PIC X(255).                                                                          
004910          15 attr-nil-NomContEmpl2-value PIC X DISPLAY.                                                                       
004920          15 NomEmpl-num                 PIC S9(9) COMP-5 SYNC.                                                               
004930          15 NomEmpl.                                                                                                         
004940             20 NomEmpl2-length          PIC S9999 COMP-5 SYNC.                                                               
004950             20 NomEmpl2                 PIC X(255).                                                                          
004960             20 attr-nil-NomEmpl-value   PIC X DISPLAY.                                                                       
004970          15 NumEmp-num                  PIC S9(9) COMP-5 SYNC.                                                               
004980          15 NumEmp.                                                                                                          
004990             20 NumEmp2-length           PIC S9999 COMP-5 SYNC.                                                               
005000             20 NumEmp2                  PIC X(255).                                                                          
005010             20 attr-nil-NumEmp-value    PIC X DISPLAY.                                                                       
005020          15 NumTelCont1-num             PIC S9(9) COMP-5 SYNC.                                                               
005030          15 NumTelCont1                 PIC 9(9)  COMP-5 SYNC.                                                               
005040          15 NumTelCont2-num             PIC S9(9) COMP-5 SYNC.                                                               
005050          15 NumTelCont2                 PIC 9(9)  COMP-5 SYNC.                                                               
005060          15 PrenContEmpl1-length        PIC S9999 COMP-5 SYNC.                                                               
005070          15 PrenContEmpl1               PIC X(255).                                                                          
005080          15 attr-nil-PrenContEmpl1-value                                                                                     
005090                                         PIC X DISPLAY.                                                                       
005100          15 PrenContEmpl2-length        PIC S9999 COMP-5 SYNC.                                                               
005110          15 PrenContEmpl2               PIC X(255).                                                                          
005120          15 attr-nil-PrenContEmpl2-value                                                                                     
005130                                         PIC X DISPLAY.                                                                       
005140          15 PrenEmpl-num                PIC S9(9) COMP-5 SYNC.                                                               
005150          15 PrenEmpl.                                                                                                        
005160             20 PrenEmpl2-length         PIC S9999 COMP-5 SYNC.                                                               
005170             20 PrenEmpl2                PIC X(255).                                                                          
005180             20 attr-nil-PrenEmpl-value  PIC X DISPLAY.                                                                       
005190          15 SalEmpl-num                 PIC S9(9) COMP-5 SYNC.                                                               
005200          15 SalEmpl                     PIC S9(15)V9(3) COMP-3.                                                              
005210          15 champ-num                   PIC S9(9) COMP-5 SYNC.                                                               
005220          15 champ.                                                                                                           
005230             20 champ2-length            PIC S9999 COMP-5 SYNC.                                                               
005240             20 champ2                   PIC X(255).                                                                          
005250             20 attr-nil-champ-value     PIC X DISPLAY.                                                                       
005260                                                                                                                              
005270                                                                                                                              
005280* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              
005290                                                                                                                              
005300 01 AjouterEmployeResponse.                                                                                                   
005310    05 AjouterEmployeResult2-num         PIC S9(9) COMP-5 SYNC.                                                               
005320    05 AjouterEmployeResult2.                                                                                                 
005330       10 AjouterEmployeResult.                                                                                               
005340         15 attr-nil-AjouterEmploy-value PIC X DISPLAY.                                                                       
005350         15 CodeRetour-num               PIC S9(9) COMP-5 SYNC.                                                               
005360         15 CodeRetour.                                                                                                       
005370            20 CodeRetour2-length        PIC S9999 COMP-5 SYNC.                                                               
005380            20 CodeRetour2               PIC X(255).                                                                          
005390            20 attr-nil-CodeRetour-value PIC X DISPLAY.                                                                       
005400         15 MessageRetour-num            PIC S9(9) COMP-5 SYNC.                                                               
005410         15 MessageRetour.                                                                                                    
005420            20 MessageRetour2-length     PIC S9999 COMP-5 SYNC.                                                               
005430            20 MessageRetour2            PIC X(255).                                                                          
005440            20 attr-nil-MessageRetour-value                                                                                   
005450                                         PIC X DISPLAY.                                                                       
005460                                                                                                                              
005470* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              
005480* le niveau 01 ModifierEmployeResponse a ete modifie pour                                                                     
005490*           01 ModifierEmployeRetour cas il y avait des erreurs                                                               
005500*           de compilation (duplicate name) de variables????                                                                  
005510* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              
005520                                                                                                                              
005530 01 ModifierEmployeRetour.                                                                                                    
005540    05 ModifierEmployeResult2-num        PIC S9(9) COMP-5 SYNC.                                                               
005550    05 ModifierEmployeResult2.                                                                                                
005560       10 ModifierEmployeResult.                                                                                              
005570          15 attr-nil-ModifierEmplo-value                                                                                     
005580                                         PIC X DISPLAY.                                                                       
005590          15 CodeRetour-num              PIC S9(9) COMP-5 SYNC.                                                               
005600          15 CodeRetour.                                                                                                      
005610             20 CodeRetour2-length       PIC S9999 COMP-5 SYNC.                                                               
005620             20 CodeRetour2              PIC X(255).                                                                          
005630             20 attr-nil-CodeRetour-value                                                                                     
005640                                         PIC X DISPLAY.                                                                       
005650          15 MessageRetour-num           PIC S9(9) COMP-5 SYNC.                                                               
005660          15 MessageRetour.                                                                                                   
005670             20 MessageRetour2-length    PIC S9999 COMP-5 SYNC.                                                               
005680             20 MessageRetour2           PIC X(255).                                                                          
005690             20 attr-nil-MessageRetour-value                                                                                  
005700                                         PIC X DISPLAY.                                                                       
005710                                                                                                                              
005720* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                                              
005730                                                                                                                              
005740 01 SupprimerEmployeResponse.                                                                                                 
005750    05 SupprimerEmployeResult-num        PIC S9(9) COMP-5 SYNC.                                                               
005760    05 SupprimerEmployeResult2.                                                                                               
005770       10 SupprimerEmployeResult.                                                                                             
005780          15 attr-nil-SupprimerEmpl-value                                                                                     
005790                                         PIC X DISPLAY.                                                                       
005800          15 CodeRetour-num              PIC S9(9) COMP-5 SYNC.                                                               
005810          15 CodeRetour.                                                                                                      
005820             20 CodeRetour2-length       PIC S9999 COMP-5 SYNC.                                                               
005830             20 CodeRetour2              PIC X(255).                                                                          
005840             20 attr-nil-CodeRetour-value                                                                                     
005850                                         PIC X DISPLAY.                                                                       
005860          15 MessageRetour-num           PIC S9(9) COMP-5 SYNC.                                                               
005870          15 MessageRetour.                                                                                                   
005880             20 MessageRetour2-length    PIC S9999 COMP-5 SYNC.                                                               
005890             20 MessageRetour2           PIC X(255).                                                                          
005900             20 attr-nil-MessageRetour-value                                                                                  
005910                                         PIC X DISPLAY.                                                                       
005920                                                                                                                              
007710    COPY IDMS RECORD UTPANRM.                                                                                                 
007720 02  COPY IDMS MODULE UTSWR1.                                                                                                 
007730/                                                                                                                             
007740                                                                                                                              
007750*----------------------------------------------------------------*                                                            
007760*                 *** PROCEDURE DIVISION ***                     *                                                            
007770*----------------------------------------------------------------*                                                            
007780* debut programme                                                                                                             
007790 PROCEDURE DIVISION USING DFHEIBLK DFHCOMMAREA.                                                                               
008430*----------------------------------------------------------------*                                                            
008440*                  *** MODULE DIRECTEUR ***                      *                                                            
008450*----------------------------------------------------------------*                                                            
008460                                                                                                                              
008470 0000-SECTION-DIRECTRICE          SECTION.                                                                                    
008480*-----------------------------------------                                                                                    
008490                                                                                                                              
008500     PERFORM                      1000-INITIALISATION.                                                                        
008510                                                                                                                              
008520     IF  UTGENR-V-CLE             = DFHENTER                                                                                  
008530         PERFORM                  2000-TRAITEMENT                                                                             
008540     END-IF.                                                                                                                  
008550                                                                                                                              
008560     PERFORM                      UT-FIN-TX-INTERNE.                                                                          
008570                                                                                                                              
008580                                                                                                                              
008590 0000-SECTION-DIRECTRICE-FIN.                                                                                                 
008600     EXIT.                                                                                                                    
008610/                                                                                                                             
009020     ...                                                                                                                      
           Traitement
           ...
013230*----------------------------------------------------------------*                                                            
013240* AFFECTER LES VARIABLES AVANT L'AJOUT D'UN EMPLOYE              *                                                            
013250*----------------------------------------------------------------*                                                            
013260 3100-PREPARER-AJOUTER            SECTION.                                                                                    
013270*-----------------------------------------                                                                                    
013280                                                                                                                              
013290     MOVE 3100                    TO UTANORM-NO-SEQ-APPEL.                                                                    
013300*---                                                                                                                          
013310                                                                                                                              
013320*--- TOUJOURS AFFECTER employe2-num A 1 (NOMBRE D'INSTANCE)                                                                   
013330     MOVE 1                       TO employe2-num                                                                             
013340                                     OF AjouterEmploye.                                                                       
013350     MOVE X'00'                   TO attr-nil-employe-value                                                                   
013360                                     OF AjouterEmploye.                                                                       
013370                                                                                                                              
013380*--- NIVEAU D'ENTRETIEN                                                                                                       
013390     MOVE 1                       TO NivEntr-num                                                                              
013400                                     OF AjouterEmploye.                                                                       
013410     MOVE T2PC1-UT-NIV-ENTR       TO NivEntr                                                                                  
013420                                     OF AjouterEmploye.                                                                       
013430                                                                                                                              
013440*--- NUMERO EMPLOYE (LA PRESENCE A ETE VALIDEE)                                                                               
013450     MOVE 1                       TO NumEmp-num                                                                               
013460                                     OF AjouterEmploye.                                                                       
013470     MOVE LENGTH OF UTSWR1-NOM-EMPI                                                                                           
013480                                  TO NumEmp2-length                                                                           
013490                                     OF AjouterEmploye.                                                                       
013500     MOVE UTSWR1-NUM-EMPI         TO NumEmp2                                                                                  
013510                                     OF AjouterEmploye.                                                                       
013520     MOVE X'00'                   TO attr-nil-NumEmp-value                                                                    
013530                                     OF AjouterEmploye.                                                                       
013540                                                                                                                              
013550*--- PRENOM EMPLOYE (LA PRESENCE A ETE VALIDEE)                                                                               
013560     MOVE 1                       TO PrenEmpl-num                                                                             
013570                                     OF AjouterEmploye.                                                                       
013580     MOVE LENGTH OF UTSWR1-PRN-EMPI                                                                                           
013590                                  TO PrenEmpl2-length                                                                         
013600                                     OF AjouterEmploye.                                                                       
013610     MOVE UTSWR1-PRN-EMPI         TO PrenEmpl2                                                                                
013620                                     OF AjouterEmploye.                                                                       
013630     MOVE X'00'                   TO attr-nil-PrenEmpl-value                                                                  
013640                                     OF AjouterEmploye.                                                                       
013650                                                                                                                              
013660*--- NOM EMPLOYE (LA PRESENCE A ETE VALIDEE)                                                                                  
013670     MOVE 1                       TO NomEmpl-num                                                                              
013680                                     OF AjouterEmploye.                                                                       
013690     MOVE LENGTH OF UTSWR1-NOM-EMPI                                                                                           
013700                                  TO NomEmpl2-length                                                                          
013710                                     OF AjouterEmploye.                                                                       
013720     MOVE UTSWR1-NOM-EMPI         TO NomEmpl2                                                                                 
013730                                     OF AjouterEmploye.                                                                       
013740     MOVE X'00'                   TO attr-nil-NomEmpl-value                                                                   
013750                                     OF AjouterEmploye.                                                                       
013760                                                                                                                              
014020                                     OF AjouterEmploye.        
                                                               
		...

014930                                                                                                                              
014940*    AFFECTER LES DONNEES SERVICE WEB                                                                                         
014950     MOVE CTE-SER-CHNL            TO VAT-SERV-CHNL.                                                                           
014960     MOVE CTE-DFH-DATA            TO VAT-DFH-DATA.                                                                            
014970                                                                                                                              
014980*    AFFECTER OPERATION                                                                                                       
014990     MOVE CTE-AJOUTER-EMPL        TO VAT-NM-OPERATION.                                                                        
015000*    AFFECTER NOM SERVICE WEB                                                                                                 
015010                                                                                                                              
015020*    IF MODE-2PC                                                                                                              
015030*       MOVE CTE-NM-SW-AJO-2PC    TO VAT-NM-SW                                                                                
015040*    ELSE                                                                                                                     
015050*       MOVE CTE-NM-SW-AJO        TO VAT-NM-SW                                                                                
015060*    END-IF                                                                                                                   
015070                                                                                                                              
015080     MOVE UTSWR1-SERV-WEBI        TO VAT-NM-SW.                                                                               
015090                                                                                                                              
015100     MOVE VAT-NM-OPERATION        TO UTSWR1-MES-LIG1I.                                                                        
015110     MOVE SPACES                  TO UTSWR1-MES-LIG2I                                                                         
015120                                     UTSWR1-MES-LIG3I.                                                                        
015150 3100-PREPARER-AJOUTER-FIN.                                                                                                   
015160     EXIT.                                                                                                                    
015180 *----------------------------------------------------------------* 
015190 *     AJOUTER UN EMPLOYE                                         * 
015200 *----------------------------------------------------------------* 
015210                                                                    
015220  3110-SW-AJOUTER                  SECTION.                         
015230 *-----------------------------------------                         
015270 *    PUT PUT PUT PUT PUT                                           
015280      EXEC CICS PUT                CONTAINER(VAT-DFH-DATA)          
015290                                   CHANNEL(VAT-SERV-CHNL)           
015300                                   FROM(AjouterEmploye)             
015310      END-EXEC.                                                     

		valider le code de retour de la commande.

015410 *    INVOKE INVOKE INVOKE                                          
015420      EXEC CICS INVOKE             SERVICE(VAT-NM-SW)               
015430                                   CHANNEL(VAT-SERV-CHNL)           
015440                                   OPERATION(VAT-NM-OPERATION)      
015450                                   NOHANDLE                         
015460      END-EXEC. 
                                                    
		valider le code de retour de la commande.
015540                                                                    
015550 *    GET GET GET GET GET                                           
015560      EXEC CICS GET                CONTAINER (VAT-DFH-DATA)         
015570                                   CHANNEL(VAT-SERV-CHNL)           
015580                                   INTO(AjouterEmployeResponse)    
015590                                   NOHANDLE                        
015600      END-EXEC.                                                    
015610                                                                   
		valider le code de retour de la commande.
015680      EXIT.                                                        
015690 /                
		        ...                                                 
			traitement
			...
018390*----------------------------------------------------------------*                                                            
018400* AFFICHER LES DONNEES DE EMPLOYE                                *                                                            
018410*----------------------------------------------------------------*                                                            
018420 3230-AFFICHER-OBTENIR            SECTION.                                                                                    
018430*-----------------------------------------                                                                                    
018480*    PRENOM EMPLOYE                                                                                                           
018490     MOVE PrenEmpl2 OF ObtenirInfoEmployeResponse                                                                             
018500          (1:PrenEmpl2-length OF ObtenirInfoEmployeResponse)                                                                  
018510                                  TO UTSWR1-PRN-EMPI.                                                                         
018520                                                                                                                              
018530*    NOM EMPLOYE                                                                                                              
018540     MOVE NomEmpl2 OF ObtenirInfoEmployeResponse                                                                              
018550          (1:NomEmpl2-length OF ObtenirInfoEmployeResponse)                                                                   
018560                                  TO UTSWR1-NOM-EMPI.                                                                         
018570                                                                                                                              
018580*    DATES DE DEBUT ET DE FIN                                                                                                 
018590     MOVE DateDebEmpl OF ObtenirInfoEmployeResponse                                                                           
018600                                  TO VAT-DATE-DEB-NUM.                                                                        
018610     MOVE VAT-DATE-DEB-ALPHA      TO UTSWR1-DATE-DEBI.                                                                        
018620                                                                                                                              
018630     MOVE DateFinEmpl OF ObtenirInfoEmployeResponse                                                                           
018640                                  TO VAT-DATE-FIN-NUM.                                                                        
018650     MOVE VAT-DATE-FIN-ALPHA      TO UTSWR1-DATE-FINI.                                                                        
018660                                                                                                                              
018670*    SALAIRE                                                                                                                  
018680     MOVE SalEmpl OF ObtenirInfoEmployeResponse                                                                               
018690                                  TO VAT-SAL-EMPL-NUM.                                                                        
018700     MOVE VAT-SAL-EMPL-ALPHA      TO UTSWR1-SAL-EMPI.      
                                                                   
             ...

018710                                                                                                                              
019260 3230-AFFICHER-OBTENIR-FIN.                                                                                                   
019270     EXIT.                                                                                                                    
019280/                                                                                                                             
025720*----------------------------------------------------------------*                                                            
025730* ROLLBACK                                                       *                                                            
025740*----------------------------------------------------------------*                                                            
025750 5000-ROLLBACK-TRAN                  SECTION.                                                                                 
025760*-----------------------------------------                                                                                    
025790                                                                                                                              
025800     EXEC CICS                    SYNCPOINT ROLLBACK                                                                          
025810     END-EXEC.                                                                                                                
025860 5000-ROLLBACK-TRAN-FIN.                                                                                                      
025870     EXIT.                                                                                                                    
025880                                                                                                                              
025890/                                                                                                                             
025900*----------------------------------------------------------------*                                                            
025910* ROLLBACK                                                       *                                                            
025920*----------------------------------------------------------------*                                                            
025930 5100-COMMIT-TRAN                    SECTION.                                                                                 
025940*-----------------------------------------                                                                                    
025950                                                                                                                              
026040       EXEC CICS                  SYNCPOINT                                                                                   
026050       END-EXEC.                                                                                                               
026120 5100-COMMIT-TRAN-FIN.                                                                                                        
026130     EXIT.                                                                                                                    
026140                                                                                                                              
026150/                                                                                                                             
