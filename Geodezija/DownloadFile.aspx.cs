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


public partial class DownloadFile : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Request.QueryString.Get("Id") != null)
    {
     

      int proj = Convert.ToInt32((Request.QueryString.Get("Id")));
      int rbr = Convert.ToInt32((Request.QueryString.Get("Rbr")));
      Prilozi noviPrilog = Helper.GetPrilog(proj, rbr);
    //  Response.ContentType = "application/x-unknown";   a ovom linijom prepznaje jpg i otvara ga s image preglednikom
      //application/vnd.openxmlformats-officedocument.wordprocessingml.document
      string filename = Server.MapPath("~/Dokumenti/Predmeti/" + proj + @"/" + rbr + @"/" + noviPrilog.Opis);
      System.IO.FileInfo fileInfo = new System.IO.FileInfo(filename);
      try
      {
          if (fileInfo.Exists)
          {
              Response.Clear();
              Response.AddHeader("Content-Disposition", "attachment;filename=\"" + fileInfo.Name + "\"");
              Response.AddHeader("Content-Length", fileInfo.Length.ToString());
              Response.ContentType = "application/octet-stream";
              Response.TransmitFile(fileInfo.FullName);
              Response.Flush();
          }
          else
          {
              throw new Exception("File not found");
          }
      }
      catch (Exception ex)
      {
          Response.ContentType = "text/plain";
          Response.Write(ex.Message);
      }
      finally
      {
          Response.End();
      }
    } 
    else
    {
      Response.Redirect("~/");
    }
  }
}
