<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Screen2.aspx.cs" Inherits="Evaluation.Screen2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>


    <!-- Include jQuery first -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- Include Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Include Bootstrap Multiselect CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.12/css/bootstrap-multiselect.min.css" rel="stylesheet" type="text/css" />

    <!-- Include Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <!-- Include Bootstrap Multiselect JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.12/js/bootstrap-multiselect.min.js"></script>

    <link href="CSS/Screen2.css" rel="stylesheet" />

    <style>
        .container {
            margin: 0px !important;
            padding: 0px !important;
            width: 100%;
            height: 92.3vh
        }

        .tblListView tbody tr td {
            border: 1px solid #ddd;
            border-collapse: collapse;
        }

        .tblListView {
            border-spacing: 0px;
            text-align: center
        }

            .tblListView th {
                position: sticky;
                top: 0;
                z-index: 10; /* Keep the header above other content */
                background-color: dodgerblue; /* Keep background consistent */
                color: white; /* Keep text color consistent */
            }


        .contols tbody tr td {
            border: 1px solid #ddd;
            border-collapse: collapse;
            padding: 10px;
            text-align: center
        }

        .contols {
            border-spacing: 0px;
        }

        .multiselect-container .dropdown-toggle {
            width: 50%;
        }

        .multiselect-container ul {
            vertical-align: central;
            padding: 10px
        }

        .form-control.lsb {
            max-width: 150px !important
        }


        /* Style individual items in the dropdown menu */
        .multiselect-container label {
            display: flex;
            align-items: center;
            padding: 0px 10px;
        }

        .multiselect {
            background-color: white;
            color: black;
            max-width: 110px;
            overflow: hidden;
        }

        .dropdown-menu > .active > a, .dropdown-menu > .active > a:focus, .dropdown-menu > .active > a:hover {
            color: black;
            text-decoration: none;
            background-color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="header">
                <asp:Image ID="Amitlogo" ClientIDMode="Static" ImageUrl="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9jEFAfciW6ZuygNvbT2nQSy2q2h1RttkoZA&s" Width="80px" runat="server" />
                <h3>TPM-TRAK ANALYTICS</h3>
                <div class="side-stuff">
                    <asp:ImageButton CausesValidation="false" ID="zoomLogo" ImageUrl="~/Images/zoom_out_map_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24 (1).svg" runat="server" Enabled="false" />
                    <asp:ImageButton CausesValidation="false" ID="userLogo" ImageUrl="~/Images/account_circle_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                    <div style="background-color: white; color: red; margin: 5px; padding: 5px;">Company Logo</div>
                </div>
            </div>
            <div class="container">
                <div class="sideBar">
                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" Width="24" ID="menu" ClientIDMode="Static" ImageUrl="~/Images/menu_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="play" ImageUrl="~/Images/play_circle_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                        <asp:Label runat="server" Text="Historical Analytics"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="pin" ImageUrl="~/Images/keep_public_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                        <asp:Label runat="server" Text="Live Analytics"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="smartShop" ImageUrl="~/Images/account_tree_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                        <asp:Label runat="server" Text="Smart Shop"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="analyticsLogo" ImageUrl="~/Images/analytics_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                        <asp:Label runat="server" Text="Bajaj Analytics"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                    </div>

                    <div class="bar">
                        <asp:ImageButton CausesValidation="false" ID="user" ImageUrl="~/Images/person_add_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                        <asp:Label runat="server" Text="User Access"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                    </div>

                    <div class="bar">
                        <asp:Label runat="server" Text="Settings"></asp:Label>
                        <asp:ImageButton CausesValidation="false" ImageUrl="~/Images/chevron_right_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" runat="server" Enabled="false" />
                    </div>
                </div>

                <div class="content">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="content1">
                                <table class="contols" style="text-align: center">
                                    <tr class="firstRow">
                                        <td>Machine</td>
                                        <td>
                                            <asp:DropDownList ID="ddlMachine" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged" AutoPostBack="true" Width="150px"></asp:DropDownList>
                                        </td>
                                        <td>Component</td>
                                        <td>
                                            <asp:DropDownList ID="ddlComponent" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlComponent_SelectedIndexChanged" CssClass="form-control" Width="200"></asp:DropDownList>
                                        </td>
                                        <td>Operation</td>
                                        <td>
                                            <asp:DropDownList ID="ddlOperation" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlOperation_SelectedIndexChanged" CssClass="form-control" Width="100"></asp:DropDownList>
                                        </td>

                                        <td>Characteristic</td>
                                        <td>
                                            <asp:ListBox ID="listBoxCharacteristic" runat="server" SelectionMode="Multiple" CssClass="form-control lsb"></asp:ListBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>From Date</td>
                                        <td>
                                            <asp:TextBox ID="FromDate" runat="server" TextMode="DateTime" Text="2024-06-22" CssClass="form-control" Width="100"></asp:TextBox>
                                        </td>
                                        <td>To Date</td>
                                        <td>
                                            <asp:TextBox ID="ToDate" runat="server" TextMode="DateTime" Text="2024-07-30" CssClass="form-control" Width="100"></asp:TextBox>
                                        </td>
                                        <td>Serial No.</td>
                                        <td>
                                            <asp:TextBox ID="serialNo" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>

                                        <td>Status</td>

                                        <td>
                                            <asp:ListBox ID="listboxStatus" ClientIDMode="Static" runat="server" SelectionMode="Multiple" CssClass="form-control">
                                                <asp:ListItem Selected="True">Ok</asp:ListItem>
                                                <asp:ListItem Selected="True">Rework</asp:ListItem>
                                                <asp:ListItem Selected="True">Rejected</asp:ListItem>
                                                <asp:ListItem Selected="True">Empty</asp:ListItem>
                                            </asp:ListBox>
                                        </td>
                                        <td>
                                            <asp:Button CssClass="btn" ID="btnView" runat="server" Text="View" OnClick="btnView_Click" />
                                            <%--<asp:Button CssClass="btn" ID="btnExport" runat="server" BackColor="Green" Text="Export" Enabled="false" />--%>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnView" />
                        </Triggers>
                    </asp:UpdatePanel>

                    <div class="content2" style="width: 86vw; overflow: auto;">
                        <asp:ListView ID="ListView1" runat="server">

                            <EmptyDataTemplate>
                                <table border="1" class="tblListView">
                                    <thead>
                                        <tr style="background-color: dodgerblue; font-weight: bold; color: white">
                                            <th rowspan="2" style="min-width: 100px; padding: 10px">Date</th>
                                            <th rowspan="2" style="min-width: 100px; padding: 10px">Shift</th>
                                            <th rowspan="2" style="min-width: 100px; padding: 10px">Serial No</th>
                                            <th rowspan="2" style="min-width: 100px; padding: 10px">Machine ID</th>
                                            <th rowspan="2" style="min-width: 100px; padding: 10px">Component ID</th>
                                            <th rowspan="2" style="min-width: 100px; padding: 10px">Operation No</th>
                                            <th rowspan="2" style="min-width: 100px; padding: 10px">Spindle Load</th>
                                            <th rowspan="2" style="min-width: 100px; padding: 10px">Result</th>
                                            <th rowspan="2" style="min-width: 100px; padding: 10px">Remarks</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr style="background-color: white;">
                                            <td colspan="9" style="text-align: center; padding: 10px;">No Data!</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </EmptyDataTemplate>


                            <LayoutTemplate>
                                <table border="1" class="tblListView">
                                    <tr style="background-color: dodgerblue; font-weight: bold; color: white; position: sticky">
                                        <th rowspan="2" style="min-width: 100px; padding: 10px">Date</th>
                                        <th rowspan="2" style="min-width: 100px; padding: 10px">Shift</th>
                                        <th rowspan="2" style="min-width: 100px; padding: 10px">Serial No</th>
                                        <th rowspan="2" style="min-width: 100px; padding: 10px">Machine ID</th>
                                        <th rowspan="2" style="min-width: 100px; padding: 10px">Component ID</th>
                                        <th rowspan="2" style="min-width: 100px; padding: 10px">Operation No</th>

                                        <asp:Repeater ID="DynamicHeadersRepeater" runat="server">
                                            <ItemTemplate>
                                                <th colspan='<%# Eval("Val") %>' rowspan='<%# Convert.ToInt32(Eval("Val")) == 1 ? 2 : 1 %>' style="min-width: 110px; padding: 10px">
                                                    <%# Eval("HeaderName") %>
                                                </th>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                        <th rowspan="2" style="min-width: 100px; padding: 10px">Spindle Load</th>
                                        <th rowspan="2" style="min-width: 100px; padding: 10px">Result</th>
                                        <th rowspan="2" style="min-width: 100px; padding: 10px">Remarks</th>
                                    </tr>
                                    <tr style="background-color: dodgerblue; font-weight: bold; color: white; position: sticky">
                                        <asp:Repeater ID="DynamicSubHeadersRepeater" runat="server">
                                            <ItemTemplate>
                                                <th style="min-width: 110px; padding: 5px; position: sticky; top: 67px;"><%# Eval("Val") %></th>
                                            </ItemTemplate>
                                        </asp:Repeater>
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

    <%--<link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />--%>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>--%>

    <script>
        $(document).ready(function () {
            //$('#listboxStatus').chosen({
            //    width: '100%'
            //});
            //$('#listBoxCharacteristic').chosen({
            //    width: '100%'
            //});

            $("#listBoxCharacteristic").multiselect({
                includeSelectAllOption: true
            });

            $("#listboxStatus").multiselect({
                includeSelectAllOption: true
            });
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $("#listBoxCharacteristic").multiselect({
                includeSelectAllOption: true
            });

            $("#listboxStatus").multiselect({
                includeSelectAllOption: true
            });
        });
    </script>



</body>
</html>
