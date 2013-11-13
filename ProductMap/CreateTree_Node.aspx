<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CreateTree_Node.aspx.cs" Inherits="CreateTree_Node" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
    }
    .style3
    {
        width: 285px;
    }
        .style4
        {
            width: 101px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_body" Runat="Server">
<div>
  <table class="style1">
    <tr>
        <td class="style4">
          
        </td>
        <td class="style3">
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style4">
            Module</td>
        <td class="style3">
            <asp:TextBox ID="txtmodule" runat="server"></asp:TextBox>
        </td>
        <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtmodule" ErrorMessage="* Please enter Module name" 
                Font-Bold="True" ForeColor="Red"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style4">
            &nbsp;</td>
        <td class="style3">
            <asp:Button ID="btnadd" runat="server" onclick="btnadd_Click" Text="Add" />
            <asp:Button ID="btnclear" runat="server" Text="Clear" 
                onclick="btnclear_Click" />
            </td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td align="center" class="style2" colspan="3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style4">
            &nbsp;</td>
        <td class="style3">
            <asp:GridView ID="Grdmodule" runat="server" 
                onrowdeleting="Grdmodule_RowDeleting">
                <Columns>
                    <asp:CommandField ButtonType="Image" DeleteImageUrl="~/IMG/delete.jpg" 
                        ShowDeleteButton="True"></asp:CommandField>
                </Columns>
            </asp:GridView>
        </td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style4">
            &nbsp;</td>
        <td class="style3">
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
</table>
</div>
<div>
  <asp:Label ID="lblerror" runat="server"></asp:Label>
</div>
  
</asp:Content>

