using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
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
        //if (Page.IsPostBack == false)
        //{
        //    Connect c = new Connect();
        //    DataSet ds = new DataSet();
        //    ds = c.getdata();
        //    TreeView1.DataSource = ds;
        //    TreeView1.DataBind();
        //}

    protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
    {
        if (TreeView1.SelectedNode.Checked == true)
        {
            string str = TreeView1.SelectedNode.Text;
        }

    }
    protected void TreeView1_TreeNodeCheckChanged(object sender, TreeNodeEventArgs e)
    {
        //if (e.Node.ChildNodes.Count > 0)//if parent node
        //{
        if (e.Node.Checked)
        {
            int nodeid = Convert.ToInt32(e.Node.Value);
            string nodename = e.Node.Text.ToString();

            Session["sctype_id"] = e.Node.Value.ToString();
            Session["sctype_name"] = e.Node.Value.ToString();

        }

        else
        {

        }
                
        //}

    }
    private void ChangeChecked(TreeNode node, bool check)
    {
        // "Queue" up child nodes to be checked or unchecked.
        if (node.ChildNodes.Count > 0)
        {
            for (int i = 0; i < node.ChildNodes.Count; i++)
                ChangeChecked(node.ChildNodes[i], check);
        }

        node.Checked = check;
    }
}
