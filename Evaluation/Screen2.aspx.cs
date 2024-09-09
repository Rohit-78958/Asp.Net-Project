using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Evaluation
{
    public partial class Screen2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropDownListMachine();
                BindDropDownListComponent();
                BindDropDownListOpertion();
                BindDropDownListCharacteristic();
                BindListView();
            }
        }

        protected void BindDropDownListMachine()
        {
            try
            {
                ddlMachine.DataSource = DBUtil.GetMachineDetails();
                if (ddlMachine.DataSource != null)
                {
            
                    ddlMachine.DataBind();
                }
                else
                    Response.Write("null list for machines table");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        
        protected void BindDropDownListComponent()
        {
            try
            {
                HashSet<string> components = DBUtil.GetComponentDetails(ddlMachine.SelectedValue);
                ddlComponent.DataSource = components;
                if (ddlComponent.DataSource != null)
                {

                    ddlComponent.DataBind();
                }
                else
                    Response.Write("null list for machines table");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        
        protected void BindDropDownListOpertion()
        {
            try
            {
                ddlOperation.DataSource = DBUtil.GetOperationDetails(ddlMachine.SelectedValue, ddlComponent.SelectedValue);
                if (ddlOperation.DataSource != null)
                {
                
                    ddlOperation.DataBind();
                }
                else
                    Response.Write("null list for machines table");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        
        protected void BindDropDownListCharacteristic()
        {
            try
            {
                int.TryParse(ddlOperation.SelectedValue, out int value);
                listBoxCharacteristic.DataSource = DBUtil.GetCharacteristicDetails(ddlMachine.SelectedValue, ddlComponent.SelectedValue, value);
                if (listBoxCharacteristic.DataSource != null)
                {
                
                    listBoxCharacteristic.DataBind();
                    foreach (ListItem item in listBoxCharacteristic.Items)
                    {
                        item.Selected = true;
                    }
                }
                else
                    Response.Write("null list for machines table");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void BindListView()
        {
            try
            {
                StringBuilder characteristics = new StringBuilder();
                if (listBoxCharacteristic.Items.Count > 0)
                {
                    foreach (ListItem item in listBoxCharacteristic.Items)
                    {
                        if (item.Selected)
                        {
                            characteristics.Append(item.Value + ",");
                        }
                    }
                    characteristics.Remove(characteristics.Length - 1, 1);
                }

                StringBuilder status = new StringBuilder();
                foreach (ListItem item in listboxStatus.Items)
                {
                    if (item.Selected)
                    {
                        status.Append(item.Value+",");
                    }
                }
                status.Remove(status.Length - 1, 1);  

                List<SPCReport_BAJAJ> data = DBUtil.GetSPCReport_Bajaj(ddlMachine.SelectedValue, ddlComponent.SelectedValue, Convert.ToDateTime(FromDate.Text), Convert.ToDateTime(ToDate.Text), Convert.ToInt32(ddlOperation.SelectedValue), status.ToString(),characteristics.ToString());

                ListView1.DataSource = data;
                if (ListView1.DataSource != null)
                    ListView1.DataBind();
                else
                    Response.Write("null list for parameters table");

                // Bind dynamic headers
                if (data[0].DynamicColumns != null && data[0].DynamicColumns.Any())
                {
                    Repeater headerRepeater = ListView1.FindControl("DynamicHeadersRepeater") as Repeater;
                    Repeater subHeaderRepeater = ListView1.FindControl("DynamicSubHeadersRepeater") as Repeater;

                    if (headerRepeater != null)
                    {
                        //headerRepeater.DataSource = data[0].DynamicColumns.Select(kv => kv.Key);
                        var processedHeaders = new HashSet<string>(); // Store processed header names
                        var subHeaders = new List<object>(); // Store sub-headers for binding

                        var headers = data[0].DynamicColumns
                            .Select(kv =>
                            {
                                var headerParts = kv.Key.Split(new[] { '$', '_', '@' }, StringSplitOptions.RemoveEmptyEntries);
                                if (headerParts.Length >= 3)
                                {
                                    var headerName = headerParts[0];
                                    string[] charec = characteristics.ToString().Split(',');
                                    int column = 0;
                                    for(int i = 0; i < charec.Length; i++)
                                    {
                                        string word = charec[i].Split('_')[0].ToLower().Trim();
                                        if (headerName.ToLower().Trim().Contains(word)) column++;
                                    }
                                    if(headerParts.Length == 4)
                                        subHeaders.Add(new { Val = headerParts[3] }); // Store sub-header value
                                    
                                    // Check if headerName is already processed, skip if true
                                    if (!processedHeaders.Contains(headerName))
                                    {
                                        processedHeaders.Add(headerName); // Add to processed headers
                                        return new
                                        {
                                            HeaderName = $"{headerName} ({headerParts[1]}/{headerParts[2]})",  // Header name until the $ sign
                                            //Val1 = headerParts[1],    // val1 after $ and before _
                                            //Val2 = headerParts[2]     // val2 after _ and before @
                                            Val = column
                                        };
                                    }
                                }
                                return null;
                            })
                            .Where(header => header != null) // Skip if headerName already processed
                            .ToList(); // Convert to a list

                        headerRepeater.DataSource = headers;
                        subHeaderRepeater.DataSource = subHeaders;

                        headerRepeater.DataBind();
                        subHeaderRepeater.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            try
            {
                BindListView();
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
        }

        protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindDropDownListComponent();
                BindDropDownListOpertion();
                BindDropDownListCharacteristic();
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
        }

        protected void ddlComponent_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindDropDownListOpertion();
                BindDropDownListCharacteristic();
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
        }

        protected void ddlOperation_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindDropDownListCharacteristic();
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
        }


        protected void NestedListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListViewItemType.DataItem)
                {
                    // Find the Label control with the ID lblDynamic
                    Label label = (Label)e.Item.FindControl("lblDynamic");

                    if (!string.IsNullOrEmpty(label.Text))
                    {
                        // Get the value of the Label control
                        double? doubleValue = double.Parse(label.Text);

                        // Get the data item for the current row
                        KeyValuePair<string, string> dataItem = (KeyValuePair<string, string>)e.Item.DataItem;

                        // Get the header of the current column
                        string header = dataItem.Key;

                        // Extract the val1 and val2 values from the header
                        int index = header.IndexOf("$");
                        string substring = header.Substring(index + 1);
                        index = substring.IndexOf("_");
                        string val1 = substring.Substring(0, index);
                        substring = substring.Substring(index + 1);
                        index = substring.IndexOf("@");
                        string val2 = substring;
                        if (index != -1)
                            val2 = substring.Substring(0, index);

                        double doubleVal1 = double.Parse(val1);
                        double doubleVal2 = double.Parse(val2);

                        if (doubleValue >= doubleVal1 && doubleValue <= doubleVal2)
                        {
                            // If the value is between val1 and val2, set the color to green
                            label.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            // If the value is not between val1 and val2, set the color to red
                            label.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
        }
    }
}