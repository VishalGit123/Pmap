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
/// Summary description for Add_Module
/// </summary>
public class Add_Module
{
	public Add_Module()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public int SaveModule(string strobject)
    {
        int flag = 1;

        Connect con = new Connect();
        SqlConnection conn = con.getconnection();
       
       // SqlCommand cmd = new SqlCommand("INSERT INTO [tblroot]([root_name])VALUES('"+ strobject +"')" , conn);
        SqlCommand cmd = new SqlCommand("Save_Module_SP", conn);
        cmd.Parameters.Add("@modulename", SqlDbType.NVarChar, 200).Value = strobject;
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return flag;

    }
    public DataSet ShowModule()
    {
       

        Connect con = new Connect();
        SqlConnection conn = con.getconnection();

        // SqlCommand cmd = new SqlCommand("INSERT INTO [tblroot]([root_name])VALUES('"+ strobject +"')" , conn);
        SqlCommand cmd = new SqlCommand("Show_Module_SP", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        conn.Close();
        return ds;
    }
   
}