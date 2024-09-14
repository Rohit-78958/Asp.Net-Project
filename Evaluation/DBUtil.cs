using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;
using System.Web.Services.Description;
using System.Drawing;

namespace Evaluation
{
    public class DBUtil
    {
        public static string ConnectionString 
        { 
            get 
            {
                return ConfigurationManager.ConnectionStrings["KTA"].ConnectionString;
            } 
        }
        
        public static string ConnectionString1 
        { 
            get 
            {
                return ConfigurationManager.ConnectionStrings["BAJAJ"].ConnectionString;
            } 
        }

        public static List<double> GetDetails()
        {
            List<double> values = new List<double>();
            SqlConnection sqlConnection = null;
            SqlDataReader reader = default;
            try
            {
                sqlConnection = new SqlConnection(ConnectionString);
                SqlCommand cmd = new SqlCommand("S_DayWiseTargetAndonSaveAndView_KTA", sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                // Add the parameters to the command
                //@Date='2024-04-10 06:00:00', @Param='DayWiseTargetAndonView', @CellID='', @Plant=''

                cmd.Parameters.AddWithValue("@Date", new DateTime(2024, 04, 10, 6, 0, 0));
                cmd.Parameters.AddWithValue("@Param", "DayWiseTargetAndonView");
                cmd.Parameters.AddWithValue("@CellID", "");
                cmd.Parameters.AddWithValue("@Plant", "");

                // Open the connection
                sqlConnection.Open();

                reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    //Debug.WriteLine($"---------{reader.GetFieldType(2)}---{reader.GetFieldType(3)}----{reader.GetFieldType(4)}---{reader.GetFieldType(5)}----------{reader.GetFieldType(6)}------");
                    if (reader.GetFieldType(2) == typeof(int))
                        values.Add(Convert.ToDouble(reader["TargetQty"]));
                    else
                        values.Add(Convert.ToDouble(reader["TargetQty"]));

                    values.Add(Convert.ToDouble(reader["ProdQty"]));
                    values.Add(Convert.ToDouble(reader["ShortfallQty"]));
                    values.Add(Convert.ToDouble(reader["Rejection_Qty"]));
                    values.Add(Convert.ToDouble(reader["Rework_Qty"]));
                }
              
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
            finally
            {
                reader?.Close();
                sqlConnection?.Close();
            }
            return values;
        }

        public static List<double> ChartsDetails(out List<string> downId, string fromDate, string toDate)
        {
            List<double> downTime = new List<double>();
            downId = new List<string>();
            SqlConnection sqlConnection = null;
            SqlDataReader reader = default;
            try
            {
                sqlConnection = new SqlConnection(ConnectionString);
                SqlCommand cmd = new SqlCommand("s_GetSONA_ShiftAgg_DowntimeMatrix", sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                // Add the parameters to the command
                //@StartTime = '2024-04-01',@EndTime = '2024-07-01',@MachineID = '',@DownID = '', @MatrixType = 'DLoss_By_Catagory',@PlantID = '',@Exclude = '',@Groupid = ''

                if(!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    cmd.Parameters.AddWithValue("@StartTime", Convert.ToDateTime(fromDate));
                    cmd.Parameters.AddWithValue("@EndTime", Convert.ToDateTime(toDate));
                }
                else
                {
                    cmd.Parameters.AddWithValue("@StartTime", new DateTime(2024, 04, 01));
                    cmd.Parameters.AddWithValue("@EndTime", new DateTime(2024, 07, 01));
                }
                cmd.Parameters.AddWithValue("@MachineID", "");
                cmd.Parameters.AddWithValue("@DownID", "");
                cmd.Parameters.AddWithValue("@MatrixType", "DLoss_By_Catagory");
                cmd.Parameters.AddWithValue("@PlantID", "");
                cmd.Parameters.AddWithValue("@Exclude", "");
                cmd.Parameters.AddWithValue("@Groupid", "");

                // Open the connection
                sqlConnection.Open();

                reader = cmd.ExecuteReader();

                do
                {
                    while (reader.Read())
                    {
                        //Debug.WriteLine($"---------{reader.GetFieldType(1)}---{reader.GetFieldType(2)}-----");

                        downId.Add(Convert.ToString(reader["DownID"]));
                        downTime.Add(Convert.ToDouble(reader["DownTime"]));  
                    }
                } while (reader.NextResult());

                return downTime;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return downTime;
            }
            finally
            {
                sqlConnection?.Close();
                reader?.Close();
            }
        }

        public static List<string> GetMachineDetails()
        {
            List<string> machines = new List<string>();
            SqlConnection sqlConnection = null;
            SqlDataReader reader = default;
            try
            {
                sqlConnection = new SqlConnection(ConnectionString1);
                string sql = "select machineid from [machineinformation]";
                SqlCommand cmd = new SqlCommand(sql, sqlConnection);

                // Open the connection
                sqlConnection.Open();

                reader = cmd.ExecuteReader();

                do
                {
                    while (reader.Read())
                    {
                        machines.Add(reader.GetString(0));
                    }
                } while (reader.NextResult());

                return machines;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return machines;
            }
            finally
            {
                sqlConnection?.Close();
                reader?.Close();
            }
        }

        public static HashSet<string> GetComponentDetails(string machineid="")
        {
            HashSet<string> componentID = new HashSet<string>();
            SqlConnection sqlConnection = null;
            SqlDataReader reader = default;
            try
            {
                sqlConnection = new SqlConnection(ConnectionString1);

                string sql = "";
                if (!string.IsNullOrEmpty(machineid))
                    sql = $"select componentid from [componentoperationpricing] where machineid='{machineid}'";
                else
                    sql = "select componentid from [componentoperationpricing]";

                SqlCommand cmd = new SqlCommand(sql, sqlConnection);

                // Open the connection
                sqlConnection.Open();

                reader = cmd.ExecuteReader();

                do
                {
                    while (reader.Read())
                    {
                        componentID.Add(reader.GetString(0));
                    }
                } while (reader.NextResult());

                return componentID;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return componentID;
            }
            finally
            {
                sqlConnection?.Close();
                reader?.Close();
            }
        }
        
        public static List<int> GetOperationDetails(string machineID="",string componentID="")
        {
            List<int> operationNo = new List<int>();
            SqlConnection sqlConnection = null;
            SqlDataReader reader = default;
            try
            {
                sqlConnection = new SqlConnection(ConnectionString1);

                string sql = "";
                if (!string.IsNullOrEmpty(componentID))
                    sql = $"select [operationno] from [componentoperationpricing] where machineid='{machineID}' and componentid='{componentID}'";
                else
                    sql = "select operationno from [componentoperationpricing]";

                SqlCommand cmd = new SqlCommand(sql, sqlConnection);

                // Open the connection
                sqlConnection.Open();

                reader = cmd.ExecuteReader();

                do
                {
                    while (reader.Read())
                    {
                        operationNo.Add(reader.GetInt32(0));
                    }
                } while (reader.NextResult());

                return operationNo;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return operationNo;
            }
            finally
            {
                sqlConnection?.Close();
                reader?.Close();
            }
        }

        public static List<string> GetCharacteristicDetails(string machineId, string componentId, int operationNo)
        {
            List<string> characteristicCodes = new List<string>();
            SqlConnection sqlConnection = null;
            SqlDataReader reader = default;
            try
            {
                sqlConnection = new SqlConnection(ConnectionString1);

                string sql = "";
                if (!string.IsNullOrEmpty(machineId) && !string.IsNullOrEmpty(componentId))
                    sql = $"select [CharacteristicCode] from [SPC_Characteristic] where machineid='{machineId}' and componentid = '{componentId}' and operationno = '{operationNo}'";
                else
                    sql = "select componentid from [componentoperationpricing]";

                SqlCommand cmd = new SqlCommand(sql, sqlConnection);

                // Open the connection
                sqlConnection.Open();

                reader = cmd.ExecuteReader();

                do
                {
                    while (reader.Read())
                    {
                        characteristicCodes.Add(reader.GetString(0));
                    }
                } while (reader.NextResult());

                return characteristicCodes;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return characteristicCodes;
            }
            finally
            {
                sqlConnection?.Close();
                reader?.Close();
            }
        }

        public static List<SPCReport_BAJAJ> GetSPCReport_Bajaj(string machineID, string componentID, DateTime startDate, DateTime endDate, int operationNo, string status, string dimension)
        {
            List<SPCReport_BAJAJ> reports = new List<SPCReport_BAJAJ>();

            SqlConnection sqlConnection = null;
            SqlDataReader reader = default;
            try
            {
                sqlConnection = new SqlConnection(ConnectionString1);
                SqlCommand cmd = new SqlCommand("S_GetSlnoWiseSPCReport_Bajaj", sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                // Add the parameters to the command
                //@MachineID='Bajaj AMS',@COmponentID='Cyclindrical Component',@StartDate='2024-06-22 06:00:00',@EndDate = '2024-07-30 06:00:00',@OperationNo = '10',@Status = 'Ok,Rejected,Empty',@Dimension = 'Fine Boring_Bottom,Fine Boring_Top,Input Size_Bottom,Input Size_Top,Mechanical Size'

                cmd.Parameters.AddWithValue("@MachineID", machineID);
                cmd.Parameters.AddWithValue("@COmponentID", componentID);
                cmd.Parameters.AddWithValue("@StartDate", startDate);
                cmd.Parameters.AddWithValue("@EndDate", endDate);
                cmd.Parameters.AddWithValue("@OperationNo", operationNo);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@Dimension", dimension);

                // Open the connection
                sqlConnection.Open();

                reader = cmd.ExecuteReader();

            
                while (reader.Read())
                {
                    Debug.WriteLine($"---------{reader.GetFieldType(0)}---{reader.GetFieldType(2)}----{reader.GetFieldType(3)}---{reader.GetFieldType(4)}----------{reader.GetFieldType(5)}------");
                    SPCReport_BAJAJ sPCReport_BAJAJ = new SPCReport_BAJAJ();

                    sPCReport_BAJAJ.Date = reader.GetDateTime(0);
                    sPCReport_BAJAJ.Shift = reader.IsDBNull(2) ? "" : reader.GetString(2);
                    sPCReport_BAJAJ.SerialNo = reader.IsDBNull(3) ? "" : reader.GetString(3);
                    sPCReport_BAJAJ.MachineID = reader.IsDBNull(4) ? "" : reader.GetString(4);
                    sPCReport_BAJAJ.ComponentID = reader.IsDBNull(5) ? "" : reader.GetString(5);
                    sPCReport_BAJAJ.OperationNo = reader.IsDBNull(6) ? "" : reader.GetString(6);
                    sPCReport_BAJAJ.SpindleLoad = reader.IsDBNull(7) ? "" : reader.GetString(7);
                    sPCReport_BAJAJ.Result = reader.IsDBNull(8) ? "" : reader.GetString(8);
                    sPCReport_BAJAJ.Remarks = reader.IsDBNull(9) ? "" : reader.GetString(9);

                    sPCReport_BAJAJ.DynamicColumns = new List<KeyValuePair<string, string>>();
                    for (int i = 10; i < reader.FieldCount; i++)
                    {
                        sPCReport_BAJAJ.DynamicColumns.Add(new KeyValuePair<string, string>(reader.GetName(i), reader.IsDBNull(i) ? "" : reader[i].ToString()));
                    }


                reports.Add(sPCReport_BAJAJ);
            }
                
                return reports;

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return reports;
            }
            finally
            {
                sqlConnection?.Close();
                reader?.Close();
            }
        }
    }
}