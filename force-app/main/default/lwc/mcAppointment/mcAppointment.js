import { api, wire, LightningElement } from "lwc";
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import MailingPostalCode from "@salesforce/schema/Contact.MailingPostalCode";
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';
import numberOfEndedCallsWire from "@salesforce/apex/MulticalendarDataService.numberOfEndedCalls";
import getRepRejections from "@salesforce/apex/MulticalendarDataService.getRepRejections";

export default class McAppointment extends NavigationMixin(LightningElement) {
    @api
    appointment;
    @api
    rep;

    @api
    get appointmentId(){
        return this.appointment?.Id;
    }

    @wire(numberOfEndedCallsWire, {eventId: '$appointmentId'})
    numberOfEndedCallsWireFunction(results){
        this.numberOfEndedCalls = results;
        if(this.rendered){
            this.updateStyle();
        }
        
    }
    @api
    numberOfEndedCalls;

    @wire(getRepRejections, {eventId: '$appointmentId'})
    repRejections;

    // @api
    // get displayRejections(){
    //     return this.repRejections?.data
    // }

    @api
    get callInProgress(){
        if(this.numberOfEndedCalls.error || !this.appointment){
            return false;
        } else {
            return this.numberOfEndedCalls.data < this.appointment.NumberOfCalls;
        }
    }

    @api
    get totalNumberOfCalls(){
        // var endedCalls = this.numberOfEndedCalls?.data ? this.numberOfEndedCalls.data : 0;
        // return endedCalls + (this.callInProgress ? 1 : 0);
        return this.appointment?.NumberOfCalls ? this.appointment?.NumberOfCalls : 0;
    }

    @api
    get showCallNumber(){
        return (this.totalNumberOfCalls && this.totalNumberOfCalls > 0);
    }

    @api
    get showParts(){
        return (this.appointment?.PartsString && this.appointment?.PartsString != '');
    }

    exampleAppointment = {
        Id: 1,
        EventId: '0000231ABC0X',
        Disposition: 'Rescheduled',
        SecondaryDisposition: null,
        Initials: 'MC',
        Source: '1800Accountant',
        StartTime: 1470443417111,
        EndTime: 1470443417111
    }

    headingText = 'heading';
    blockStyle = 'block slds-block';
    textHeadingStyle = 'text-heading';
    textSubheadingStyle = 'text-subheading';
    textInitialsStyle = 'text-initials';
    icon = {
        Name: "utility:success",
        Variant: "success"
    }
    //getters for field values
    iconMap = new Map([
        ['No-show',                 {Name: "utility:outbound_call", Variant: "error"}],
        ['Consulted/Rescheduled',   {Name: "utility:event"}],
        ['Consulted/Cancelled',     {Name: "utility:close", Variant: "error"}],
        ['Follow-Up',               {Name: "utility:loop"}],
        ['Not Interested',          {Name: "utility:error", Variant: "error"}],
        ['Sale',                    {Name: "utility:success", Variant: "success"}],
        ['Running Long',            {Name: "utility:warning", Variant: "warning"}],
        ['Missing Disposition',     {Name: "utility:warning", Variant: "warning"}],
        ['Needs To Be Called',      {Name: "utility:warning", Variant: "error"}],
        ['Upcoming',                {Name: "utility:clock"}],
        ['Unassigned',              {Name: "utility:question_mark", Variant: "warning"}],
        ['In Progress',             {Name: "utility:outbound_call"}],
        ['Not Qualified',           {Name: "utility:warning"}],
        ['Rescheduled',             {Name: "utility:event"}],
        ['Cancelled',               {Name: "utility:close", Variant: "error"}],
        ['Failure to Call',         {Name: "utility:warning", Variant: "error"}],
        ['Blocked',                 {Name: ""}],
        ['heading',                 {Name: "utility:connected_apps", Variant: "warning"}]
    ]);
    
    headingStyleMap = new Map([
        ['No-show',                 'text-heading'],
        ['Consulted/Rescheduled',   'text-heading'],
        ['Consulted/Cancelled',     'text-heading'],
        ['Follow-Up',               'text-heading'],
        ['Not Interested',          'text-heading'],
        ['Sale',                    'text-heading'],
        ['Running Long',            'warning-text-heading'],
        ['Missing Disposition',     'text-heading'],
        ['Needs To Be Called',      'error-text-heading'],
        ['Upcoming',                'text-heading'],
        ['Unassigned',              'text-heading'],
        ['In Progress',             'text-heading'],
        ['Not Qualified',           'text-heading'],
        ['Rescheduled',             'text-heading'],
        ['Cancelled',               'text-heading'],
        ['Not Qualified',           'text-heading'],
        ['Failure to Call',         'text-heading'],
        ['Blocked',                 'text-heading'],
        ['heading',                 'text-heading']
    ]);

