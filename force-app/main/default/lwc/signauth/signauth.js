import { LightningElement, track,api, wire } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import FirstName from '@salesforce/schema/Contact.FirstName';
//Imports for hide headers
import noHeader from '@salesforce/resourceUrl/NoHeader';
import HideLightningHeader from '@salesforce/resourceUrl/NoHeader';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import getemaildatafunction from '@salesforce/apex/Mailget.getemaildatafunction';
export default class Signauth extends LightningElement {
  

//    @api buttonlabel = "Submit";
 
  @track emaillist = []
  @track dataer = {FirstName: "", LastName: ""};
  @track email = "";
 
  //togetlistofemailsfromapex
@track emaildata = [];
@track showotpfield = false;


//WIRE METHOD TO GET DATA FROM APEX
// @wire(getemaildatafunction,{usernameemail: "$email"})

// datafetchfromapex({data,error}){

//   if(data){
//       this.emaildata = data;
//   }else if(error)
//   window.alert("Fetch Error");
// }
 
  //GET USER INPUT DATA
 

    runfunc(event) {
        
        let getname = event.target.name;

        if(getname === "emailid"){
        
            this.email = event.target.value;
            this.dataer.FirstName = event.target.value;
        }else if(getname === "name"){
            this.dataer.LastName = event.target.value;
        }
        // const event = new ShowToastEvent({
        //     title: "Success",  // Provide a valid title
        //     message: "Button clicked!",  // Provide a valid message
        //     variant: "success" 
        //      // Ensure variant is correctly written
        // });

        // this.buttonlabel = "Submitted";
        // this.buttonlabel = "Submit";
        // this.dispatchEvent(event);
    }
    
    //USER VALIDATION FUNCTION
     validate(getemail){

      
      //  var lowercaseemail = this.emaildata.map((item =>{return item.toLowerCase()}))

      // if(lowercaseemail.includes(getemail)){
      //   window.alert("email found");
      // }else{
      //   window.alert("not found");
      // }

    }

    
    //BUTTON CLICK FUNCTION

     async btnclick (){
     
      
     let getdatafromuser = this.email.toLowerCase();
    
    
      if(getdatafromuser.trim() === ""){
        window.alert("Please enter a valid email");
        return;
      }
      if(!getdatafromuser.endsWith("@novigosolutions.com")){
          window.alert("authonticate error");
          return;
        }
      try{
        const result = await getemaildatafunction({usernameemail: getdatafromuser});

        if(!result || result.length === 0){
          window.alert("email not found");
          return;
        }
        let lowerresult = result.map(item => item.Email.toLowerCase());
        if(lowerresult.includes(getdatafromuser)){
          this.viewenabler();
         window.alert("Email Found");
        }else{
         window.alert("Fetch error");
        }
 
       }catch(error){
         window.alert("Error Found Catch exception");
       }

      
    }
    
    viewenabler(){
      this.showotpfield = true;
    }
}
    


