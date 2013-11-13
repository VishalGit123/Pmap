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
/// Summary description for AddAreaHelper
/// </summary>
public class AddAreaHelper
{
	public AddAreaHelper()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public int SaveArea(int moduleid, int submodule, string strareaname, string selectedModule, string selectedsubmodule)
    {
        int flag = 1;

        Connect con = new Connect();
        SqlConnection conn = con.getconnection();


        SqlCommand cmd = new SqlCommand("Save_Area_SP", conn);
        
        cmd.Parameters.Add("@Areaename", SqlDbType.NVarChar, 200).Value = strareaname;
        //cmd.Parameters.Add("@moduleid", SqlDbType.Int).Value = moduleid;
        cmd.Parameters.Add("@Submoduleid", SqlDbType.Int).Value = submodule;
        cmd.Parameters.Add("@selectedModule", SqlDbType.NVarChar, 200).Value = selectedModule;
        cmd.Parameters.Add("@selectedsubmodule", SqlDbType.NVarChar, 200).Value = selectedsubmodule;
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return flag;

    }
    public int SaveSubArea( int areaid, string strsubarea)
    {
        int flag = 1;

        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        SqlCommand cmd = new SqlCommand("Save_SubArea_SP", conn);
        cmd.Parameters.Add("@subareaAreaename", SqlDbType.NVarChar, 200).Value = strsubarea;
        //cmd.Parameters.Add("@moduleid", SqlDbType.Int).Value = moduleid;
        cmd.Parameters.Add("@areaid", SqlDbType.Int).Value = areaid;
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return flag;

    }
    public DataSet ShowArea()
    {
        DataSet ds = new DataSet();

        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        SqlCommand cmd = new SqlCommand("ShowArea_SP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        
        da.Fill(ds);
        conn.Close();
        return ds;
    }
    public DataSet ShowSUBArea()
    {
        DataSet ds = new DataSet();

        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        SqlCommand cmd = new SqlCommand("ShowSUBArea_SP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(ds);
        conn.Close();
        return ds;
    }
}