    subheadingStyleMap = new Map([
        ['No-show',                 'text-subheading'],
        ['Consulted/Rescheduled',   'text-subheading'],
        ['Consulted/Cancelled',     'text-subheading'],
        ['Follow-Up',               'text-subheading'],
        ['Not Interested',          'text-subheading'],
        ['Sale',                    'text-subheading'],
        ['Running Long',            'warning-text-heading'],
        ['Missing Disposition',     'text-subheading'],
        ['Needs To Be Called',      'error-text-subheading'],
        ['Upcoming',                'text-subheading'],
        ['Unassigned',              'text-subheading'],
        ['In Progress',             'text-subheading'],
        ['Not Qualified',           'text-subheading'],
        ['Rescheduled',             'text-subheading'],
        ['Cancelled',               'text-subheading'],
        ['Not Qualified',           'text-subheading'],
        ['Failure to Call',         'text-subheading'],
        ['Blocked',                 'text-subheading'],
        ['heading',                 'text-subheading']
    ]);

    initialsStyleMap = new Map([
        ['No-show',                 'text-initials'],
        ['Consulted/Rescheduled',   'text-initials'],
        ['Consulted/Cancelled',     'text-initials'],
        ['Follow-Up',               'text-initials'],
        ['Not Interested',          'text-initials'],
        ['Sale',                    'text-initials'],
        ['Running Long',            'warning-text-initials'],
        ['Missing Disposition',     'text-initials'],
        ['Needs To Be Called',      'error-text-initials'],
        ['Upcoming',                'text-initials'],
        ['Unassigned',              'text-initials'],
        ['In Progress',             'text-initials'],
        ['Not Qualified',           'text-initials'],
        ['Rescheduled',             'text-initials'],
        ['Cancelled',               'text-initials'],
        ['Not Qualified',           'text-initials'],
        ['Failure to Call',         'text-initials'],
        ['Blocked',                 'text-initials'],
        ['heading',                 'text-initials']
    ]);

    blockStyleMap = new Map([
        ['No-show',                 'block slds-block'],
        ['Consulted/Rescheduled',   'block slds-block'],
        ['Consulted/Cancelled',     'block slds-block'],
        ['Follow-Up',               'block slds-block'],
        ['Not Interested',          'block slds-block'],
        ['Sale',                    'block slds-block'],
        ['Running Long',            'warning-block slds-block'],
        ['Missing Disposition',     'soft-error-block slds-block'],
        ['Needs To Be Called',      'error-block slds-block'],
        ['Upcoming',                'block slds-block'],
        ['Unassigned',              'block slds-block'],
        ['In Progress',             'block slds-block'],
        ['Not Qualified',           'block slds-block'],
        ['Rescheduled',             'rescheduled-block slds-block'],
        ['Cancelled',               'rescheduled-block slds-block'],
        ['Not Qualified',           'block slds-block'],
        ['Failure to Call',         'soft-error-block slds-block'],
        ['Blocked',                 'blocked-block slds-block'],
        ['heading',                 'block slds-block']
    ]);

    connectedCallback(){
        //console.log('appointment.connectedCallback');
    }

    intervalId;
    rendered = false;
    renderedCallback(){
        //use dummy record for initial tests
        //this.appointment = this.exampleAppointment;
        //console.log('appointment.renderedCallback');
        if(!this.rendered){
            this.rendered = true;
            //initialize appointment heading
            this.updateStyle();
            //refreshApex(this.numberOfEndedCalls);
            clearInterval(this.intervalId);
            this.intervalId = setInterval(() => this.updateStyle(), 20*1000);
        }
    }

    disconnectedCallback(){
        clearInterval(this.intervalId);
    }

