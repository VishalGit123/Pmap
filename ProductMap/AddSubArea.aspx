<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddSubArea.aspx.cs" Inherits="AddSubArea" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 327px;
        }
        .style3
        {
            width: 169px;
        }
        .style4
        {
            width: 139px;
        }
    </style>
    <script type="text/javascript">
        function ValidateDropDown() {

            if (Page_ClientValidate() == true) {

                var cmbID1 = "<%=ddlmodule.ClientID %>";
                var cmbID2 = "<%=ddlsubmodule.ClientID %>";
                var cmbID3 = "<%=ddlarea.ClientID %>";


                if (document.getElementById(cmbID1).selectedIndex == 0) {
                    alert("Please select a module Value");
                    return false;
                }
                else if (document.getElementById(cmbID2).selectedIndex == 0) {
                    alert("Please select a Submodule Value");
                    return false;

                }
                else if (document.getElementById(cmbID3).selectedIndex == 0) {
                    alert("Please select a Area Value");
                    return false;
                }
            }
            return true;
        }

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPH_body" Runat="Server">
<div>
<table class="style1">
        <tr>
            <td class="style4">
                &nbsp;</td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4">
                <asp:Label ID="Label2" runat="server" Text="Select Root"></asp:Label>
            </td>
            <td class="style3">
                <asp:DropDownList ID="ddlmodule" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="ddlmodule_SelectedIndexChanged" 
                    ValidationGroup="r2">
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4">
                <asp:Label ID="Label3" runat="server" Text="Select Sub Root"></asp:Label>
            </td>
            <td class="style3">
                <asp:DropDownList ID="ddlsubmodule" runat="server" 
                    onselectedindexchanged="ddlsubmodule_SelectedIndexChanged" 
                    AutoPostBack="True" ValidationGroup="r2">
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4">
                <asp:Label ID="Label4" runat="server" Text="Select Area"></asp:Label>
            </td>
            <td class="style3">
                <asp:DropDownList ID="ddlarea" runat="server" 
                    onselectedindexchanged="ddlarea_SelectedIndexChanged" ValidationGroup="r2">
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4">
                Enter
                SubArea</td>
            <td class="style3">
                <asp:TextBox ID="txtsubarea" runat="server"></asp:TextBox>
            </td>
            <td class="style2">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtsubarea" ErrorMessage="*" Font-Bold="True" 
                    ForeColor="Red" ValidationGroup="r2"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style4">
                &nbsp;</td>
            <td class="style3">
                <asp:Button ID="btnadd" runat="server" onclick="btnadd_Click" Text="Add" 
                    ValidationGroup="r2" OnClientClick="javascript:return ValidateDropDown();"  />
                <asp:Button ID="btnclear" runat="server" Text="Clear" 
                    onclick="btnclear_Click" />
            </td>
            <td class="style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="3">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4">
              
  
              
            </td>
            <td class="style3">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</div>
<div>
    <asp:GridView ID="grdsubarea" runat="server" 
        onrowdeleting="grdsubarea_RowDeleting">
        <Columns>
            <asp:CommandField ButtonType="Image" DeleteImageUrl="~/IMG/delete.jpg" 
                ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
</div>
<div>
<asp:Label ID="lbleror" runat="server"></asp:Label>
</div>
        

</asp:Content>

