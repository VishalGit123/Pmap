<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true" CodeFile="ViewScenarios.aspx.cs" Inherits="Default2" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit.HTMLEditor" tagprefix="cc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 182px;
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
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 100%; height: 100%">
        <asp:GridView ID="gridviewscenario" runat="server" 
            onpageindexchanging="GridView1_PageIndexChanging" 
            onrowcancelingedit="GridView1_RowCancelingEdit" 
            onrowdeleting="GridView1_RowDeleting" onrowediting="GridView1_RowEditing" 
            onrowupdating="GridView1_RowUpdating" CellPadding="4" ForeColor="#333333" 
            GridLines="None" AllowPaging="True" >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>

                 <asp:BoundField DataField="SC_id" HeaderText="SC_id"/>
                <%-- <asp:BoundField DataField="SC_Name" HeaderText="SC_Name" />
                 <asp:BoundField DataField="SCType_Id" HeaderText="SCType_Id" />
                 <asp:BoundField DataField="TagName" HeaderText="TagName" />--%>

                <asp:TemplateField>
                    <EditItemTemplate>
                        
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowSelectButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
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
<div>
</div>



</asp:Content>

<asp:Content ID="Content4" runat="server" contentplaceholderid="CPH_left">
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
                <asp:Label ID="lbleror" runat="server" Text="Label"></asp:Label>
            </asp:Content>


