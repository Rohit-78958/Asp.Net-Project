<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Screen1.aspx.cs" Inherits="Evaluation.screen1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/screen1.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.7.0.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="main">
            <div class="header">
                <img src="/Images/KTA_image.jpg" width="100" alt="kta-logo" />
                <h2 style="position: relative; left: 80px">CUMULATIVE TARGET VS ACTUAL</h2>
                <div class="side">
                    <h2 style="display: inline;"><%= DateTime.Now.ToString("dd/MM/yyyy") %></h2>
                    <div style="display: inline-flex; flex-direction: column; flex-wrap: wrap; align-items: flex-end">
                        <div>
                            <asp:ImageButton ID="Home" runat="server" ImageUrl="~/Images/house_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" />
                            <asp:ImageButton ID="Settings" runat="server" ImageUrl="~/Images/settings_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24.svg" />
                        </div>
                        <asp:ImageButton Enabled="false" ID="Zoom" runat="server" ImageUrl="~/Images/zoom_out_map_24dp_FFFFFF_FILL0_wght400_GRAD0_opsz24 (1).svg" />
                    </div>
                </div>
            </div>
            <div class="subHeader">
                KTA Spindle Tooling
            </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="content">
                        <asp:ListView ID="listview" runat="server">
                            <ItemTemplate>
                                <div class="box">
                                    <div class="subbox">
                                        <h1 style="color: yellow; text-align: center; margin: 0px; vertical-align: central; font-size: xx-large"><%# DataBinder.Eval(Container.DataItem, "Value") %></h1>
                                    </div>
                                    <h2 style="color: #225680; text-align: center"><%# DataBinder.Eval(Container.DataItem, "Name") %></h2>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
            <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick"></asp:Timer>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <footer>
            <div class="footer">
                <p style="font-size:small; margin-left:5px">Powered By TPM-Trak</p>
                <div class="floater"><p>Welcome to TPM-Trak</p></div>
                <asp:Image ID="Amitlogo" ClientIDMode="Static" ImageUrl="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9jEFAfciW6ZuygNvbT2nQSy2q2h1RttkoZA&s" style="margin: 5px;" Width="80px" runat="server" />
            </div>
        </footer>
    </form>

    <script>
        $(document).ready(function () {
            $(".content").css('height', $(window).height() - $(".header").height() - $(".subHeader").height() - $(".footer").height() - 22);
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(".content").css('height', $(window).height() - $(".header").height() - $(".subHeader").height() - $(".footer").height() - 22);
        });
    </script>
</body>
</html>
