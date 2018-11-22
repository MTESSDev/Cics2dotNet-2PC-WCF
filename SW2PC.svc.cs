using System;
using System.Collections.Generic;
using System.Globalization;
using System.ServiceModel;
using System.Transactions;

namespace POC_2PC
{
    public class SW2PC : ISW2PC
    {
        [OperationBehavior(TransactionScopeRequired = false, TransactionAutoComplete = true)]
        public InfoEmploye ObtenirInfoEmploye(string strNumEmpl)
        {
            /* Your logic here... (dabatase access etc..) */
            return Employe.GetEmploye(strNumEmpl);
        }

        [OperationBehavior(TransactionScopeRequired = true, TransactionAutoComplete = true)]
        public ZoneRetour AjouterEmploye(InfoEmploye infoEmploye)
        {
            /* Your logic here... (dabatase access etc..) */
            return Employe.AddEmploye(infoEmploye);
        }

        [OperationBehavior(TransactionScopeRequired = true, TransactionAutoComplete = true)]
        public ZoneRetour SupprimerEmploye(string numEmpl)
        {
            /* Your logic here... (dabatase access etc..) */
            return Employe.DeleteEmploye(numEmpl); ;
        }

        [OperationBehavior(TransactionScopeRequired = true, TransactionAutoComplete = true)]
        public ZoneRetour ModifierEmploye(InfoEmploye infoEmploye)
        {
            /* Your logic here... (dabatase access etc..) */
            return Employe.EditEmploye(numEmpl); ;
        }

    }

}
