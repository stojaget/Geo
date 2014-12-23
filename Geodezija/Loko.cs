using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    public partial class Loko
    {
        int sifra;

        public int Sifra
        {
            get { return sifra; }
            set { sifra = value; }
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

        DateTime datum;

        public DateTime Datum
        {
            get { return datum; }
            set { datum = value; }
        }

        decimal pocetna;

        public decimal Pocetna
        {
            get { return pocetna; }
            set { pocetna = value; }
        }
        decimal dolazna;

        public decimal Dolazna
        {
            get { return dolazna; }
            set { dolazna = value; }
        }
        int km;

        public int Km
        {
            get { return km; }
            set { km = value; }
        }
        string relacija;

        public string Relacija
        {
            get { return relacija; }
            set { relacija = value; }
        }

        string auto;

        public string Auto
        {
            get { return auto; }
            set { auto = value; }
        }
        string vozac;

        public string Vozac
        {
            get { return vozac; }
            set { vozac = value; }
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
        string izvj;

        public string Izvj
        {
            get { return izvj; }
            set { izvj = value; }
        }
        string vrijeme;

        public string Vrijeme
        {
            get { return vrijeme; }
            set { vrijeme = value; }
        }
        string rega;

        public string Rega
        {
            get { return rega; }
            set { rega = value; }
        }
    }
}