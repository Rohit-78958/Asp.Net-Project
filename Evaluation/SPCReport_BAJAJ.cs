using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Evaluation
{
    public class SPCReport_BAJAJ
    {
        public DateTime Date { get; set; }
        public string Shift { get; set; }
        public string SerialNo { get; set; }
        public string MachineID { get; set; }
        public string ComponentID { get; set; }
        public string OperationNo { get; set; }
        public string SpindleLoad { get; set; }
        public string Result { get; set; }
        public string Remarks { get; set; }
        public List<KeyValuePair<string, string>> DynamicColumns { get; set; }
    }
}