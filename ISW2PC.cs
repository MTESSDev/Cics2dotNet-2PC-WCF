using System;
using System.Runtime.Serialization;
using System.ServiceModel;

namespace POC_2PC
{
    [ServiceContract]
    public interface ISW2PC
    {

        [OperationContract()]
        [TransactionFlow(TransactionFlowOption.Allowed)]
        InfoEmploye ObtenirInfoEmploye(string numEmpl);

        [TransactionFlow(TransactionFlowOption.Allowed)]
        [OperationContract()]
        ZoneRetour AjouterEmploye(InfoEmploye employe);

        [TransactionFlow(TransactionFlowOption.Allowed)]
        [OperationContract()]
        ZoneRetour SupprimerEmploye(string numEmpl);

        [TransactionFlow(TransactionFlowOption.Allowed)]
        [OperationContract()]
        ZoneRetour ModifierEmploye(InfoEmploye employe);

    }

    [DataContract]
    public class ZoneRetour
    {
        string _codeRetour = string.Empty;
        string _messageRetour = string.Empty;

        [DataMember]
        public string CodeRetour   // PIC X(02)
        {
            get { return _codeRetour; }
            set { _codeRetour = value; }
        }

        [DataMember]
        public string MessageRetour   // PIC X(99)
        {
            get { return _messageRetour; }
            set { _messageRetour = value; }
        }

    }

    [DataContract]
    public class InfoEmploye
    {

        Int16 _nivEntr = 0;
        string _numEmp = string.Empty;
        string _PrenEmpl = string.Empty;
        string _nomEmpl = string.Empty;
        Int32 _dateDebEmpl = 0;
        Int32 _dateFinEmpl = 0;
        Decimal _salEmpl = 0;
        string _champ = string.Empty;

        string _prenContEmpl1 = null;
        string _nomContEmpl1 = null;
        UInt32 _numTelCont1 = 0;

        string _prenContEmpl2 = null;
        string _nomContEmpl2 = null;
        UInt32 _numTelCont2 = 0;

        ZoneRetour _zoneRetour = null;

        [DataMember]
        public Int16 NivEntr   // PIC S9(4) COMP.
        {
            get { return _nivEntr; }
            set { _nivEntr = value; }
        }

        [DataMember]
        public string NumEmp  // PIC X(08)
        {
            get { return _numEmp; }
            set { _numEmp = value; }
        }

        [DataMember]
        public string PrenEmpl  // PIC X(20)
        {
            get { return _PrenEmpl; }
            set { _PrenEmpl = value; }
        }

        [DataMember]
        public string NomEmpl  // PIC X(20)
        {
            get { return _nomEmpl; }
            set { _nomEmpl = value; }
        }

        [DataMember]
        public Int32 DateDebEmpl  // PIC 9(8)  COMP-3
        {
            get { return _dateDebEmpl; }
            set { _dateDebEmpl = value; }
        }

        [DataMember]
        public Int32 DateFinEmpl  // PIC 9(8)  COMP-3
        {
            get { return _dateFinEmpl; }
            set { _dateFinEmpl = value; }
        }

        [DataMember]
        public Decimal SalEmpl  // PIC S9(06) V99 COMP-3
        {
            get { return _salEmpl; }
            set { _salEmpl = value; }
        }

        [DataMember]
        public string champ  // PIC X(49)
        {
            get { return _champ; }
            set { _champ = value; }
        }

        [DataMember(EmitDefaultValue = true, IsRequired = true, Name = "PrenContEmpl1")]
        public string PrenContEmpl1  // PIC X(20)
        {
            get { return _prenContEmpl1; }
            set { _prenContEmpl1 = value; }
        }

        [DataMember(EmitDefaultValue = true, IsRequired = true, Name = "NomContEmpl1")]
        public string NomContEmpl1  // PIC X(20)
        {
            get { return _nomContEmpl1; }
            set { _nomContEmpl1 = value; }
        }

        [DataMember]
        public UInt32 NumTelCont1  // PIC 9(11)
        {
            get { return _numTelCont1; }
            set { _numTelCont1 = value; }
        }

        [DataMember(EmitDefaultValue = true, IsRequired = true, Name = "PrenContEmpl2")]
        public string PrenContEmpl2  // PIC X(20)
        {
            get { return _prenContEmpl2; }
            set { _prenContEmpl2 = value; }
        }

        [DataMember(EmitDefaultValue = true, IsRequired = true, Name = "NomContEmpl2")]
        public string NomContEmpl2  // PIC X(20)
        {
            get { return _nomContEmpl2; }
            set { _nomContEmpl2 = value; }
        }

        [DataMember]
        public UInt32 NumTelCont2  // PIC 9(11)
        {
            get { return _numTelCont2; }
            set { _numTelCont2 = value; }
        }

        [DataMember]
        public ZoneRetour InfoZoneRetour
        {
            get { return _zoneRetour; }
            set { _zoneRetour = value; }
        }

    }

}
