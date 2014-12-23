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
        public string Grad { get; set; }
        public string Adresa { get; set; }
        public string Email { get; set; }
        public string Mob { get; set; }
        public string Tel1 { get; set; }
        public string Oib { get; set; }
        public string Ziro { get; set; }

      

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
            this.Grad = string.Empty;
            this.Adresa = string.Empty;
            this.Email = string.Empty;
            this.Mob = string.Empty;
            this.Tel1 = string.Empty;
            this.Oib = string.Empty;
            this.Ziro = string.Empty;
           
            


            // this.ZaposlenikJezici = new List<ZaposlenikJezici>();

        }

         public Klijent(int sifra, string naziv, string grad, string adresa, string email, string mob, string tel1, string oib, string ziro)
        {
            this.Sifra = sifra;

            this.Naziv = naziv;
            this.Grad = grad;
            this.Adresa = adresa;
            this.Email = email;
            this.Mob = mob;
            this.Tel1 = tel1;
            this.Oib = oib;
            this.Ziro = ziro;
           
        }


        #endregion
    }
}