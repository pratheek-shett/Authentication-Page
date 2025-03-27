public with sharing class Sessioncontroler {
    @AuraEnabled()
    public static void  Sessioncreation () {
        try {
            SessionManager.createSession(UserInfo.getUserId());
        } catch(Exception e) {
            throw new AuraHandledException('Session creation failed: ' + e.getMessage());
        }
    }

    @AuraEnabled()
    public static Boolean  Sessionrefresh () {
        try {
            return SessionManager.refreshSession(UserInfo.getUserId());
        } catch(Exception e) {
            throw new AuraHandledException('Session refresh failed: ' + e.getMessage());
        }
    }

    @AuraEnabled()
    public static Boolean  Sessionrevalidate() {
        try {
            return SessionManager.validateSession(UserInfo.getUserId());
        } catch(Exception e) {
            throw new AuraHandledException('Session validation failed: ' + e.getMessage());
        }
    }
}