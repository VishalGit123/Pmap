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

public partial class AdvanceSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTree();
            bind();
            UncheckTreeOnload();
        }
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
    public void bind()
    {

        AddScenariosHelper adscobj = new AddScenariosHelper();
        DataSet ds = new DataSet();
        ds = adscobj.getbind();

        if (ds.Tables[0].Rows.Count > 0)
        {
            grdsearch.DataSource = ds;
            grdsearch.DataBind();
        }
        else
        {
            ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());
            grdsearch.DataSource = ds;
            grdsearch.DataBind();
            int columncount = grdsearch.Rows[0].Cells.Count;
            grdsearch.Rows[0].Cells.Clear();
            grdsearch.Rows[0].Cells.Add(new TableCell());
            grdsearch.Rows[0].Cells[0].ColumnSpan = columncount;
            grdsearch.Rows[0].Cells[0].Text = "No Records Found";
        }

        //Session.Clear();
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

        else if (e.Node.Checked == false)
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
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        Connect conclass = new Connect();
        string strtagname = txttagname.Text;
        string strscenario = txtscenario.Text;
        DataSet dssearch = new DataSet();
        dssearch = conclass.GetSearchScenarios(strtagname, strscenario);
        grdsearch.DataSource = dssearch;
        grdsearch.DataBind();
    }
    protected void grdsearch_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        grdsearch.PageIndex = e.NewSelectedIndex;
        bind();
    }
}