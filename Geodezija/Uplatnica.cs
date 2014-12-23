using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    public class Upl
    {
        public decimal Iznos { get; set; }
        public string Platitelj { get; set; }

        public string Primatelj { get; set; }
        public string IbanPlatitelj { get; set; }
        public string IbanPrim { get; set; }
        public string Model { get; set; }
        public string PozivPrimatelj { get; set; }
        public string Datum { get; set; }
        public string OpisPlacanja { get; set; }

        #region Konstruktori

        /// <summary>
        /// prazan kontruktor sa svim poljima
        /// </summary>
        /// 
        public Upl()
        {
            this.Iznos = 0.00m;
            this.Platitelj = string.Empty;
            this.Primatelj = string.Empty;
            this.IbanPlatitelj = string.Empty;
            this.IbanPrim = string.Empty;
            this.Model = string.Empty;
            this.PozivPrimatelj = string.Empty;
            this.Datum = string.Empty;
            this.OpisPlacanja = string.Empty;
        }
#endregion

    }
}