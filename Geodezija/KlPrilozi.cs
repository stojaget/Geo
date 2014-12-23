using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Geodezija
{
    [Serializable]
    public class KlPrilozi
    {

         private int klijent_id;

        public int Klijent_id
        {
            get { return klijent_id; }
            set { klijent_id = value; }
        }

        private int rbr;

        public int Rbr
        {
            get { return rbr; }
            set { rbr = value; }
        }

        private string opis;

        public string Opis
        {
            get { return opis; }
            set { opis = value; }
        }

        private string putanja;

        public string Putanja
        {
            get { return putanja; }
            set { putanja = value; }
        }

       

        private DateTime dt_ins;

        public DateTime Dt_ins
        {
            get { return dt_ins; }
            set { dt_ins = value; }
        }


        private string tip_sadrzaja;

        public string Tip_sadrzaja
        {
            get { return tip_sadrzaja; }
            set { tip_sadrzaja = value; }
        }

        public KlPrilozi()
        {
            this.Klijent_id = 0;
            this.Rbr = 0;
            this.Opis= string.Empty;
            this.Putanja  =string.Empty;
            this.Tip_sadrzaja = string.Empty;
            this.Dt_ins = DateTime.MinValue;

        }

        public KlPrilozi(int klijent_id, int rbr, string opis, string putanja, string tip_sad, DateTime dt_ins)
        {
            this.Klijent_id = klijent_id;
            this.Rbr = rbr;
            this.Opis = opis;
            this.Putanja = putanja;
            this.Tip_sadrzaja = tip_sad;
            this.Dt_ins = dt_ins;
        }

    }
}