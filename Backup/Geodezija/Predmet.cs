using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    // ova klasa se koristi za punjenje obrasca ponude i fakture, ima i podatke o klijentu
    public class Predmet
    {
        #region  Public polja

        /// Šifra predmeta
        public int Sifra { get; set; }

        public string NazPredmeta { get; set; }

        /// Oib organizacijske jedinice
        public string KlOib { get; set; }

        public string KlNaziv { get; set; }

        public string KlMob { get; set; }
        public string KlMail { get; set; }
        public decimal Pdv { get; set; }
        public decimal Ukupno { get; set; }
        public string Izradio { get; set; }

        public string KlAdresa { get; set; }

        public string KlGrad { get; set; }

        public string Dat_izd { get; set; }

        public string Dat_isp { get; set; }

        public string Dat_placanja { get; set; }

        public string Sat_izd { get; set; }

        public int Racun_id { get; set; }

        public string Dat_ugov { get; set; }

        public string Operater { get; set; }

        public decimal Iznos { get; set; }

        // public List<ZaposlenikJezici> ZaposlenikJezici = new List<ZaposlenikJezici>();

        #endregion



        #region Konstruktori





        /// <summary>
        /// prazan kontruktor sa svim poljima
        /// </summary>
        public Predmet()
        {

            this.Sifra = 0;
            this.NazPredmeta = string.Empty;
//bez pdv-a
            this.Iznos = 0;
            this.KlOib = string.Empty;
            this.KlMob = string.Empty;
            this.KlMail = string.Empty;
            this.Izradio = string.Empty;  //ime i prezime onoga tko je izradio
            this.Pdv = 0;
            this.Ukupno = 0;
            this.Dat_ugov = DateTime.Now.ToShortDateString();

            this.KlAdresa = string.Empty;
            this.KlNaziv = string.Empty;

            this.KlGrad = string.Empty;

            this.Dat_izd = DateTime.Now.ToShortDateString();

            this.Dat_isp = DateTime.Now.ToShortDateString();

            this.Dat_placanja = DateTime.Now.ToShortDateString();

            this.Sat_izd = "08:01";


            this.Racun_id = 0;

            this.Operater = string.Empty;  //1
            


            // this.ZaposlenikJezici = new List<ZaposlenikJezici>();

        }


        #endregion
    }
}