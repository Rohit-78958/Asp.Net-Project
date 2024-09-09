<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Screen2.aspx.cs" Inherits="Evaluation.Screen2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/Screen2.css" rel="stylesheet" />

    <style>
        .tblListView tbody tr td{
            border: 1px solid #ddd;
            border-collapse: collapse;
        }

        .tblListView{
           border-spacing: 0px;
        }
        .contols tbody tr td{
             border: 1px solid #ddd;
             border-collapse: collapse;
        }
        .contols{
            border-spacing: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="header">
                <asp:Image ID="Amitlogo" ClientIDMode="Static" ImageUrl="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9jEFAfciW6ZuygNvbT2nQSy2q2h1RttkoZA&s" Width="100px" runat="server" />
                <h2>TPM-TRAK ANALYTICS</h2>
                <div class="side-stuff">
                    <asp:ImageButton CausesValidation="false" ID="zoomLogo" ImageUrl="~/Images/zoom_out_map_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24 (1).svg" runat="server" />
                    <asp:ImageButton CausesValidation="false" ID="userLogo" ImageUrl="~/Images/account_circle_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                    <div style="background-color: white; color: red; margin: 5px; padding: 5px;">Company Logo</div>
                </div>
            </div>
            <div class="container">
                <div class="sideBar">
                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" Width="24" ID="menu" ClientIDMode="Static" ImageUrl="~/Images/menu_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="play" ImageUrl="~/Images/play_circle_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                        <asp:Label runat="server" Text="Historical Analytics"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="pin" ImageUrl="~/Images/keep_public_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                        <asp:Label runat="server" Text="Live Analytics"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="smartShop" ImageUrl="~/Images/account_tree_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                        <asp:Label runat="server" Text="Smart Shop"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="analyticsLogo" ImageUrl="~/Images/analytics_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                        <asp:Label runat="server" Text="Bajaj Analytics"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="user" ImageUrl="~/Images/person_add_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                        <asp:Label runat="server" Text="User Access"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                    </div>

                    <div class="bar">
                        <asp:Label runat="server" Text="Settings"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" />
                    </div>
                </div>

                <div class="content">
                    <div class="content1">
                        <table class="contols">
                            <tr class="firstRow">
                                <td>Machine</td>
                                <td>
                                    <asp:DropDownList ID="ddlMachine" runat="server" OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </td>
                                <td>Component</td>
                                <td>
                                    <asp:DropDownList ID="ddlComponent" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged"></asp:DropDownList>
                                </td>
                                <td>Operation</td>
                                <td>
                                    <asp:DropDownList ID="ddlOperation" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlOperation_SelectedIndexChanged"></asp:DropDownList>
                                </td>

                                <td>Characteristic</td>
                                <td>
                                    <asp:ListBox ID="listBoxCharacteristic" runat="server" SelectionMode="Multiple"></asp:ListBox>
                                </td>
                            </tr>
                            <tr>
                                <td>From Date</td>
                                <td>
                                    <asp:TextBox ID="FromDate" runat="server" TextMode="DateTime" Text="2024-06-22"></asp:TextBox>
                                </td>
                                <td>To Date</td>
                                <td>
                                    <asp:TextBox ID="ToDate" runat="server" TextMode="DateTime" Text="2024-07-30"></asp:TextBox>
                                </td>
                                <td>Serial No.</td>
                                <td>
                                    <asp:TextBox ID="serialNo" runat="server"></asp:TextBox>
                                </td>

                                <td>Status</td>
                                <td>
                                    <asp:ListBox ID="listboxStatus" runat="server" SelectionMode="Multiple">
                                        <asp:ListItem Selected="True">Ok</asp:ListItem>
                                        <asp:ListItem Selected="True">Rework</asp:ListItem>
                                        <asp:ListItem Selected="True">Rejected</asp:ListItem>
                                        <asp:ListItem Selected="True">Empty</asp:ListItem>
                                    </asp:ListBox>
                                </td>
                                <td>
                                    <asp:Button CssClass="btn" ID="btnView" runat="server" Text="View" OnClick="btnView_Click" />
                                    <asp:Button CssClass="btn" ID="btnExport" runat="server" BackColor="Green" Text="Export" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="content2" style="width: 86vw; overflow: auto;">
                        <asp:ListView ID="ListView1" runat="server">
                            <EmptyItemTemplate>
                            </EmptyItemTemplate>
                            <LayoutTemplate>
                                <table border="1" class="tblListView">
                                    <tr style="background-color: dodgerblue; font-weight: bold; color: white">
                                        <th style="min-width: 100px; padding: 10px">Date</th>
                                        <th style="min-width: 100px; padding: 10px">Shift</th>
                                        <th style="min-width: 100px; padding: 10px">Serial No</th>
                                        <th style="min-width: 100px; padding: 10px">Machine ID</th>
                                        <th style="min-width: 100px; padding: 10px">Component ID</th>
                                        <th style="min-width: 100px; padding: 10px">Operation No</th>

                                        <asp:Repeater ID="DynamicHeadersRepeater" runat="server">
                                            <ItemTemplate>
                                                <th colspan='<%# Eval("Val") %>' style="min-width: 110px; padding: 10px">
                                                    <%# Eval("HeaderName") %>
                                                </th>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                        <th style="min-width: 100px; padding: 10px">Spindle Load</th>
                                        <th style="min-width: 100px; padding: 10px">Result</th>
                                        <th style="min-width: 100px; padding: 10px">Remarks</th>
                                    </tr>
                                    <tr style="background-color: #1e3f5a; font-weight: bold; color: white">
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <asp:Repeater ID="DynamicSubHeadersRepeater" runat="server">
                                            <ItemTemplate>
                                                <th style="min-width: 110px; padding: 5px"><%# Eval("Val") %></th>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder" />
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr style="background-color: white;">
                                    <td>
                                        <asp:Label runat="server" ID="lblDate" Text=' <%# Eval("Date") %>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblShift" runat="server" Text='<%# Eval("Shift") %>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("SerialNo") %>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblMachineID" runat="server" Text='<%# Eval("MachineID") %>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblComponentID" runat="server" Text='<%# Eval("ComponentID")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblOperationNo" runat="server" Text='<%# Eval("OperationNo")%>'></asp:Label></td>

                                    <asp:ListView ID="nestedListView" runat="server" DataSource='<%# Eval("DynamicColumns") %>' OnItemDataBound="NestedListView_ItemDataBound">
                                        <ItemTemplate>
                                            <td>
                                                <asp:Label ID="lblDynamic" runat="server" Text='<%# Eval("Value") %>'></asp:Label>
                                            </td>
                                        </ItemTemplate>
                                    </asp:ListView>

                                    <td>
                                        <asp:Label ID="lblSpindleLoad" runat="server" Text='<%# Eval("SpindleLoad")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblResult" runat="server" Text='<%# Eval("Result")%>'></asp:Label></td>
                                    <td>
                                        <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks")%>'></asp:Label></td>

                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
