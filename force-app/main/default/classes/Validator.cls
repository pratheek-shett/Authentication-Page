public without sharing class Validator {

 
    
    //check email
    @AuraEnabled(cacheable = true)
    public static Boolean checkid(String emailid){
       if(String.isBlank(emailid)){
            return false; 
        }
             return emailid.endsWith('@gmail.com');
    }
    
    
    //generate otp
    @AuraEnabled(cacheable = false)
    public static integer generateotp(String email){
        Authentication_Object__c authobj = new Authentication_Object__c();
        //if already otp is present
        List<Authentication_Object__c> otplist = [ select OTP__c from Authentication_Object__c where Email__c =:email];

        if(!otplist.isEmpty()){
            delete otplist;
        }
        
        Integer otpValue = (integer)(Math.floor(Math.random() *9000)+1000);
        authobj.Email__c = email;
        authobj.OTP__c = String.valueOf(otpValue);
        integer intotp = Integer.valueOf(authobj.OTP__c);
        insert authobj;

        return intotp;
    }
    
    //validate the otp
     @AuraEnabled(cacheable = false)
     public static Boolean validateotp(Integer userenterdotp, String Email){
         Authentication_Object__c otpset = [select OTP__c, Email__c from Authentication_Object__c where Email__c = :Email LIMIT 1];
         
         if(otpset == null){
             throw new AuraHandledException('OTP Generation Issue');
         }
         
         Integer otpFromObject = Integer.valueOf(otpset.OTP__c);
         
         
         
           if(userenterdotp == null || userenterdotp <1000 || userenterdotp > 9000){
                throw new AuraHandledException('Enter valid otp');
           }
         
            
           
           if(userenterdotp != otpFromObject){
           throw new AuraHandledException('Enterd otp is invalid');
           }
           
          
           
           return true;
     
     }
    
    
}