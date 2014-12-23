using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    public partial class Ter
    {

        int sifra;

        public int Sifra
        {
            get { return sifra; }
            set { sifra = value; }
        }

        DateTime datum;

        public DateTime Datum
        {
            get { return datum; }
            set { datum = value; }
        }

        decimal odlazak;

        public decimal Odlazak
        {
            get { return odlazak; }
            set { odlazak = value; }
        }
        decimal dolazak;

        public decimal Dolazak
        {
            get { return dolazak; }
            set { dolazak = value; }
        }
        decimal sati;

        public decimal Sati
        {
            get { return sati; }
            set { sati = value; }
        }
        string opis;

        public string Opis
        {
            get { return opis; }
            set { opis = value; }
        }

       
        decimal iznos;

        public decimal Iznos
        {
            get { return iznos; }
            set { iznos = value; }
        }
        DateTime dat_kreir;

        public DateTime Dat_kreir
        {
            get { return dat_kreir; }
            set { dat_kreir = value; }
        }
        DateTime dat_azu;

        public DateTime Dat_azu
        {
            get { return dat_azu; }
            set { dat_azu = value; }
        }
        string kreirao;

        public string Kreirao
        {
            get { return kreirao; }
            set { kreirao = value; }
        }
        int radnikID;

        public int RadnikID
        {
            get { return radnikID; }
            set { radnikID = value; }
        }
      
        string vrsta;

        public string Vrsta
        {
            get { return vrsta; }
            set { vrsta = value; }
        }

        string napomena;

        public string Napomena
        {
            get { return napomena; }
            set { napomena = value; }
        }
       
    }
}