public class UPI_integration {
    
    public static void get_token(string paytm_mid){
        string paytm_host='https://securegw-stage.paytm.in';
       // Datetime dtNow = DateTime.now();
       	string y=String.valueof(DateTime.now().getTime());
        string x= 'PYTM_ORDR_'+y;
		
        string url=paytm_host+'/theia/api/v1/initiateTransaction?mid='+paytm_mid+'&orderId='+x;
        Http h = new Http();    
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        
        string key='AiKHw9tkEq@vfJCX';
		CheckSumServiceHelper ch= new CheckSumServiceHelper();
        Map<string, string> paramap = new Map<string,string>();
        paramap.put('MID','fPHPXi01201365920614');
        paramap.put('ORDER_ID',y);
        paramap.put('CHANNEL_ID','WEB');
        paramap.put('CUST_ID','CUST_001');
        paramap.put('MOBILE_NO','7424895717');
        paramap.put('EMAIL','test34@gmail.com');
        paramap.put('TXN_AMOUNT','1.00');
        paramap.put('WEBSITE','WEBSTAGING');
        paramap.put('INDUSTRY_TYPE_ID','Retail');
        paramap.put('CALLBACK_URL', 'http://sandbox.cs1.force.com/nmPaytmPayResponse');
      // string signature=;
       // system.debug('Signature is. -> '+ch.genrateCheckSum(key,paramap));
        
       
        
        // just body left
        /*Body looks like this
         * 
         *
         *  
		*/
        // req.setBody(body);    // problem is have to pass a signature which will run another script
        
       
        string sign=ch.genrateCheckSum(key,paramap);
        
        if(ch.verifycheckSum(key,paramap,sign)){
            system.debug('VERFIED');
        }
        else{
            system.debug('NOT VERFIED');
        }
        
        getTokeBody gg = new getTokeBody();

        gg.setTokenBody(paytm_mid,sign,x);
        
       	string body=json.serialize(gg);
        string body1=body.replace('currency1','currency');
        system.debug('body1 is ->'+ body1);
        req.setBody(body1);
        req.setHeader('Content-Type', 'application/json'); 
        HttpResponse response = h.send(req);
        system.debug('response body ' + response.getBody());
        
  
        System.debug(response.getStatusCode());
         if (response.getStatusCode() == 200) {
         	// sucess  and return the token
         	Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
			system.debug(results);
         	
         }
        else{
            // error
            
        }
    }
    public void validate_VPA(string vpa,string paytm_mid,string orderId){
        
        string paytm_host='https://securegw-stage.paytm.in';
        string url = paytm_host+'/theia/api/v1/vpa/validate?mid='+paytm_mid+'&orderId='+orderId;
        Http h = new Http();    
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        // we need a txn_token which we will get from intiate transaction api
        // so first we will call that
        
        //string txn_token= get_token(paytm_mid,orderId);     
        // hardcoing right now
        string txn_token='5a4894bb73584d20a142bf168420e7941621581159347';
        
        
        // make a body now
        
        string body='{\"head\":{\"txnToken\":\"5a4894bb73584d20a142bf168420e7941621581159347\"},\"body\":{\"vpa\":\"7777777777@paytm\"}}';
        req.setBody(body);
        req.setHeader('Content-Type', 'application/json'); 
        HttpResponse response = h.send(req);
        system.debug('response body ' + response.getBody());
        System.debug(response.getStatusCode());
         if (response.getStatusCode() == 200) {
         	Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
			system.debug(results);
         }
        else{
        	system.debug('error');
        }
        
    }
}