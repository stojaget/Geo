using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Geodezija
{
    [Serializable]
  public partial  class Prilozi
    {

        private int proj_id;

        public int Proj_id
        {
            get { return proj_id; }
            set { proj_id = value; }
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

        public Prilozi()
        {
            this.Proj_id = 0;
            this.Rbr = 0;
            this.Opis= string.Empty;
            this.Putanja  =string.Empty;
            this.Tip_sadrzaja = string.Empty;
            this.Dt_ins = DateTime.MinValue;

        }

        public Prilozi(int proj_id, int rbr, string opis, string putanja, string tip_sad, DateTime dt_ins)
        {
            this.Proj_id = proj_id;
            this.Rbr = rbr;
            this.Opis = opis;
            this.Putanja = putanja;
            this.Tip_sadrzaja = tip_sad;
            this.Dt_ins = dt_ins;
        }



    }
}
