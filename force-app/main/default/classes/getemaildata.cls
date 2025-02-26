public with sharing class getemaildata {
    public static List<Contact> getemaildata() {

        List<Contact> anmail = [select Email from Contact];
        system.debug(anmail);
        return anmail;
        
    }
}