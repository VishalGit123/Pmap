<%@ Page Title="" Language="C#" MasterPageFile="~/Site2.master" AutoEventWireup="true" CodeFile="UploadExcel.aspx.cs" Inherits="UploadExcel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_left" Runat="Server">
    <div>
            <asp:TreeView ID="TreeView1" runat="server" ImageSet="WindowsHelp" 
                onclick="postbackOnCheck()" 
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
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Upload Excel" />
    <div>
        <asp:GridView ID="gridscimport" runat="server">
        </asp:GridView>
    </div>
</asp:Content>

