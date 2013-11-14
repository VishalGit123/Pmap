using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class CreateTree_Node : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       // ClearText();
        if (!Page.IsPostBack)
        {
            LoadGrid();
        }
        
    }
    public void ClearText()
    {
        txtmodule.Text = "";
    }
    protected void btnadd_Click(object sender, EventArgs e)
    {
        try
        {
            string strmodule = txtmodule.Text;
            Add_Module mobj = new Add_Module();
            int flag=mobj.SaveModule(strmodule);
            if (flag == 1)
            {
                lblerror.Text = "New Module node created";
                Response.Redirect("CreateTree_Node.aspx");
                LoadGrid();
            }
            else
            {
                lblerror.Text = "";
            }

        }
        catch (Exception ex)
        {
            lblerror.Text = ex.Message.ToString();
        }
    }
    protected void btnclear_Click(object sender, EventArgs e)
    {

        ClearText();

    }
    public void LoadGrid()
    {
        Add_Module mobj = new Add_Module();
        DataSet ds = new DataSet();
        ds = mobj.ShowModule();
        Grdmodule.DataSource = ds;
              Grdmodule.DataBind();
              //Grdmodule.Columns[1].Visible = false;
              Grdmodule.HeaderRow.Cells[1].Visible = false;
              int countrow = ds.Tables[0].Rows.Count;
              for (int i = 1; i <= countrow; i++)
              {
                  Grdmodule.Rows[i-1].Cells[1].Visible = false;
              }
      
    }
    protected void Grdmodule_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)Grdmodule.Rows[e.RowIndex];
            Connect con = new Connect();
            SqlConnection conn = con.getconnection();
            conn.Open();
            int moduleid = Convert.ToInt32(row.Cells[1].Text);
            SqlCommand cmd = new SqlCommand("Delete_Module_SP", conn);
            cmd.Parameters.Add("@moduleid", SqlDbType.Int).Value = moduleid;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            conn.Close();
            LoadGrid();
            Response.Redirect("CreateTree_Node.aspx");
        }
        catch(Exception ex)
        {
            lblerror.Text = "Please make sure sub node is deleted "+ex.Message.ToString();
 
        }
        
    }
       
       
    }
