public without sharing class SessionManager {

    //During Login 
   
    public  static void createSession(Id userid) {

        //delete if any session is already existed
        delete [select Id from User_Session__c where User__c = :userid AND Is_Active__c =:true];

        User_Session__c usersession = new User_Session__c(
            User__c = userid,
            Start_Time__c = DateTime.now(),
            Last_Refresh__c = DateTime.now(),
            End_Time__c = DateTime.now().addminutes(5),
            Is_Active__c = true
        );
        insert usersession;
    }


    //User reloads 
    
    public static Boolean refreshSession(id userid){

        //get id,endtime

        try{

            User_Session__c sessionend =[ select id, End_Time__c from User_Session__c where User__c =: userid AND Is_Active__c = true Limit 1 ];

            //check if its expired

            if(Datetime.now() > sessionend.End_Time__c){
                sessionend.Is_Active__c = false;
                update sessionend;
                return false;
            }
             //to check page response or activeness
            sessionend.Last_Refresh__c = Datetime.now();
            sessionend.End_Time__c = DateTime.now().addMinutes(5);
            update sessionend;
            return true;

        }catch(Exception e){
            System.debug('Refresh error: ' + e.getMessage());
            return false;
        }



    }

    //Validate the Session
   
    public static Boolean validateSession(id userid){

        try{
            User_Session__c validatesession = [select End_Time__c from User_Session__c where User__c = :userid AND Is_Active__c = true limit 1];
            return DateTime.now() <= validatesession.End_Time__c;
        } catch (Exception e){
            System.debug('Validation error: ' + e.getMessage());
            return false;
        }



    }
}