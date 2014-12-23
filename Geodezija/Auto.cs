using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    public class Auto
    {
#region  Public polja

        /// Šifra predmeta
        public int Sifra { get; set; }

       

        public string Vlasnik { get; set; }
        public string Marka { get; set; }
      public string Rega { get; set; }

        // public List<ZaposlenikJezici> ZaposlenikJezici = new List<ZaposlenikJezici>();

        #endregion



        #region Konstruktori


        /// <summary>
        /// prazan kontruktor sa svim poljima
        /// </summary>
        public Auto()
        {

            this.Sifra = 0;
           

            this.Vlasnik = string.Empty;
            this.Marka = string.Empty;
            this.Rega = string.Empty;


            // this.ZaposlenikJezici = new List<ZaposlenikJezici>();

        }

       

        #endregion
    }
    }
      
