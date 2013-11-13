<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true" CodeFile="AdvanceSearch.aspx.cs" Inherits="AdvanceSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 292px;
        }
        .style3
        {
            width: 137px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_left" Runat="Server">
    <div>
      <script language="javascript" type="text/javascript">
          function postbackOnCheck() {
              var o = window.event.srcElement;
              if (o.tagName == 'INPUT' && o.type == 'checkbox' && o.name != null && o.name.indexOf('CheckBox') > -1)
              { __doPostBack("", ""); }
          }  
</script>  
   <asp:TreeView ID="TreeView1" runat="server" ImageSet="WindowsHelp" onclick="postbackOnCheck()"
                    onselectednodechanged="TreeView1_SelectedNodeChanged" ontreenodecheckchanged="TreeView1_TreeNodeCheckChanged" 
                    >
                    <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                    <NodeStyle Font-Names="Tahoma" Font-Size="11pt" ForeColor="Black" 
                        HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="1px" />
                    <ParentNodeStyle Font-Bold="False" />
                    <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" 
                        HorizontalPadding="0px" VerticalPadding="0px" />
                </asp:TreeView>
   </div>
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
                <asp:Label ID="Label1" runat="server" Text="Tag Name"></asp:Label>
            </td>
            <td class="style2">
                <asp:TextBox ID="txttagname" runat="server" Width="156px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                <asp:Label ID="Label2" runat="server" Text="Scenario"></asp:Label>
            </td>
            <td class="style2">
                <asp:TextBox ID="txtscenario" runat="server" Height="85px" TextMode="MultiLine" 
                    Width="370px"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
        </tr>
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
                &nbsp;</td>
            <td class="style2">
                <asp:Button ID="btnsearch" runat="server" onclick="btnsearch_Click" 
                    Text="Search" />
                <asp:Button ID="cancel" runat="server" Text="Cancel" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style2">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>

</div>
    <div>
        <asp:GridView ID="grdsearch" runat="server" CellPadding="4" ForeColor="#333333" 
            GridLines="None" AllowPaging="True" AllowSorting="True" 
            BorderColor="Black" onselectedindexchanging="grdsearch_SelectedIndexChanging" 
            Width="100%">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
      </div>
</asp:Content>

