using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class LoginPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnlogin_Click(object sender, EventArgs e)
    {
        Connect conobj = new Connect();
        string username = txtLogin.Text;
        string psw = txtpsw.Text;
        DataSet ds = conobj.GetLoginDetail(username,psw);
        if (ds.Tables[0].Rows.Count != 0)
        {
            Response.Redirect("Default.aspx");
        }
        else
        {
            lblmsg.Text = "Incorrect user name password";

        }

    }
}