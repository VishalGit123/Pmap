﻿using System;
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
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Data.SqlClient;
using System.Data.Sql;

public partial class UploadExcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadTree();
        }

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
        Connect connobj = new Connect();
        String connStr = connobj.GetConstring();
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            SqlCommand objCommand = new SqlCommand(Query, conn);
            SqlDataAdapter da = new SqlDataAdapter(objCommand);
            da.Fill(ds);
            da.Dispose();
        }
        return ds;
    }
    protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
    {

    }
    protected void TreeView1_TreeNodeCheckChanged(object sender, TreeNodeEventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        importdatafromexcel("D:\\ImportExcel.xlsx");
    }
    public void importdatafromexcel(string excelfilepath)
    {
    }
    
protected void  Button1_Click(object sender, EventArgs e)
{

        Connect conobj = new Connect();
        DataSet ds = new DataSet();
        ds = conobj.CreateFilelist();

    //    ds = conobj.ImportExcel();
        gridscimport.DataSource = ds;
        gridscimport.DataBind();
   
}
}
   
