public class getTokeBody{
	public body body{get;set;}
	public head head{get;set;}
	public class userInfo{
		public String custId{get;set;}
	}
	public class txnAmount{
		public String currency1{get;set;}
		public String value{get;set;}
	}
	public class head{
		public String signature{get;set;}
	}
	public class body{
		public txnAmount txnAmount{get;set;}
		public String websiteName{get;set;}
		public String orderId{get;set;}
		public userInfo userInfo{get;set;}
		public String mid{get;set;}
		public String callbackUrl{get;set;}
		public String requestType{get;set;}
	}
    
    public void setTokenBody(string midId,string sign,string orderId){
        
        
        // body is all set
        this.body = new body();
        this.body.websiteName = 'WEBSTAGING';
        
        this.body.orderId = orderId;
        this.body.mid = midId;
        this.body.callbackUrl = 'https://merchant-website.com/callback';
        this.body.requestType = 'Payment';
        this.body.txnAmount = new txnAmount();
        this.body.txnAmount.value = '1.00';
        this.body.txnAmount.currency1 = 'INR';
       	this.body.userInfo = new userInfo();
        this.body.userInfo.custId = 'CUST_001';
        
        // now head
        this.head = new head();
        this.head.signature = sign;
        
        
        
        //
        
        
    }
    
}