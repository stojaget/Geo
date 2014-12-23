using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    public class Klijent
    {
         #region  Public polja

        /// Šifra predmeta
        public int Sifra { get; set; }

       

        public string Naziv { get; set; }

      

        // public List<ZaposlenikJezici> ZaposlenikJezici = new List<ZaposlenikJezici>();

        #endregion



        #region Konstruktori


        /// <summary>
        /// prazan kontruktor sa svim poljima
        /// </summary>
        public Klijent()
        {

            this.Sifra = 0;
           

            this.Naziv = string.Empty;
            


            // this.ZaposlenikJezici = new List<ZaposlenikJezici>();

        }

         public Klijent(int sifra, string naziv)
        {
            this.Sifra = sifra;

            this.Naziv = naziv;
           
           
        }


        #endregion
    }
}