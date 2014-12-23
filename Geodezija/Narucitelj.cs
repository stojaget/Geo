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

        public string Pon_sifra { get; set; }
        public string Vrsta { get; set; }
        public string Naziv { get; set; }
        public string Grad { get; set; }
        public string Adresa { get; set; }
        public string Drzava { get; set; }
        public string Tekuci { get; set; }
        public DateTime? Dat_kreiranja { get; set; }
        public DateTime? Dat_azu { get; set; }
        public string Kreirao { get; set; }
        public string Email { get; set; }
        public string Email2 { get; set; }
        public string Mob { get; set; }
        public string Mob2 { get; set; }
        public string Tel1 { get; set; }
        public string Tel2 { get; set; }
        public string Oib { get; set; }
        public string Ziro { get; set; }
        public bool Potenc { get; set; }
        public bool Nepovezani { get; set; }
        public bool Povezani { get; set; }
        public string Titula { get; set; }
        public string Napomena { get; set; }
        public string Napomena2 { get; set; }
        public bool Ind { get; set; }
        public bool Ind_kontakt { get; set; }
        public bool Ind_ponuda { get; set; }
        #endregion



        #region Konstruktori


        /// <summary>
        /// prazan kontruktor sa svim poljima
        /// </summary>
        public Narucitelj()
        {
            this.Vrsta = string.Empty;
            this.Sifra = 0;
            this.Drzava = string.Empty;
            this.Povezani = false;
            this.Naziv = string.Empty;
            this.Grad = string.Empty;
            this.Adresa = string.Empty;
            this.Tekuci = string.Empty;
            this.Ziro = string.Empty;
            this.Titula = string.Empty;
            this.Email = string.Empty;
            this.Email2 = string.Empty;
            this.Mob = string.Empty;
            this.Mob2 = string.Empty;
            this.Tel1 = string.Empty;
            this.Tel2 = string.Empty;
            this.Potenc = false;
            this.Nepovezani = false;
            this.Ind = false;
            this.Ind_kontakt = false;
            this.Napomena = string.Empty;
            this.Napomena2 = string.Empty;
            this.Dat_kreiranja = new DateTime(1753, 1, 1);
        }

        public Narucitelj(int sifra, string pon_sif, bool ind_pon, string vrsta, string naziv, string drzava, string grad, string adresa, string tekuci, string ziro, string titula, string email, string email2, string mob, string tel1, string tel2, string oib, bool potenc, bool nepovezni, bool ind_prilog, bool povezani, DateTime dat_kreiranja, DateTime dat_azu, string kreirao, bool ind_kon, string napomena, string napomena2)
        {
            this.Sifra = sifra;
            this.Vrsta = vrsta;
            this.Email2 = email2;
            this.Napomena = napomena;
            this.Napomena2 = napomena2;
            this.Mob2 = string.Empty;
            this.Naziv = naziv;
            this.Grad = grad;
            this.Adresa = adresa;
            this.Tekuci = tekuci;
            this.Ziro = ziro;
            this.Oib = oib;
            this.Mob = mob;
            this.Nepovezani = nepovezni;
            this.Potenc = potenc;
            this.Titula = titula;
            this.Email = email;
            this.Tel1 = tel1;
            this.Tel2 = tel2;
            this.Ind = ind_prilog;
            this.Dat_kreiranja = dat_kreiranja;
            this.Kreirao = kreirao;
            this.Ind_kontakt = ind_kon;
            this.Povezani = povezani;
            this.Drzava = drzava;
            this.Ind_ponuda = ind_pon;
            this.Pon_sifra = pon_sif;
            this.Dat_azu = dat_azu;
        }


        #endregion
    }
}