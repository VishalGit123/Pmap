using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Drawing;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
/// <summary>

/// <summary>
/// Summary description for AddSubModuleHelper
/// </summary>
public class AddSubModuleHelper
{
	public AddSubModuleHelper()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public int SaveSubModule(int moduleid, string stsubmodulename)
    {
        int flag = 1;

        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
             
        SqlCommand cmd = new SqlCommand("Save_SubModule_SP", conn);
        cmd.Parameters.Add("@submodulename", SqlDbType.NVarChar, 200).Value = stsubmodulename;
        cmd.Parameters.Add("@moduleid", SqlDbType.Int).Value = moduleid;

        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return flag;

    }
    public DataSet ShowsubModule()
    {
        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        conn.Open();
        SqlCommand cmd = new SqlCommand("GET_SUBMODULEData_SP", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return ds;
    }
    public DataSet GetmoduleaDropDown()
    {
        
        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        conn.Open();
        SqlCommand cmd = new SqlCommand("GET_MODULEDDL_SP", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return ds;
    }
    public DataSet GetSUBModuleaDropDown(int Selectedmodule_id)
    {
        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        conn.Open();
        SqlCommand cmd = new SqlCommand("GETSUBMODULEDDL_SP", conn);
        cmd.Parameters.Add("@SELECTED_MODULE_ID", SqlDbType.NVarChar, 200).Value = Selectedmodule_id;
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return ds;
    }
    public DataSet GetAreaDropDown(int Selectedsubmodule_id)
    {
        string selectSQL = "SELECT [Area_id],[Areaname] FROM [tblArea] where Subrootid='" + Selectedsubmodule_id + "'";
        Connect con = new Connect();

        SqlConnection conn = con.getconnection();
        conn.Open();
        SqlCommand cmd = new SqlCommand(selectSQL, conn);


        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return ds;
    }
    
}