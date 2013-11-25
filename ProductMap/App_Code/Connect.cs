using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using Excel = Microsoft.Office.Interop.Excel;



using Office = Microsoft.Office.Core;
using System.Reflection;

/// <summary>
/// Summary description for Connect
/// </summary>
public class Connect
{
    SqlConnection con;
    string constr = "Data Source=VISHAL-PC\\VISHAL;Initial Catalog=ProductMap;Integrated Security=True";
    public string GetConstring()
    {
        string constr = "Data Source=VISHAL-PC\\VISHAL;Initial Catalog=ProductMap;Integrated Security=True";
        return constr;
    }
	public Connect()
	{
       
        
	}
    public void CreateConnection()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ApplicationServices"].ToString());
        
        
    }
    public SqlConnection getconnection()
    {
        SqlConnection con = new SqlConnection(constr);
        return con;
    }
    public DataSet getdata()
    {
        
        SqlConnection con = new SqlConnection(constr);
        DataSet ds = new DataSet();
        string str = "select Root_id,root_name from tblroot";
        SqlCommand cmd = new SqlCommand(str, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        return ds;
 
    }
    public DataSet GetScenarios()
    {
        SqlConnection con = getconnection();
        DataSet ds = new DataSet();
        string str = "SELECT [SC_id],[SC_Name],[SCType_Id],[TagName]FROM [ProductMap].[dbo].[tblScenarioName]";
        SqlCommand cmd = new SqlCommand(str, con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        return ds;
    }
    public DataSet GetSearchScenarios(string strtagname, string scenario)
    {
        SqlConnection con = getconnection();
        DataSet ds = new DataSet();

        SqlCommand cmd = new SqlCommand("GetSearchScenarios_SP", con);
        cmd.Parameters.Add("@strtagname", SqlDbType.NVarChar, 200).Value = strtagname;
        cmd.Parameters.Add("@scenario", SqlDbType.NVarChar, 500).Value = scenario;
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        return ds;
    }
    public DataSet ImportExcel(string excelpath, string sheetname,string lastexcelname)
    {
        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        SqlCommand cmd = new SqlCommand("GetExcelDataToImport_SP", conn);
        cmd.Parameters.Add("@datafile", SqlDbType.NVarChar, 200).Value = excelpath;
        cmd.Parameters.Add("@sheetpath", SqlDbType.NVarChar, 200).Value = sheetname;
        cmd.Parameters.Add("@lastexcelfilename", SqlDbType.NVarChar, 200).Value = lastexcelname;
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return ds;

    }
    public void updateTree()
    {
        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        SqlCommand cmd = new SqlCommand("DirTree", conn);
        string folderpath="D:\\Excelfolder";
        cmd.Parameters.Add("@Folder", SqlDbType.NVarChar, 200).Value = folderpath;
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
    }
    public DataSet CreateFilelist()
    {
        Connect con = new Connect();
        con.updateTree();
        SqlConnection conn = con.getconnection();
        SqlCommand cmd = new SqlCommand("GetListOfExcelfile_SP", conn);
        //cmd.Parameters.Add("@Areaename", SqlDbType.NVarChar, 200).Value = strareaname;
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        DataSet ds2 = new DataSet();
        da.Fill(ds);
        conn.Close();
        
        List<string> listsheet = new List<string>();
        int countexcel = ds.Tables[0].Rows.Count;
        for (int i = 0; i < countexcel; i++)
        {
            string excelfilename = ds.Tables[0].Rows[i][0].ToString();
            string lastexcelname = excelfilename.Substring(excelfilename.LastIndexOf('\\') + 1);

            listsheet = getAllWorksheetsInExcel(excelfilename);
            
            int countlistsheet=listsheet.Count;
            for(int j=0;j<countlistsheet;j++)
            {
               ds2= ImportExcel(excelfilename, listsheet[j].ToString()+'$', lastexcelname);
            }
        }
        return ds2;

    }
    public List<string> getAllWorksheetsInExcel(string excelFile)
    {
        Excel.Application app = new Excel.Application();
        Excel.Workbook workbook = app.Workbooks.Open(excelFile,
            Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing,
            Type.Missing, Type.Missing, Type.Missing, Type.Missing, Type.Missing,
            Type.Missing, Type.Missing, Type.Missing, Type.Missing);

        List<string> excelSheets = new List<string>();
        foreach (Excel.Worksheet worksheet in app.Worksheets)
        {
            Excel.Range cell1 = (Excel.Range)worksheet.get_Range("A1", "A1");
            Excel.Range cell2 = (Excel.Range)worksheet.get_Range("B1", "B1");
            if (cell1.Value2 != null && cell2.Value2!=null)
            {
                excelSheets.Add(worksheet.Name.ToString());
                releaseObject(worksheet);
            }
        }
        app.Quit();
        releaseObject(app);
        releaseObject(workbook);

        return excelSheets;
    }
    public int DeleteSheetin_Excel(string strpath, string sheetname)
    {
        int flag = 1;
        Excel.Application excelApp = new Excel.ApplicationClass();
        string myPath = strpath;
        //Open the excel file.
        excelApp.Workbooks.Open(myPath, Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value);

        excelApp.DisplayAlerts = false;
        for (int i = excelApp.ActiveWorkbook.Worksheets.Count; i > 0; i--)
        {

            Excel._Worksheet ws = (Excel._Worksheet)excelApp.Workbooks[1].Worksheets[i];

            if (ws.Name == sheetname)
            {
                ws.Delete();

            }
        }

        excelApp.ActiveWorkbook.Save();

        excelApp.DisplayAlerts = false;
        //Save As the excel file.
        excelApp.ActiveWorkbook.SaveAs(strpath);
        excelApp.DisplayAlerts = true;
        //Quit the Application.
        excelApp.Quit();
        return flag;

    }
    public int CreateSheetin_Excel(string strpath, string sheetname)
    
    {
        int flag = 1;

        //Instantiate the Application object.
        Excel.Application excelApp = new Excel.ApplicationClass();
        string myPath = strpath;
        //Open the excel file.
        excelApp.Workbooks.Open(myPath, Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value,
        Missing.Value, Missing.Value);

        //Declare a Worksheet object.
        Excel.Worksheet newWorksheet;

        //Add a worksheet to the workbook.
       newWorksheet = (Excel.Worksheet)excelApp.Worksheets.Add(Missing.Value, Missing.Value, Missing.Value, Missing.Value);
       newWorksheet.Name = sheetname;
       excelApp.Cells.set_Item(1, 1, "Sr no");
       excelApp.Cells.set_Item(1, 2, "Scenarios");
       excelApp.Cells.set_Item(1, 3, "Result");
        //Activate the first worksheet by default.
        excelApp.ActiveWorkbook.Save();

        excelApp.DisplayAlerts = false;
        //Save As the excel file.
        excelApp.ActiveWorkbook.SaveAs(strpath);
        excelApp.DisplayAlerts = true;
        //Quit the Application.
        excelApp.Quit();
        return flag;
    }
    private void releaseObject(object obj)
    {
        try
        {
            System.Runtime.InteropServices.Marshal.ReleaseComObject(obj);
            obj = null;
        }
        catch (Exception ex)
        {
           
            obj = null;
        }
        finally
        {
            GC.Collect();
        }
    }
    public int UncheckTreeOnload()
    {
        Connect con = new Connect();
        

        SqlConnection conn = con.getconnection();
        conn.Open();
        SqlCommand cmd = new SqlCommand("UpdateTree_statusOnLoad_SP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.ExecuteNonQuery();
        conn.Close();
        return 1;
    }
    public DataSet GetLoginDetail(string UserName, string password)
    {
        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        SqlCommand cmd = new SqlCommand("GetLoginDetail_SP", conn);
        cmd.Parameters.Add("@Username", SqlDbType.NVarChar, 200).Value = UserName;
        cmd.Parameters.Add("@password", SqlDbType.NVarChar, 200).Value = password;
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return ds;
    }


}