    @api
    updateStyle(){
        // //console.log('updateStyle()');
        // console.log(this.appointment.Disposition);
        // console.log(this.appointment.SecondaryDisposition);
        // console.log(this.appointment.AppointmentType);
        if(this.numberOfEndedCalls?.data){
            refreshApex(this.numberOfEndedCalls).catch((e)=>{console.log(e); console.log(this.rep.Name);});
        }
        
        // console.log(this.callInProgress);
        // console.log(this.numberOfEndedCalls.data);
        // console.log(this.appointment.NumberOfCalls);
        const now = Date.now();
        var isLive = this.appointment.Subject.toLowerCase().includes('live');
        if(this.appointment.Disposition){
            this.headingText = this.appointment.Disposition;
            if(this.appointment.SecondaryDisposition == 'Cancelled' || this.appointment.SecondaryDisposition == 'Rescheduled' ){
                this.headingText += '/'+this.appointment.SecondaryDisposition;
            } else if(this.appointment.SecondaryDisposition && this.appointment.Disposition != 'Not Qualified'){
                this.headingText = this.appointment.SecondaryDisposition;
            } else if(!this.appointment.SecondaryDisposition && (this.appointment.Disposition == 'Consulted' || this.appointment.Disposition == 'Not Qualified')){
                this.headingTest = 'Missing Disposition';
            }
        } else {
            if(this.appointment.AppointmentType == 'Calendar Block'){
                this.headingText = 'Blocked'
            } else if(now<this.appointment.StartTime){
                this.headingText = 'Upcoming';
            } else if(now>=this.appointment.StartTime
                && now<this.appointment.EndTime
                && this.totalNumberOfCalls == 0
                && !isLive){
                this.headingText = 'Needs To Be Called';
            } else if(now<this.appointment.EndTime //check on this
                && this.callInProgress){
                this.headingText = 'In Progress'
            } else if(now>this.appointment.EndTime
                && this.callInProgress){
                this.headingText = 'Running Long';
            } else if(now>this.appointment.EndTime
                && this.totalNumberOfCalls == 0
                && !isLive){
                this.headingText = 'Failure to Call';
                // console.log(now);
                // console.log(this.appointment.EndTime);
                // console.log(this.totalNumberOfCalls);
            } else if(this.totalNumberOfCalls > 0 || isLive){
                this.headingText = 'Missing Disposition';
            }
            // if(['No-show', 'Rescheduled', 'Cancelled'].includes(this.appointment.Disposition)){
            //     this.headingText = this.appointment.Disposition;
            //     this.blockStyle = 'block slds-block';
            // }
        }

        if(this.headingText == 'heading'){
            // console.log('now: '+now);
            // console.log(JSON.stringify(this.appointment));
            // console.log('numberOfEndedCalls: '+this.numberOfEndedCalls);
            // console.log('callInProgress: '+this.callInProgress);
            // console.log('totalNumberOfCalls: '+this.totalNumberOfCalls);
        }

        //this.subheadingText = this.appointment?.LeadSource;
           
        //initialize icon
        if(this.iconMap.has(this.headingText)){
            this.icon = this.iconMap.get(this.headingText);
        }
        if(this.headingStyleMap.has(this.headingText)){
            this.textHeadingStyle = this.headingStyleMap.get(this.headingText);
        }
        if(this.subheadingStyleMap.has(this.headingText)){
            this.textSubheadingStyle = this.subheadingStyleMap.get(this.headingText);
        }
        if(this.initialsStyleMap.has(this.headingText)){
            this.textInitialsStyle = this.initialsStyleMap.get(this.headingText);
        }
        if(this.blockStyleMap.has(this.headingText)){
            this.blockStyle = this.blockStyleMap.get(this.headingText);
        }
        if(this.headingText.length > 15){
            var dispoDiv = this.template.querySelector('.'+this.textHeadingStyle);
            dispoDiv?.style.setProperty('font-size', '12px')
        }
        

    }

    //open msApptMiniDetails box above appt block
    openMiniDetails(){}

    //drag and drop logic
    dragStartHandler(ev){
        // console.log('dragStart');
        // console.log(ev.target);
        var dataString = this.appointment?.Id; //+';'+this.rep.Id +';'+this.appointment.StartTime;
        ev.dataTransfer.setData('text/plain', dataString);
        this.dispatchEvent(new CustomEvent('apptdragged', {
            'bubbles': true,
            'composed': true
        }));
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

    openSubtab(eventId) {
        this.invokeWorkspaceAPI('isConsoleNavigation').then(isConsole => {
          if (isConsole) {
            this.invokeWorkspaceAPI('getFocusedTabInfo').then(focusedTab => {
              console.log('tabId: '+focusedTab.tabId);
              //console.log(JSON.stringify(focusedTab));
              this.invokeWorkspaceAPI('openSubtab', {
                parentTabId: focusedTab.tabId,
                recordId: eventId,
                focus: false
              });
            //   .then(tabId => {
            //     console.log("Solution #2 - SubTab ID: ", tabId);
            //     this.closeDetails();
            //   });
            });
          } else {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: eventId,
                    actionName: 'view'
                }
            });
          }
        });
    }

    clickHandler(ev){        
        if(ev.ctrlKey){
            this.openSubtab(this.appointment.Id);
        } else {
            let rect = ev.currentTarget.getBoundingClientRect();
            var miniDetails = {
                xco: rect.x,
                yco: rect.y,
                name: this.appointment.LeadAccountName,
                title: this.appointment.Subject,
                source: this.appointment.LeadSource,
                disposition: this.headingText,
                icon: this.icon,
                rep: this.rep.Id,
                eventId: this.appointment.Id,
                rejections: this.repRejections?.data
            }
            console.log(miniDetails);
            this.dispatchEvent(new CustomEvent('apptclicked', {
                'bubbles': true,
                'composed': true,
                'detail': {data: miniDetails},
            }));
        }
        
        // for (const key in rect) {
        // if (typeof rect[key] !== 'function') {
        //     console.log(`${key} : ${rect[key]}`);
        // }
        // }
        // this[NavigationMixin.Navigate]({
        //     type: 'standard__recordPage',
        //     attributes: {
        //         recordId: this.appointment.Id,
        //         actionName: 'view'
        //     }
        // });
    }
}