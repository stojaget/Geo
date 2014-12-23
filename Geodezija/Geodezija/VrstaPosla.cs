using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Geodezija
{
  public  class VrstaPosla
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

        public VrstaPosla()
        {
            this.Sifra = 0;
           
            this.Naziv = string.Empty;
            
            

        }

        public VrstaPosla(int sifra, string naziv)
        {
            this.Sifra = sifra;

            this.Naziv = naziv;
           
           
        }

    }
}
