using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    public class PredmetSredjen
    {
          #region  Public polja

        /// Šifra predmeta
        public int Sifra { get; set; }

        public string NazPredmeta { get; set; }
        public int ArhBroj { get; set; }
        public string KatOpc { get; set; }
        public string KatCest { get; set; }
        /// Oib organizacijske jedinice
        public string KlOib { get; set; }
        public int Kat { get; set; }
        public string KlNaziv { get; set; }
        public int Status { get; set; }
        public int Vrsta { get; set; }
        public string KlMob { get; set; }
        public string KlMail { get; set; }
        public decimal Pdv { get; set; }

        public decimal Lova { get; set; }
        public decimal Ukupno { get; set; }
        public decimal Ugov_iznos { get; set; }
        public decimal Cijena_kat { get; set; }
        public decimal Racun_iznos { get; set; }
        //U TABLICI JE TO POLJE KREIRAO
        public string Izradio { get; set; }
        public int KlijentID { get; set; }
        public string KlAdresa { get; set; }
        public string Kreirao { get; set; }
        public string Zavrsio { get; set; }
        public string KlGrad { get; set; }
        public string Narucen { get; set; }
        public DateTime? Dat_predaja { get; set; }
        public DateTime? Dat_potvrde { get; set; }
        public DateTime? Dat_zavrs { get; set; }
        public DateTime? Dat_kreiranje { get; set; }
        public DateTime? Dat_izd { get; set; }
        public DateTime? Dat_azuriranja { get; set; }
        //datum predaje
        public DateTime? Dat_isp { get; set; }

        public DateTime? Dat_placanja { get; set; }
        public DateTime? Dat_predajedgu { get; set; }
        public string Sat_izd { get; set; }

        public string Putanja_projekt { get; set; }
        public int Racun_id { get; set; }
        //dat predaje dgu
        public DateTime? Dat_ugov { get; set; }

        public string Operater { get; set; }

        public decimal Iznos { get; set; }
        //public string Ponuda_sifra { get; set; }

        public string Faktura_sifra { get; set; }
        public string Dgu_klasa { get; set; }
        public string Dgu_uru { get; set; }
        public string Teren { get; set; }
        public string Pon_nar { get; set; }
        public string Godina { get; set; }
        public string Stigli { get; set; }
        public bool Ind { get; set; }
        public bool Placeno { get; set; }
       // public bool Ponuda_ind { get; set; }
        public bool Fakt_ind { get; set; }
        // public List<ZaposlenikJezici> ZaposlenikJezici = new List<ZaposlenikJezici>();

        #endregion



        #region Konstruktori





        /// <summary>
        /// prazan kontruktor sa svim poljima
        /// </summary>
        public PredmetSredjen()
        {

            this.Sifra = 0;
            this.NazPredmeta = string.Empty;
            this.ArhBroj = 0;
            this.KatOpc = string.Empty;
            this.KatCest = string.Empty;
            //bez pdv-a
            this.Iznos = 0;
            this.KlOib = string.Empty;
            this.KlMob = string.Empty;
            this.KlMail = string.Empty;
            this.Izradio = string.Empty;  //ime i prezime onoga tko je izradio
            this.Pdv = 0;
            this.Ukupno = 0;
            this.Dat_ugov = DateTime.Now;
            this.Dat_predajedgu = DateTime.Now;
            this.KlAdresa = string.Empty;
            this.KlNaziv = string.Empty;

            this.KlGrad = string.Empty;
            this.Kat = 0;
            this.Dat_izd = DateTime.Now;
            this.Putanja_projekt = string.Empty;
            this.Dat_isp = DateTime.Now;

            this.Dat_placanja = DateTime.Now;

            this.Sat_izd = "08:01";


            this.Racun_id = 0;

            this.Operater = string.Empty;  //1
            //this.Ponuda_sifra = string.Empty;
            this.Faktura_sifra = string.Empty;
            this.Ind = false;

            // this.ZaposlenikJezici = new List<ZaposlenikJezici>();

        }


        #endregion
    }
}