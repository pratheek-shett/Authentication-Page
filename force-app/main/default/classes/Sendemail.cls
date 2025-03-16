public without sharing class Sendemail {

@AuraEnabled(cacheable = false)

public static void sendingemail(String toAddress){

   


    integer getOTP = Validator.generateotp(toAddress);

    if(getOTP == null){
       throw new AuraHandledException('No OTP Found');
    }

    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setToAddresses(new String[] {toAddress});
    email.setSubject('Authenticate OTP');
    email.setPlainTextBody('Hello Please verify the OTP : ' + getOTP);
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});

    //Remove otp from the object 


    

    List<Authentication_Object__c> Aobject = [select OTP__c from Authentication_Object__c where Email__c = :toAddress];

    if(!Aobject.isEmpty()){
        delete Aobject;
    }
    

}
    
// public static void sendingemail(String toAddress, integer otp){
//     Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
//     email.setToAddresses(new String[] {toAddress});
//     email.setSubject('Authenticate OTP');
//     email.setPlainTextBody('Hello Please verify the OTP : ' + otp);
//     Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
// }

}