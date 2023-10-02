import { api, wire, LightningElement } from "lwc";
import moveAppointment from "@salesforce/apex/MulticalendarDataService.moveAppointment";
import { NavigationMixin } from 'lightning/navigation';


export default class McApptMiniDetails extends NavigationMixin(LightningElement) {
    // @api
    // xco;
    // @api
    // yco;
    _details;
    @api
    get details(){
        return this._details;
    }
    set details(value){
        // console.log('set details: '+value);
        this._details = value;
        var height = 0;
        setTimeout(() => {
            var miniblock = this.template.querySelector('.mini-details-block');
            //console.log('miniblock: '+miniblock);
            // var height = miniblock?.style.getPropertyValue('position');
            // console.log('height: '+height);
            // var sheets = this.template.styleSheets;
            // console.log(sheets?.length);
            // console.log(sheets?.get(0));
            
            if(miniblock){
                height = window.getComputedStyle(miniblock).getPropertyValue('height');
                height = Number.parseFloat(height.slice(0,-2));
                //console.log(height);                
            }
            this.detailStyle = `top:${this.details?.yco - height}px; left:${this.details?.xco}px;`
        });       
    }

    @api
    availableReps;
    @api
    detailStyle = '';
    @api
    get showRejections(){
        return this.details?.rejections && this.details?.rejections.length > 0;
    }
    
    get selectedRep(){
        return this.details?.rep;
    }

    tempRepId;
    //@api
    //selectedRep;
    //onselect for dropdown
    changeOwner(ev){
        this.tempRepId = ev.detail.value;
        //console.log(this.tempRepId);
    }

    closeDetails(ev){
        this.details = null;
        this.tempRepId = null;
        this.rendered = false;
    }

    saveRep(ev){
        var det = this.details;
        var newRepId = this.tempRepId;
        var oldRepId = this.selectedRep;
        this.closeDetails();
        moveAppointment({eventId: det.eventId, repId: newRepId})
        .then(result => {
            //console.log(result);
            this.dispatchEvent(new CustomEvent('apptreassigned', {
                'detail': {
                    newRepId: newRepId,
                    oldRepId: oldRepId
                }
            }));
        })
        .catch(error => console.log(error));
    }

    // openFullDetails(){
    //     this[NavigationMixin.Navigate]({
    //         type: 'standard__recordPage',
    //         attributes: {
    //             recordId: this.details.eventId,
    //             actionName: 'view'
    //         }
    //     });        
    //     this.closeDetails();
    // }

    openFullDetails() {
        this.invokeWorkspaceAPI('isConsoleNavigation').then(isConsole => {
          if (isConsole) {
            this.invokeWorkspaceAPI('getFocusedTabInfo').then(focusedTab => {
            // this.invokeWorkspaceAPI('getAllTabInfo').then(tabList => {              
            //   for(var tab of tabList){
            //     console.log(JSON.stringify(tab));
            //     if(tab.developerName == 'MultiCalendar'){
            //       console.log(JSON.stringify(tab));
            //       tabId = tab.tabId;
            //       pageRef = tab.pageReference;
            //       //break;
            //     }
            //   }
              console.log('tabId: '+focusedTab.tabId);
              //console.log(JSON.stringify(focusedTab));
              this.invokeWorkspaceAPI('openSubtab', {
                parentTabId: focusedTab.tabId,
                recordId: this.details.eventId,
                focus: true
              }).then(tabId => {
                console.log("Solution #2 - SubTab ID: ", tabId);
                this.closeDetails();
              });
            });
          } else {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.details.eventId,
                    actionName: 'view'
                }
            });
            this.closeDetails();
          }
        });
    }
     
    invokeWorkspaceAPI(methodName, methodArgs) {
        return new Promise((resolve, reject) => {
          const apiEvent = new CustomEvent("internalapievent", {
            bubbles: true,
            composed: true,
            cancelable: false,
            detail: {
              category: "workspaceAPI",
              methodName: methodName,
              methodArgs: methodArgs,
              callback: (err, response) => {
                if (err) {
                    return reject(err);
                } else {
                    return resolve(response);
                }
              }
            }
          });
     
          window.dispatchEvent(apiEvent);
        });
    }

    // get detailStyle(){
    //     var style = `position:fixed; z-index:2; background-color:white; top:${this.details?.yco -200}px; left:${this.details?.xco}px; width:230px; min-height:100px; max-height:2000px; height:auto;`;
    //     console.log(style);
    //     return style;
    // }
    rendered=true;
    renderedCallback(){
        // if(!this.rendered){
        //     this.rendered = true;
        //     console.log('*** minidetails renderedCallback');
        //     this.detailStyle = `top:${this.details?.yco -200}px; left:${this.details?.xco}px;`
        //     //this.rendered = false;
        // }
        
        // console.log(this.details?.rep);
        // console.log(this.selectedRep);
        //console.log(this.availableReps);
        // if(!this.selectedRep){
        //     this.selectedRep = this.details?.rep;
        // }       
                
    }

}