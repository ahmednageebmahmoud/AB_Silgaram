namespace KnPayPayment.Models
{
    public class GatewayResponse
    {
        public string result { get; set; }
        public string postdate { get; set; }
        public string trackid { get; set; }
        public string tranid { get; set; }
        public string udf1 { get; set; }
        public string udf2 { get; set; }
        public string eci { get; set; }
        public string responsecode { get; set; }
        public string paymentid { get; set; }
        public string auth { get; set; }
        public string udf4 { get; set; }
    }
}