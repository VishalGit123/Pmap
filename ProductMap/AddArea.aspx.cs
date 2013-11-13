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

public partial class AddArea : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
            Loadmodule();
            Loadgrid();
 
        }
    }

    public void ClearText()
    {
        txtarea.Text = "";
        //ddlmodule.SelectedIndex = 0;
        //ddlsubmodule.SelectedIndex = 0;
    }
    protected void btnadd_Click(object sender, EventArgs e)
    {
        try
        {
            int Selectedmodule_id = Convert.ToInt32(ddlmodule.SelectedValue);
            int SelectedSubmodule_id = Convert.ToInt32(ddlsubmodule.SelectedValue);
            string strarea = txtarea.Text;

            string selectedModule = ddlmodule.SelectedItem.Text;
            string selectedsubmodule = ddlsubmodule.SelectedItem.Text;
            AddAreaHelper areobj = new AddAreaHelper();

            int flag = areobj.SaveArea(Selectedmodule_id, SelectedSubmodule_id, strarea, selectedModule, selectedsubmodule);
            


            if (flag == 1)
            {
                lbleror.Text = "New Module node created";
                Response.Redirect("AddArea.aspx");
            }
            else
            {
                lbleror.Text = "";
            }

        }
        catch (Exception ex)
        {
            lbleror.Text = "Please select valid option " + ex.Message.ToString ();
        }
    }
    public void Loadgrid()
    {
        AddAreaHelper mobj = new AddAreaHelper();
        DataSet ds = new DataSet();
        ds = mobj.ShowArea();
        grdArea.DataSource = ds;
        grdArea.DataBind();
    }
    public void Loadmodule()
    {
        try
        {
            ddlmodule.Items.Clear();
            AddSubModuleHelper ModObj = new AddSubModuleHelper();
            DataSet dsreader = ModObj.GetmoduleaDropDown();

            //ddlmodule.Items.Add("--select--");
            ddlmodule.DataSource = dsreader;

            ddlmodule.DataTextField = "root_name";
            ddlmodule.DataValueField = "Root_id";
            ddlmodule.DataBind();
            ddlmodule.Items.Insert(0, new ListItem("Select", "NA"));
        }
        catch (Exception err)
        {
            lbleror.Text = err.Message.ToString();
        }
    }
    public void LoadSubmodule(int Selectedmodule_id)
    {
        try
        {
            ddlsubmodule.Items.Clear();
            AddSubModuleHelper ModObj = new AddSubModuleHelper();
            DataSet dsreader = ModObj.GetSUBModuleaDropDown(Selectedmodule_id);

            //ddlsubmodule.Items.Add("--select--");
            ddlsubmodule.DataSource = dsreader;

            ddlsubmodule.DataTextField = "subroot_name";
            ddlsubmodule.DataValueField = "subroot_id";
            ddlsubmodule.DataBind();
            ddlsubmodule.Items.Insert(0, new ListItem("Select", "NA"));

        }
        catch (Exception err)
        {
            lbleror.Text = err.Message.ToString();
        }
    }
    protected void ddlsubmodule_SelectedIndexChanged(object sender, EventArgs e)
    {
       
    }
    protected void ddlmodule_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlmodule.SelectedIndex != 0)
            {
                int Selectedmodule_id = Convert.ToInt32(ddlmodule.SelectedValue);
                LoadSubmodule(Selectedmodule_id);
            }
        }
        catch (Exception ex)
        {
            lbleror.Text = ex.Message.ToString();
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        ClearText();
    }


    protected void grdArea_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
  
//             @subroot_ID INT,  -1  
//@subroot_name nvarchar(200) ,-2
//@AREA_NAME nvarchar(200),-4
//@AREA_ID INT-3

            GridViewRow row = (GridViewRow)grdArea.Rows[e.RowIndex];
            Connect con = new Connect();
            SqlConnection conn = con.getconnection();
            conn.Open();
            int subroot_ID = Convert.ToInt32(row.Cells[2].Text);
            string subroot_name = (row.Cells[3].Text);
            int AREA_ID = Convert.ToInt32(row.Cells[4].Text);
            string AREA_name = (row.Cells[5].Text);

            SqlCommand cmd = new SqlCommand("Delete_AREA_SP", conn);
            cmd.Parameters.Add("@subroot_ID", SqlDbType.Int).Value = subroot_ID;
            cmd.Parameters.Add("@subroot_name", SqlDbType.NVarChar).Value = subroot_name;
            cmd.Parameters.Add("@AREA_ID", SqlDbType.Int).Value = AREA_ID;
            cmd.Parameters.Add("@AREA_NAME", SqlDbType.NVarChar).Value = AREA_name;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            conn.Close();
            Loadgrid();
            Response.Redirect("AddArea.aspx");
        }
        catch (Exception ex)
        {
            lbleror.Text = ex.Message.ToString();
        }

    }
}