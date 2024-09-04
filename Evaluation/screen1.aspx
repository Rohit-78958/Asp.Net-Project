<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="screen1.aspx.cs" Inherits="Evaluation.screen1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/screen1.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="header">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP5fgyCchMO7g0VhN4RYCh7lUt_2o3djF1zg&s" width="100" alt="kta-logo" />
                <h2>CUMULATIVE TARGET VS ACTUAL</h2>
                <div class="side">
                    <%= DateTime.Now.ToString("dd/MM/yyyy") %>
                    <asp:ImageButton ID="Home" runat="server" ImageUrl="~/Images/house_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" />
                    <asp:ImageButton ID="Settings" runat="server" ImageUrl="~/Images/settings_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" />
                    <asp:ImageButton ID="Zoom" runat="server" ImageUrl="~/Images/zoom_out_map_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24 (1).svg" />
                </div>
            </div>
            <div class="subHeader">
                KTA Spindle Tooling
            </div>
            <div class="content">
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                        <div class="box">
                            <div class="subbox">
                                <h1 style="color: yellow; text-align: center; margin: 0px; vertical-align: central"><%# DataBinder.Eval(Container.DataItem, "Value") %></h1>
                            </div>
                            <h2 style="color: #2b54ad; text-align: center"><%# DataBinder.Eval(Container.DataItem, "Name") %></h2>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        // Refresh the page every 30 minutes (30 * 60 * 1000 milliseconds)
        setTimeout(function () {
            window.location.reload();
        }, 1000*10);
    </script>
</body>
</html>
