using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace Geodezija
{
    public class Zaposlenik
    {
        #region  Public polja

        /// Šifra zaposlenika prema kojoj se vode sve evidencije u kadrovskoj evidenciji i obračunu plaća.
        public string SifraZaposlenika { get; set; }

        
        /// Oib organizacijske jedinice
        public string Oib { get; set; }

        public string Jmbg { get; set; }

        public string Ime { get; set; }

        public string Prezime { get; set; }

        public string Email { get; set; }

        public string DatumRodenja { get; set; }

        public string Telefon { get; set; }
        public string Mob { get; set; }
        public string OsobnaIskaznicaBroj { get; set; }
     public string ZdravstvenaIskaznica { get; set; }  
        public string RadnaKnjizica { get; set; }
       
       // public List<ZaposlenikJezici> ZaposlenikJezici = new List<ZaposlenikJezici>();

        #endregion



        #region Konstruktori

        /// <summary>
        /// Konstruktor iz DataRowa, nema listi 
        /// </summary>
        /// <param name="dr">DataRow</param>
        public Zaposlenik(DataRow dr)
        {

            this.SifraZaposlenika = dr["SIF_ZAP"].ToString();
            this.Ime = dr["IME"].ToString();
            this.Prezime = dr["PREZIME"].ToString();
            this.Oib = dr["OIB"].ToString();
            this.Jmbg = dr["JMBG"].ToString();
          
            this.DatumRodenja = dr["DAT_ROD"].ToString();
            this.Telefon = dr["TELEFON"].ToString();
          
            this.OsobnaIskaznicaBroj = dr["OS_ISK_BROJ"].ToString();
         this.ZdravstvenaIskaznica = dr["ZDR_ISK"].ToString();
            this.RadnaKnjizica = dr["RKNJ"].ToString();
          
        }

        /// <summary>
        /// kontruktor sa min podacima
        /// </summary>
        /// <param name="sifra"></param>
        public Zaposlenik(string sifra)
        {

            this.SifraZaposlenika = sifra;
            this.Ime = string.Empty;
            this.Prezime = string.Empty;
            this.Oib = string.Empty;
            this.Jmbg = string.Empty;
        }



        /// <summary>
        /// prazan kontruktor sa svim poljima
        /// </summary>
        public Zaposlenik()
        {
           

            this.DatumRodenja = "";
           
            this.Ime = string.Empty;
          
            this.Jmbg = string.Empty;
           
            
            this.Oib = string.Empty;
            this.OsobnaIskaznicaBroj = string.Empty;
           
            this.Prezime = string.Empty;
           
            this.RadnaKnjizica = string.Empty;
           

            this.SifraZaposlenika = string.Empty;
           
            this.Telefon = string.Empty;
          
            this.ZdravstvenaIskaznica = string.Empty;
            
          
           // this.ZaposlenikJezici = new List<ZaposlenikJezici>();
           
        }


        #endregion
    }
}