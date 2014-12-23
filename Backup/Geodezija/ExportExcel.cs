using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Aspose.Cells;
using System.Data;

namespace Geodezija
{
    public class ExportExcel
    {

        public DataTable IzvrsiPrimjer()
        {

            //string putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath(@"Predlosci\JNabava_test.xlsx");
            string putanjaOriginal = System.Web.HttpContext.Current.Server.MapPath(@"Predlosci\4.PLAN 2013 SPI - SKG. 30.11..xlsx");

            //Instantiate a new workbook
            Workbook workbook = new Workbook(putanjaOriginal);
            //Get the first worksheet in the workbook
            Worksheet worksheet = workbook.Worksheets[0];

            //Create a datatable
            DataTable export = new DataTable();


            //Export worksheet data to a DataTable object by calling either ExportDataTable or ExportDataTableAsString method of the Cells class		 	
            export = worksheet.Cells.ExportDataTable(0, 0, worksheet.Cells.MaxRow + 1,
                         worksheet.Cells.MaxColumn + 1);

            //int ukupnoRedaka = workbook.Worksheets[0].Cells.MaxDataRow;
            //export = workbook.Worksheets[0].Cells.ExportDataTable(4, 10, ukupnoRedaka, 14, true);

            return export;



        }
    }
}
