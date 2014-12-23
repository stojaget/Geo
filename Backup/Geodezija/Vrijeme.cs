using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    public partial class Vrijeme
    {
        #region Public
         /// Šifra predmeta
        public int Sifra { get; set; }

        public DateTime Datum { get; set; }

        /// Oib organizacijske jedinice
        public string Dolazak { get; set; }

        public string Odlazak { get; set; }

        public Boolean Blagdan { get; set; }
        public Boolean Godisnji { get; set; }
        public Boolean Bolovanje { get; set; }
    
        public string Napomena { get; set; }

        public int radnikID { get; set; }

        // public List<ZaposlenikJezici> ZaposlenikJezici = new List<ZaposlenikJezici>();

        #endregion

         #region Konstruktori





        /// <summary>
        /// prazan kontruktor sa svim poljima
        /// </summary>
        public Vrijeme()
        {

            this.Sifra = 0;
            this.Datum = DateTime.Now;

            this.Dolazak = string.Empty;
            this.Odlazak = string.Empty;
            this.Blagdan = false;
            this.Godisnji = false;
            this.Bolovanje = false;  
            this.radnikID = 0;
           
            this.Napomena = string.Empty;

        }


        #endregion
    }
}