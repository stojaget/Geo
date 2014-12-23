using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    public class kat_opc
    {

         private int sifra;

        public int Sifra
        {
            get { return sifra; }
            set { sifra = value; }
        }

        private string naziv;

        public string Naziv
        {
            get { return naziv; }
            set { naziv = value; }
        }

        public kat_opc()
        {
            this.Sifra = 0;
           
            this.Naziv = string.Empty;
            
            

        }

        public kat_opc(int sifra, string naziv)
        {
            this.Sifra = sifra;

            this.Naziv = naziv;
           
           
        }
    }
}