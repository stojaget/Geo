using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace Geodezija
{
    /// <summary>
    /// Summary description for DownloadFile
    /// </summary>
    public class DownloadFile : IHttpHandler
    {
        string filename = "";
        public void ProcessRequest(HttpContext context)
        {
            string file = "";
      if ( context.Request.QueryString["vrstaPoziva"]== "KlPrilozi")
	{
		  filename = context.Server.MapPath("~/Dokumenti/Klijenti/" + file);
	}
      else
      {
           filename = context.Server.MapPath("~/Dokumenti/Predmeti/" + file);
      }
            // get the file name from the querystring
            if (context.Request.QueryString["fileName"] != null)
            {
                file = context.Request.QueryString["fileName"].ToString();
            }

            
            System.IO.FileInfo fileInfo = new System.IO.FileInfo(filename);

            try
            {
                if (fileInfo.Exists)
                {
                    context.Response.Clear();
                    context.Response.AddHeader("Content-Disposition", "attachment;filename=\"" + fileInfo.Name + "\"");
                    context.Response.AddHeader("Content-Length", fileInfo.Length.ToString());
                    context.Response.ContentType = "application/octet-stream";
                    context.Response.TransmitFile(fileInfo.FullName);
                    context.Response.Flush();
                }
                else
                {
                    throw new Exception("File not found");
                }
            }
            catch (Exception ex)
            {
                context.Response.ContentType = "text/plain";
                context.Response.Write(ex.Message);
            }
            finally
            {
                context.Response.End();
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}