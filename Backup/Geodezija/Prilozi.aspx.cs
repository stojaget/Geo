using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace Geodezija
{
    public partial class Prilozi1 : System.Web.UI.Page
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {
            int sifra = Convert.ToInt32(Request.QueryString["ID"]);
            lblPredmet.Text = sifra.ToString();
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {  
            int sifra = Convert.ToInt32(Request.QueryString["ID"]);
            if (UploadTest.PostedFile != null && UploadTest.PostedFile.ContentLength > 0)
            {
                // Get the filename and folder to write to
                Prilozi noviPril = new Prilozi();

                int rbr = Convert.ToInt32(Helper.MaxPredmet()) + 1;

                string fileName = Path.GetFileName(UploadTest.PostedFile.FileName);
                string folder = Server.MapPath("~/Dokumenti/Predmeti/" + rbr);
                string putanja = Server.MapPath("~/Dokumenti/Predmeti/" + rbr + @"/" + UploadTest.FileName);
                string contentType = UploadTest.PostedFile.ContentType;
                // Ensure the folder exists
                if (!Directory.Exists(folder))
                {
                    Directory.CreateDirectory(folder);
                }
                

                // Save the file to the folder
                UploadTest.PostedFile.SaveAs(Path.Combine(folder, fileName));
                bool zaht = Helper.UnesiPrilog(sifra, rbr, txtNaziv.Text, putanja, contentType, DateTime.Now);

                if (zaht)
                {
                    lblMessage.Text = "Uspješno ste dodali prilog " + fileName;
                    
                    GridView1.DataBind();
                  //  Response.Write("Uploaded: " + fileName);
                }

                //    Response.Redirect("~/");
            }
        }
    }
}