using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    public class Narucitelj
    {
          #region  Public polja

        /// Šifra predmeta
        public int Sifra { get; set; }

       

        public string Naziv { get; set; }
        public string Grad { get; set; }
        public string Adresa { get; set; }
        public string Tekuci { get; set; }
        public string Ziro { get; set; }
        
        #endregion



        #region Konstruktori


        /// <summary>
        /// prazan kontruktor sa svim poljima
        /// </summary>
        public Narucitelj()
        {

            this.Sifra = 0;
           

            this.Naziv = string.Empty;
            this.Grad = string.Empty;
            this.Adresa = string.Empty;
            this.Tekuci = string.Empty;
            this.Ziro = string.Empty;
            

        }

         public Narucitelj(int sifra, string naziv, string grad, string adresa, string tekuci, string ziro)
        {
            this.Sifra = sifra;

             this.Naziv = naziv;
             this.Grad = grad;
             this.Adresa  = adresa;
             this.Tekuci = tekuci;
             this.Ziro = ziro;
           
        }


        #endregion
    }
    }