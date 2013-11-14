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


public partial class AddSubModule : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
           
            Loadmodule();
            loadgrid();
        }
    }
    public void ClearText()
    {
        ddlmodule.SelectedIndex = 0;
        txtsubmodule.Text = "";
    }
    public void loadgrid()
    {
        AddSubModuleHelper mobj = new AddSubModuleHelper();
        DataSet ds = new DataSet();
        ds = mobj.ShowsubModule();
        grdsubmodule.DataSource = ds;
        grdsubmodule.DataBind();

        grdsubmodule.HeaderRow.Cells[1].Visible = false;
        int countrow = ds.Tables[0].Rows.Count;
        for (int i = 1; i <= countrow; i++)
        {
            grdsubmodule.Rows[i - 1].Cells[1].Visible = false;
        }
 
    }
    protected void btnadd_Click(object sender, EventArgs e)
    {
        try
        {
            int Selectedmodule_id = Convert.ToInt32(ddlmodule.SelectedValue);
            string strsubmodule = txtsubmodule.Text;
            int root_id = Convert.ToInt32(ddlmodule.SelectedValue);
            AddSubModuleHelper SubObj = new AddSubModuleHelper();
            int flag= SubObj.SaveSubModule(Selectedmodule_id, strsubmodule);

            
            if (flag == 1)
            {
                lblerror.Text = "New Module node created";
                Response.Redirect("AddSubModule.aspx");

            }
            else
            {
                lblerror.Text = "";
            }

        }
        catch (Exception ex)
        {
            lblerror.Text = "Please select valid option " + ex.Message.ToString();
        }
    }
    public void Loadmodule()
    {
        try
        {
            ddlmodule.Items.Clear();
            AddSubModuleHelper ModObj = new AddSubModuleHelper();
            DataSet dsreader = ModObj.GetmoduleaDropDown();
            
           
            ddlmodule.DataSource = dsreader;
            //ddlmodule.Items.Add("--select--");
            ddlmodule.DataTextField = "root_name";
            ddlmodule.DataValueField = "Root_id";
            ddlmodule.DataBind();
           
            ddlmodule.Items.Insert(0, new ListItem("Select", "NA"));
            ddlmodule.SelectedIndex = 0;
             
        }
        catch (Exception err)
        {
            lblerror.Text = err.Message.ToString();
        }
    }
    protected void btnclear_Click(object sender, EventArgs e)
    {
        ClearText();
    }
    protected void grdsubmodule_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)grdsubmodule.Rows[e.RowIndex];
            Connect con = new Connect();
            SqlConnection conn = con.getconnection();
            conn.Open();
            int submoduleid = Convert.ToInt32(row.Cells[1].Text);
            string submodulename = (row.Cells[3].Text);
            SqlCommand cmd = new SqlCommand("Delete_SubModule_SP", conn);
            cmd.Parameters.Add("@subroot_ID", SqlDbType.Int).Value = submoduleid;
            cmd.Parameters.Add("@subroot_name", SqlDbType.NVarChar).Value = submodulename;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            conn.Close();
            loadgrid();
            Response.Redirect("AddSubModule.aspx");
        }
        catch(Exception ex)
        {
            lblerror.Text = ex.Message.ToString();
        }

    }
}