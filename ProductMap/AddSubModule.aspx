<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddSubModule.aspx.cs" Inherits="AddSubModule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 162px;
        }
        .style3
        {
            width: 148px;
        }
    </style>
    <script type="text/javascript">
        function ValidateDropDown() {

            if (Page_ClientValidate() == true) {

                var cmbID1 = "<%=ddlmodule.ClientID %>";
               


                if (document.getElementById(cmbID1).selectedIndex == 0) {
                    alert("Please select a module Value");
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
            <td class="style3">
                &nbsp;</td>
            <td class="style2">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                <asp:Label ID="Label2" runat="server" Text="Select Root"></asp:Label>
            </td>
            <td class="style2">
                <asp:DropDownList ID="ddlmodule" runat="server" ValidationGroup="m2">
                    <asp:ListItem>Select</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
            
                    &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                <asp:Label ID="Label3" runat="server" Text="Enter SubRoot"></asp:Label>
            </td>
            <td class="style2">
                <asp:TextBox ID="txtsubmodule" runat="server" ValidationGroup="m2"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtsubmodule" 
                    ErrorMessage="* Please select valid Subroot" Font-Bold="True" 
                    ForeColor="Red" ValidationGroup="m2"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style2">
               <asp:Button ID="btnadd" runat="server" onclick="btnadd_Click" Text="Add" 
                    ValidationGroup="m2" OnClientClick="javascript:return ValidateDropDown();" />
            <asp:Button ID="btnclear" runat="server" Text="Clear" onclick="btnclear_Click" 
                    ValidationGroup="m2" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="3" align="center">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
              
            </td>
            <td class="style2">
                <asp:GridView ID="grdsubmodule" runat="server" 
                    onrowdeleting="grdsubmodule_RowDeleting">
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
            <td class="style3">
                &nbsp;</td>
            <td class="style2">
             
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
</div>
<div>
                <asp:Label ID="lblerror" runat="server" Text="Label"></asp:Label>

</div>
    
</asp:Content>

