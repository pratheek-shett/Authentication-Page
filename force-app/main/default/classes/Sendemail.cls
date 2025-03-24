public without sharing class Sendemail {

@AuraEnabled(cacheable = false)

public static void sendingemail(String toAddress){


   if(Limits.getEmailInvocations() >= Limits.getLimitEmailInvocations()){
      throw new AuraHandledException('System busy, please try again later');
    }
   
   try{

      delete [SELECT Id FROM Authentication_Object__c 
               WHERE Email__c = :toAddress LIMIT 10];

    integer getOTP = Validator.generateotp(toAddress);
    if(getOTP == null){
       throw new AuraHandledException('No OTP Found');
    }
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setToAddresses(new String[] {toAddress});
    email.setSubject('Authenticate OTP');
    email.setReplyTo('pratheekshetty2004@gmail.com');
   

    // Set the correct organization-wide email address ID
    email.setOrgWideEmailAddressId('0D2WU0000001JWr');
    email.setPlainTextBody('Hello Please verify the OTP : ' + getOTP);
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    System.debug('sent email');

   }catch (Exception e) {
      System.debug('Error sending email: ' + e.getMessage());
      throw new AuraHandledException('Error sending email: ' + e.getMessage());
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