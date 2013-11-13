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

public partial class InsertScenarios : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillAeatype();
            FillScenarios();
            LoadTree();
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

    //protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (CheckBox1.Checked)
    //    {
    //        FillAeatype();
    //        FillScenarios();

    //    }
    //    else if (CheckBox1.Checked == false)
    //    {
    //        ddlareatype.Items.Clear();
    //        ddlscenariotype.Items.Clear();
    //    }
    //}
    public void FillAeatype()
    {
        try
        {
            ddlareatype.Items.Clear();
            AddScenariosHelper schelperobj = new AddScenariosHelper();
            DataSet dsreader = schelperobj.GetSubAreaDropDown();
            ddlareatype.Items.Add("--select--");
            ddlareatype.DataSource = dsreader;

            ddlareatype.DataTextField = "SubAreaName";
            ddlareatype.DataValueField = "SubAreaId";
            ddlareatype.DataBind();

        }
        catch (Exception err)
        {
            lblerror.Text = err.Message.ToString();
        }



    }
    
    public void FillScenarios()
    {
        try
        {
            ddlscenariotype.Items.Clear();
            AddScenariosHelper schelperobj = new AddScenariosHelper();
            DataSet dsreader = schelperobj.GettypeScenariosDropDown();
            ddlscenariotype.Items.Add("--select--");
            ddlscenariotype.DataSource = dsreader;

            ddlscenariotype.DataTextField = "SC_TypeName";
            ddlscenariotype.DataValueField = "SC_Typeid";
            ddlscenariotype.DataBind();

        }
        catch (Exception err)
        {
            lblerror.Text = err.Message.ToString();
        }
    }
    protected void btnadd_Click(object sender, EventArgs e)
    {
        try
        {

            lblerror.Text = "";
            string strsubareatype_text = ddlareatype.SelectedItem.Text;
            int strsubareatype_id = Convert.ToInt32(ddlareatype.SelectedValue);
            string strSenarioType_Text = ddlscenariotype.SelectedItem.Text;
            int strSenarioType_id = Convert.ToInt32(ddlscenariotype.SelectedValue);
            string strscenario = txtScenarios.Text;
            string strstatus = ddlstatus.SelectedValue.ToString();
            AddScenariosHelper schelperobj = new AddScenariosHelper();

            int i=schelperobj.UpdateSenarios(strsubareatype_id, strsubareatype_text, strSenarioType_id, strSenarioType_Text, strscenario, strstatus);
            if (i == 1)
            {
                lblerror.Text = "Scenario added Successfully";
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
    protected void TreeView1_TreeNodeCheckChanged1(object sender, TreeNodeEventArgs e)
    {
        if (e.Node.Checked)
        {
            int nodeid = Convert.ToInt32(e.Node.Value);
            string nodename = e.Node.Text.ToString();
            int subareaid = nodeid;
            AddScenariosHelper SCObj = new AddScenariosHelper();
            SCObj.SetCheck_Status(nodeid);
            FillAeatype();
        }

        else if (e.Node.Checked == false)
        {
            int nodeid = Convert.ToInt32(e.Node.Value);
            string nodename = e.Node.Text.ToString();
            int subareaid = nodeid;
            AddScenariosHelper SCObj = new AddScenariosHelper();
            SCObj.SetUnCheck_Status(nodeid);
            FillAeatype();
        }
    }
    protected void ddlscenariotype_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}