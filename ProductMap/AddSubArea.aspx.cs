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

public partial class AddSubArea : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            Loadmodule();
            Loadgrid();

        }
    }
    public void Loadgrid()
    {
        AddAreaHelper mobj = new AddAreaHelper();
        DataSet ds = new DataSet();
        ds = mobj.ShowSUBArea();
        grdsubarea.DataSource = ds;
        grdsubarea.DataBind();
    }
   
    protected void btnadd_Click(object sender, EventArgs e)
    {
         try
        {
            Page.Validate();
            int Selectedmodule_id = Convert.ToInt32(ddlmodule.SelectedValue);
            int SelectedSubmodule_id = Convert.ToInt32(ddlsubmodule.SelectedValue);
            int SelectedArea_id = Convert.ToInt32(ddlarea.SelectedValue);
            string strsubsubarea = txtsubarea.Text;

            AddAreaHelper areobj = new AddAreaHelper();
            int flag = areobj.SaveSubArea(SelectedArea_id, strsubsubarea);
            Connect conobj = new Connect();

            string rootname = ddlmodule.SelectedItem.Text;
            string subrootname = ddlsubmodule.SelectedItem.Text;
             string areaname=ddlarea.SelectedItem.Text;
             string subareaname = txtsubarea.Text;
             string strpath = "D:\\Excelfolder" + "\\" + rootname + "\\" + subrootname + "\\" + areaname;
             int flag_createsheet = conobj.CreateSheetin_Excel(strpath, subareaname);


            if (flag == 1 && flag_createsheet==1)
            {
               
                Response.Redirect("AddSubArea.aspx");
                lbleror.Text = areaname + " New Module node created";
            }
            else
            {
                lbleror.Text = "";
            }

        }
        catch (Exception ex)
        {
            lbleror.Text =  "Please select valid option " + ex.Message.ToString();
        }
    }
    
    public void ClearText()
    {

        txtsubarea.Text = "";
    }
    public void Loadmodule()
    {
        try
        {
            ddlmodule.Items.Clear();
            AddSubModuleHelper ModObj = new AddSubModuleHelper();
            DataSet dsreader = ModObj.GetmoduleaDropDown();

           // ddlmodule.Items.Add("--select--");
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
    protected void ddlmodule_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlmodule.SelectedIndex != 0)
        {
            int Selectedmodule_id = Convert.ToInt32(ddlmodule.SelectedValue);
            LoadSubmodule(Selectedmodule_id);
        }
    }
    public void LoadSubmodule(int Selectedmodule_id)
    {
        try
        {
            ddlsubmodule.Items.Clear();
            AddSubModuleHelper ModObj = new AddSubModuleHelper();
            DataSet dsreader = ModObj.GetSUBModuleaDropDown(Selectedmodule_id);

           // ddlsubmodule.Items.Add("--select--");
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
    public void LoadArea(int SelectedSubmodule_id)
    {
        try
        {
            ddlarea.Items.Clear();
            AddSubModuleHelper ModObj = new AddSubModuleHelper();
            DataSet dsreader = ModObj.GetAreaDropDown(SelectedSubmodule_id);

          //  ddlarea.Items.Add("--select--");
            ddlarea.DataSource = dsreader;

            ddlarea.DataTextField = "Areaname";
            ddlarea.DataValueField = "Area_id";
            ddlarea.DataBind();
            ddlarea.Items.Insert(0, new ListItem("Select", "NA"));

        }
        catch (Exception err)
        {
            lbleror.Text = err.Message.ToString();
        }
    }
    protected void ddlsubmodule_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsubmodule.SelectedIndex != 0)
        {
            int Selectedsubmodule_id = Convert.ToInt32(ddlsubmodule.SelectedValue);
            LoadArea(Selectedsubmodule_id);
        }

    }


    protected void btnclear_Click(object sender, EventArgs e)
    {
        ClearText();
    }
    protected void ddlarea_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void grdsubarea_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)grdsubarea.Rows[e.RowIndex];
            Connect con = new Connect();
            SqlConnection conn = con.getconnection();
            conn.Open();
            int subareaid = Convert.ToInt32(row.Cells[7].Text);
            string subareaname = (row.Cells[8].Text);


            SqlCommand cmd = new SqlCommand("Delete_SUBAREA_SP", conn);
            cmd.Parameters.Add("@SubAreaId", SqlDbType.Int).Value = subareaid;
           // cmd.Parameters.Add("@subroot_name", SqlDbType.NVarChar).Value = subareaname;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            conn.Close();
            Connect conobj = new Connect();
            string strpath = "D:\\Excelfolder" + "\\" + row.Cells[2].Text + "\\" + row.Cells[4].Text + "\\" + row.Cells[6].Text;
            int flagd = conobj.DeleteSheetin_Excel(strpath, row.Cells[8].Text);

            Loadgrid();
            if (flagd == 1)
            {
                Response.Redirect("AddSubArea.aspx");
            }
        }

        catch (Exception ex)
        {
            lbleror.Text = ex.Message.ToString();
        }

       
    }
}