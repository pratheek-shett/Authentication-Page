import { LightningElement } from 'lwc';
import Sessioncreation from '@salesforce/apex/Sessioncontroler.Sessioncreation';
import Sessionrefresh from '@salesforce/apex/Sessioncontroler.Sessionrefresh';
import Sessionrevalidate from '@salesforce/apex/Sessioncontroler.Sessionrevalidate';
import { NavigationMixin } from 'lightning/navigation';

export default class Homepage extends NavigationMixin(LightningElement) {

    sessioninterval;

    connectedCallback(){
            window.addEventListener('click', ()=> Sessionrefresh());
            window.addEventListener('scroll', ()=> Sessionrefresh());
            window.addEventListener('keypress', ()=> Sessionrefresh());
            this.checkSession();
            this.sessioninterval = setInterval(() => this.checkSession(), 30000);
    }


    disconnectedcallback(){
        window.removeEventListener('click', ()=> Sessionrefresh());
         window.removeEventListener('scroll', ()=> Sessionrefresh());
         window.removeEventListener('keypress', ()=> Sessionrefresh());
        clearInterval(this.sessioninterval);
    }

    


    async checkSession() {
        try {
            const isValid = await Sessionrevalidate();
            if (!isValid) {
                this.navigatetologin();
            }
        } catch(error) {
            console.error('Session check failed:', error);
            this.navigatetologin();
        }
    }

    navigatetologin(e){
    this[NavigationMixin.Navigate]({
        type: 'standard__webPage',
    attributes: {
        url: '/' 
    }
    })
}




}