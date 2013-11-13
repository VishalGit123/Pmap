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
/// Summary description for AddScenariosHelper
/// </summary>
public class AddScenariosHelper
{
   
	public AddScenariosHelper()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    
    public DataSet getbind()
    {
       
        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
       
        SqlCommand cmd = new SqlCommand("GetScenarioData", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return ds;
    }
    public void SetCheck_Status(int Sub_Area_id)
    {
        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        conn.Open();
        SqlCommand cmd = new SqlCommand("update TblSubArea set checked =1 where Subareaid='" + Sub_Area_id + "'", conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
    }
    public void SetUnCheck_Status(int Sub_Area_id)
    {
        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
        conn.Open();
        SqlCommand cmd = new SqlCommand("update TblSubArea set checked =0 where Subareaid='" + Sub_Area_id + "'", conn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
    }
    public DataSet GetSubAreaDropDown()
    {
        string selectSQL = "select SubAreaId,SubAreaName from dbo.TblSubArea where checked=1";
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
    public DataSet GettypeScenariosDropDown()
    {
        string selectSQL = "select SC_Typeid,SC_TypeName from tblScenarioType";
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
    public void connectionclose()
    {
 
    }

    public int UpdateSenarios(int strsubareatype_id, string strsubareatype_text, int strSenarioType_id, string strSenarioType_Text, string strscenario, string strstatus)
    {
        int i = 0;
        try
        {
            Connect con = new Connect();
            SqlConnection conn = con.getconnection();

            SqlCommand cmd = new SqlCommand("SaveScenarios_SP", conn);
            cmd.Parameters.Add("@Scname", SqlDbType.NVarChar, 500).Value = strscenario;
            cmd.Parameters.Add("@scTypeId", SqlDbType.Int, 200).Value = strSenarioType_id;
            cmd.Parameters.Add("@Subarea_id", SqlDbType.Int, 200).Value = strsubareatype_id;
            cmd.Parameters.Add("@status", SqlDbType.NVarChar, 500).Value = strstatus;
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            conn.Close();
            i = 1;
        }
        catch(Exception ex)
        {
            i = 0;
        }
       
        return i;

    }

}

