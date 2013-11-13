<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddArea.aspx.cs" Inherits="AddArea" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            height: 22px;
        }
        .style3
        {
            width: 175px;
        }
        .style4
        {
            height: 22px;
            width: 175px;
        }
        .style5
        {
            width: 181px;
        }
        .style6
        {
            height: 22px;
            width: 181px;
        }
    </style>

    <script type="text/javascript">
        function ValidateDropDown() {

            if (Page_ClientValidate() == true) {

                var cmbID1 = "<%=ddlmodule.ClientID %>";
                var cmbID2 = "<%=ddlsubmodule.ClientID %>";
              


                if (document.getElementById(cmbID1).selectedIndex == 0) {
                    alert("Please select a module Value");
                    return false;
                }
                else if (document.getElementById(cmbID2).selectedIndex == 0) {
                    alert("Please select a Submodule Value");
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
            <td class="style5">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                .Select module</td>
            <td class="style5">
                <asp:DropDownList ID="ddlmodule" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="ddlmodule_SelectedIndexChanged" 
                    ValidationGroup="m3">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="ddlmodule" ErrorMessage="RequiredFieldValidator" 
                    InitialValue="-1" ValidationGroup="m3" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style3">
                <asp:Label ID="Label3" runat="server" Text="Select Sub-Root"></asp:Label>
            </td>
            <td class="style5">
                <asp:DropDownList ID="ddlsubmodule" runat="server" 
                    onselectedindexchanged="ddlsubmodule_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="ddlsubmodule" ErrorMessage="RequiredFieldValidator" 
                    InitialValue="Select" ValidationGroup="m3"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style3">
                <asp:Label ID="Label4" runat="server" Text="Enter Area"></asp:Label>
            </td>
            <td class="style5">
                <asp:TextBox ID="txtarea" runat="server" ValidationGroup="m3"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtarea" ErrorMessage="Please Enter Area" 
                    ValidationGroup="m3" Font-Bold="True" Font-Size="Small" ForeColor="#CC3300"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style4">
                &nbsp;</td>
            <td class="style6">
                <asp:Button ID="btnadd" runat="server" onclick="btnadd_Click" Text="Add" 
                    ValidationGroup="m3" OnClientClick="javascript:return ValidateDropDown();" />
                <asp:Button ID="Button2" runat="server" Text="Clear" onclick="Button2_Click" />
            </td>
            <td class="style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" colspan="3">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
             
            </td>
            <td class="style5">
                <asp:GridView ID="grdArea" runat="server" onrowdeleting="grdArea_RowDeleting">
                    <Columns>
                        <asp:CommandField ButtonType="Image" DeleteImageUrl="~/IMG/delete.jpg" 
                            ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>


            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style5">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
  </div>
  <div>
     <asp:Label ID="lbleror" runat="server"></asp:Label>
  </div>
</asp:Content>

