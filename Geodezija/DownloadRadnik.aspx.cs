using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Geodezija
{
    public partial class DownloadRadnik : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
              if (Request.QueryString.Get("Id") != null)
            {
                int proj = Convert.ToInt32((Request.QueryString.Get("Id")));
                int rbr = Convert.ToInt32((Request.QueryString.Get("Rbr")));
                RadPrilozi noviPrilog = Helper.GetRadnikPrilog(proj, rbr);
                string filename = Server.MapPath("~/Dokumenti/Radnici/" + proj + @"/" + rbr + @"/" + noviPrilog.Opis);
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

                //Response.WriteFile(Path.Combine("~/Dokumenti/Klijenti/", noviPrilog.Putanja));

            }
            else
            {
                Response.Redirect("~/");
            }
        }
        }
    }
