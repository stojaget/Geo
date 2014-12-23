using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;

using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Configuration;
using System.IO;
using Geodezija;


public partial class ViewFile : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString.Get("Id") != null)
    {
      Response.Clear();

      int proj = Convert.ToInt32((Request.QueryString.Get("Id")));
      int rbr = Convert.ToInt32((Request.QueryString.Get("Rbr")));
      Prilozi noviPrilog = Helper.GetPrilog(proj, rbr);

      Response.ContentType = noviPrilog.Tip_sadrzaja;
     // Response.BinaryWrite(noviPrilog.Putanja);

        //vidjeti gdje æe se smještati uploadani dok.
      Response.Redirect(Path.Combine("~/Upload", noviPrilog.Putanja));
      //    Response.Redirect(Server.MapPath("~/Upload"));
      
    }
    else
    {
      Response.Redirect("~/");
    }
  }
}
