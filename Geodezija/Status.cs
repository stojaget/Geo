using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Geodezija
{
     [Serializable]
  public  class Status
    {

        private int sifra;

        public int Sifra
        {
            get { return sifra; }
            set { sifra = value; }
        }

        private string  naziv;

        public string Naziv
        {
            get { return naziv; }
            set { naziv = value; }
        }

        private string boja;

        public string Boja
        {
            get { return boja; }
            set { boja = value; }
        }

             public Status()
        {
            this.Sifra = 0;
           
            this.Naziv = string.Empty;
            this.Boja = string.Empty;
            

        }

             public Status(int sifra, string naziv, string boja)
        {
            this.Sifra = sifra;

            this.Naziv = naziv;
            this.Boja = boja;
           
        }

    }
}
