<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true" CodeFile="InsertScenarios.aspx.cs" Inherits="InsertScenarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 19px;
        }
        .style2
        {
            width: 146px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_body" Runat="Server">
  <script language="javascript" type="text/javascript">
      function postbackOnCheck() {
          var o = window.event.srcElement;
          if (o.tagName == 'INPUT' && o.type == 'checkbox' && o.name != null && o.name.indexOf('CheckBox') > -1)
          { __doPostBack("", ""); }
      }  
</script> 
    <div>
    <table width=100%>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td class="style1">
                &nbsp;</td>
            <td align="left">
                
           
                &nbsp;</td>
        </tr>
        
    </table>
</div>

<div id="Addscenarioarea">
<table>
    <tr>
            <td class="style1">
                <asp:Label ID="Label2" runat="server" Text="Sub Area"></asp:Label>
            </td>
            <td align="left">
                
           
                <asp:DropDownList ID="ddlareatype" runat="server">
                </asp:DropDownList>

            &nbsp;&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="ddlareatype" ErrorMessage="*  Required" Font-Bold="True" 
                    Font-Size="Small" ForeColor="#CC3300"></asp:RequiredFieldValidator>

            </td>
            <td align="left" class="style2">
                
           
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label3" runat="server" Text="Scenario Type"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlscenariotype" runat="server" 
                    onselectedindexchanged="ddlscenariotype_SelectedIndexChanged">
                </asp:DropDownList>
            &nbsp;&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="ddlscenariotype" ErrorMessage="*  Required" Font-Bold="True" 
                    Font-Size="Small" ForeColor="#CC3300"></asp:RequiredFieldValidator>
            </td>
            <td class="style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label4" runat="server" Text="Scenario"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtScenarios" runat="server" Height="59px" TextMode="MultiLine" 
                    Width="552px"></asp:TextBox>
            </td>
            <td class="style2">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="txtScenarios" ErrorMessage="*  Required" Font-Bold="True" 
                    Font-Size="Small" ForeColor="#CC3300"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label5" runat="server" Text="Status"></asp:Label>
            </td>
            <td>
                
           
                <asp:DropDownList ID="ddlstatus" runat="server">
                    <asp:ListItem>PASS</asp:ListItem>
                    <asp:ListItem>FAIL</asp:ListItem>
                </asp:DropDownList>

            </td>
            <td class="style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td class="style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td>
                <asp:Button ID="btnadd" runat="server" onclick="btnadd_Click" Text="Add" />
            </td>
            <td class="style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td>
                <asp:Label ID="lblerror" runat="server" Text=""></asp:Label>
            </td>
            <td class="style2">
                &nbsp;</td>
        </tr>
</table>
</div>
</asp:Content>

<asp:Content ID="Content4" runat="server" contentplaceholderid="CPH_left">
                <asp:TreeView ID="TreeView1" runat="server" ImageSet="WindowsHelp" 
                    onclick="postbackOnCheck()" ontreenodecheckchanged="TreeView1_TreeNodeCheckChanged1" 
                    >
                    <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                    <NodeStyle Font-Names="Tahoma" Font-Size="11pt" ForeColor="Black" 
                        HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="1px" />
                    <ParentNodeStyle Font-Bold="False" />
                    <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" 
                        HorizontalPadding="0px" VerticalPadding="0px" />
                </asp:TreeView>
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </asp:Content>


