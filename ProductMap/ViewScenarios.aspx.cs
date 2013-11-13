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

public partial class Default2 : System.Web.UI.Page
{


    private SqlConnection conn = new SqlConnection("Data Source=VISHAL-PC\\VISHAL;Initial Catalog=ProductMap;Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTree();
            bind();
            UncheckTreeOnload();

        }
        //ShowScenarios();
    }
    public void UncheckTreeOnload()
    {
        Connect conclass = new Connect();
        conclass.UncheckTreeOnload();
    }
    public void LoadTree()
    {
          DataSet ds = RunQuery("Select Root_id,root_name from tblroot");
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                TreeNode root = new TreeNode(ds.Tables[0].Rows[i][1].ToString(), ds.Tables[0].Rows[i][0].ToString());
                root.SelectAction = TreeNodeSelectAction.Expand;
                Createroot(root);
                TreeView1.Nodes.Add(root);
            }
        }
   
    public void ShowScenarios()
    {
        DataSet ds = new DataSet();
        Connect conclass=new Connect ();
        ds = conclass.GetScenarios();
        gridviewscenario.DataSource = ds;
        gridviewscenario.DataBind();
 
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        
        GridViewRow row = (GridViewRow)gridviewscenario.Rows[e.RowIndex];
        conn.Open();
        int sc_id= Convert.ToInt32(row.Cells[0].Text);
        SqlCommand cmd = new SqlCommand("delete FROM tblScenarioName where SC_id='" + sc_id + "'", conn);
        cmd.ExecuteNonQuery();
        conn.Close();
        bind();

       
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        
        gridviewscenario.EditIndex = e.NewEditIndex;
       
        bind();
    }
    public void bind()
    {
        
        AddScenariosHelper adscobj = new AddScenariosHelper();
        DataSet ds = new DataSet();
        ds = adscobj.getbind();
       
        if (ds.Tables[0].Rows.Count > 0)
        {
            gridviewscenario.DataSource = ds;
            gridviewscenario.DataBind();
        }
        else
        {
            ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());
            gridviewscenario.DataSource = ds;
            gridviewscenario.DataBind();
            int columncount = gridviewscenario.Rows[0].Cells.Count;
            gridviewscenario.Rows[0].Cells.Clear();
            gridviewscenario.Rows[0].Cells.Add(new TableCell());
            gridviewscenario.Rows[0].Cells[0].ColumnSpan = columncount;
            gridviewscenario.Rows[0].Cells[0].Text = "No Records Found";
        }

        //Session.Clear();
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        // Pending 


       // GridViewRow row = (GridViewRow)gridviewscenario.Rows[e.RowIndex];
       // //Label lblID = (Label)row.FindControl("sc_id");
       // TextBox txtscid = (TextBox)row.Cells[0].Controls[0];
       // int sc_id = Convert.ToInt32(txtscid.Text);

       // TextBox root_name = (TextBox)row.Cells[5].Controls[0];
       // TextBox subroot_name = (TextBox)row.Cells[6].Controls[0];
       // TextBox Areaname = (TextBox)row.Cells[7].Controls[0];
       // TextBox SubAreaName = (TextBox)row.Cells[8].Controls[0];
       // TextBox SC_id = (TextBox)row.Cells[9].Controls[0];
       // TextBox SC_Name = (TextBox)row.Cells[10].Controls[0];
       // TextBox TagName = (TextBox)row.Cells[11].Controls[0];
       // TextBox status = (TextBox)row.Cells[12].Controls[0];
        
       // string root_name_P = root_name.Text;
       // string subroot_name_P = subroot_name.Text;
       // string Areaname_p = Areaname.Text;
       // string SubAreaName_p = SubAreaName.Text;
       // int SC_id_p = Convert.ToInt32(SC_id.Text);
       // string SC_Name_p = SC_Name.Text;
       // string TagName_p = TagName.Text;
       // string status_p = status.Text;


     
       // gridviewscenario.EditIndex = -1;
       // SqlCommand cmd = new SqlCommand("Update_SC_SP", conn);
       // cmd.Parameters.Add("@root_name_P", SqlDbType.NVarChar, 200).Value = root_name_P;
       // cmd.Parameters.Add("@subroot_name_P", SqlDbType.NVarChar, 200).Value = subroot_name_P;
       // cmd.Parameters.Add("@Areaname_p", SqlDbType.NVarChar, 200).Value = Areaname_p;
       // cmd.Parameters.Add("@SubAreaName_p", SqlDbType.NVarChar, 200).Value = SubAreaName_p;
       // cmd.Parameters.Add("@SC_id_p", SqlDbType.NVarChar, 200).Value = SC_id_p;
       // cmd.Parameters.Add("@SC_Name_p", SqlDbType.NVarChar, 200).Value = SC_Name_p;
       // cmd.Parameters.Add("@TagName_p", SqlDbType.NVarChar, 200).Value = TagName_p;
       // cmd.Parameters.Add("@status_p", SqlDbType.NVarChar, 200).Value = status_p;
       // cmd.CommandType = CommandType.StoredProcedure;

       // conn.Open();
       
       //// SqlCommand cmd = new SqlCommand("update tblScenarioName set SC_Name='" + textName.Text + "',SCType_Id='" + textadd.Text + "',TagName='" + textc.Text + "'where sc_id='" + sc_id + "'", conn);
       // cmd.ExecuteNonQuery();
       // conn.Close();
       // bind();
       
       



    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridviewscenario.PageIndex = e.NewPageIndex;
        bind();
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gridviewscenario.EditIndex = -1;
        bind();
    }
    public void getsc()
    {
       
    }
    void Createroot(TreeNode node)
    {
        DataSet ds = RunQuery("Select Root_id,root_name from tblroot where root_id=" + node.Value);
        if (ds.Tables[0].Rows.Count == 0)
        {
            return;
        }
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            TreeNode tnode = new TreeNode(ds.Tables[0].Rows[i][1].ToString(), ds.Tables[0].Rows[i][0].ToString());
            tnode.SelectAction = TreeNodeSelectAction.Expand;
            node.ChildNodes.Add(tnode);
            Createsubroot(tnode);
        }

    }
    void Createsubroot(TreeNode node)
    {
        DataSet ds = RunQuery("Select subroot_id,subroot_name from tblSubroot where root_id=" + node.Value);
        if (ds.Tables[0].Rows.Count == 0)
        {
            return;
        }
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            TreeNode tnode = new TreeNode(ds.Tables[0].Rows[i][1].ToString(), ds.Tables[0].Rows[i][0].ToString());
            tnode.SelectAction = TreeNodeSelectAction.Expand;
            node.ChildNodes.Add(tnode);
            CreateArea(tnode);
        }

    }
    void CreateArea(TreeNode node)
    {
        DataSet ds = RunQuery("Select area_id,areaname from tblarea where subrootid=" + node.Value);
        if (ds.Tables[0].Rows.Count == 0)
        {
            return;
        }
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            TreeNode tnode = new TreeNode(ds.Tables[0].Rows[i][1].ToString(), ds.Tables[0].Rows[i][0].ToString());
            tnode.SelectAction = TreeNodeSelectAction.Expand;
            node.ChildNodes.Add(tnode);
            CreateSUBArea(tnode);
        }

    }
    void CreateSUBArea(TreeNode node)
    {
        DataSet ds = RunQuery("Select SubAreaId,SubAreaName from TblSubArea where AreaId=" + node.Value);
        if (ds.Tables[0].Rows.Count == 0)
        {
            return;
        }
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            TreeNode tnode = new TreeNode(ds.Tables[0].Rows[i][1].ToString(), ds.Tables[0].Rows[i][0].ToString());
            tnode.SelectAction = TreeNodeSelectAction.Expand;
            node.ChildNodes.Add(tnode);
            tnode.ShowCheckBox = true;


            //CreatetblScenarios(tnode);
        }

    }
    void CreatetblScenarios(TreeNode node)
    {
        DataSet ds = RunQuery("Select SC_id,SC_Name from tblScenarioName where subareaid=" + node.Value);
        if (ds.Tables[0].Rows.Count == 0)
        {
            return;
        }
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            TreeNode tnode = new TreeNode(ds.Tables[0].Rows[i][1].ToString(), ds.Tables[0].Rows[i][0].ToString());
            tnode.SelectAction = TreeNodeSelectAction.Expand;
            node.ChildNodes.Add(tnode);
            tnode.Value = ds.Tables[0].Rows[i][1].ToString();
            // CreatetblScenarioType(tnode);
        }

    }
    DataSet RunQuery(String Query)
    {
        DataSet ds = new DataSet();

        String connStr = "Data Source=VISHAL-PC\\VISHAL;Initial Catalog=ProductMap;Integrated Security=True";//write your connection string here;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand objCommand = new SqlCommand(Query, conn);
            SqlDataAdapter da = new SqlDataAdapter(objCommand);
            da.Fill(ds);
            da.Dispose();
        }
        return ds;
    }
    protected void TreeView1_TreeNodeCheckChanged(object sender, TreeNodeEventArgs e)
    {
        if (e.Node.Checked)
        {
            int nodeid = Convert.ToInt32(e.Node.Value);
            string nodename = e.Node.Text.ToString();
            int subareaid = nodeid;
            AddScenariosHelper SCObj = new AddScenariosHelper();
            SCObj.SetCheck_Status(nodeid);
            bind();
        }

        else if (e.Node.Checked==false)
        {
            int nodeid = Convert.ToInt32(e.Node.Value);
            string nodename = e.Node.Text.ToString();
            int subareaid = nodeid;
            AddScenariosHelper SCObj = new AddScenariosHelper();
            SCObj.SetUnCheck_Status(nodeid);
            bind();
        }
    }
    protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
    {

    }
    public void BindAreaTypeDropdown()
    {
 
    }


    protected void btnadd_Click(object sender, EventArgs e)
    {
     

    }

   
}
public partial class mymaster : MasterPage
{
    
}