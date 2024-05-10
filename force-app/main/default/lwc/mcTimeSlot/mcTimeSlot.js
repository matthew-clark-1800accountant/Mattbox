import { api, wire, LightningElement, track } from "lwc";
import moveAppointment from "@salesforce/apex/MulticalendarDataService.moveAppointment";
import { updateRecord } from 'lightning/uiRecordApi';

export default class McTimeSlot extends LightningElement {
    @api
    timeslot;// = {TimeslotTime: null, Appointments: []};
    @api
    rep;

    constructor(){
        super();
        this.rep = {Name: 'Rep'};
    }


    slotWidth = 240;

    // @api
    // appointmentList;

    @api
    get timeslotTime(){
        if(this?.timeslot?.TimeslotTime){
            return this.timeslot?.TimeslotTime;
        } else {
            var time = new Date();
            time.setMinutes(Math.floor(time.getMinutes() / 30)*30);
            return time;
        }
    }

    intervalId;
    connectedCallback(){
        this.showLine = Date.now() >= this.timeslotTime && Date.now() <= (this.timeslotTime + 30*60*1000);
        clearInterval(this.intervalId);
        this.intervalId = setInterval(()=>this.updateStyle(), 30*1000);
        // var ul = this.template.querySelector("ul");
        // ul.addEventListener("click", debugLine);
    }

    renderedCallback(){
        //console.log('timeslot.renderedCallback()');
    }

    disconnectedCallback(){
        clearInterval(this.intervalId);
    }

    @track
    showLine = false;// = Date.now() >= this.timeslotTime && Date.now() <= (this.timeslotTime + 30*60*1000);

    @api
    updateStyle(){

        if(!this.timeslot){
            this.showLine = false;
        } else {
            var visible = Date.now() >= this.timeslotTime && Date.now() <= (this.timeslotTime + 30*60*1000);
            this.showLine = visible;
        }
        if(this.showLine){
            var newStyle = 'width: 2px; position:absolute; background-color: red; z-index:1; height: 100%; margin-left: '+this.lineLoc+'px;';
            //console.log('updateStyle(): '+newStyle);
            this.lineStyle = newStyle;
        }        
    }

    @api
    updateAppointments(){
        var apptList = this.template.querySelectorAll('c-mc-appointment');
        apptList.forEach((appt) => {appt.updateStyle();});
    }
    
    get showExpandButton(){ return false; }

    // @api
    // get showLine(){
    //     console.log('get showLine()');        
    //     if(!this.timeslot){
    //         return false;
    //     }
        
    //     var visible = Date.now() >= this.timeslot?.TimeslotTime && Date.now() <= (this.timeslot?.TimeslotTime + 30*60*1000);
    //     //console.log('showLine: '+visible);
    //     // if(visible && this.timeslot.Appointments.length){
    //     //     console.log(this.rep.Name+' appointments: '+this.timeslot.Appointments.length);
    //     // }
    //     return visible;
    // }

    // @api
    // get lineStyle(){
    //     console.log('get lineStyle()');
    //     if(!this.timeslot){
    //         return false;
    //     }
    //     //console.log('lineLoc: '+this.lineLoc);
    //     var style = 'width: 2px; position:absolute; background-color: red; z-index:1; height: 100%; margin-left: '+this.lineLoc+'px;';
    //     return style;
    // }

    @track
    lineStyle = 'width: 2px; position:absolute; background-color: red; z-index:1; height: 100%; margin-left: '+this.lineLoc+'px;';


    //@api
    get lineLoc(){
        //console.log('get lineLoc()');
        //return 10;
        var timeslotTime = new Date();
        timeslotTime.setMinutes(Math.floor(timeslotTime.getMinutes() / 30)*30);
        var minuteDif = (Date.now() - timeslotTime.getTime()) / (1000*60);
        var percent = minuteDif / 30;
        var loc = Math.floor(this.slotWidth*percent);
        return loc;
    }

    //drag and drop logic?
    dropHandler(ev){
        ev.preventDefault();
        console.log('dropHandler ');
        const evData = ev.dataTransfer.getData("text/plain");//.split(';') //+';'+this.timeslot.TimeslotTime;
        console.log('data: '+evData);
        console.log(this.timeslot.TimeslotTime);
        moveAppointment({eventId: evData, repId: this.rep.Id})
        .then(result => {console.log(result);
        this.dispatchEvent(new CustomEvent('updaterow', {
            'bubbles': true,
            'composed': true
        }));})
        .catch(error => console.log(error));
        // const recInputObj = {
        //     //'apiName': 'Event',
        //     'fields': {
        //         'Id': data[0],
        //         'OwnerId': data[1],
        //         'StartDateTime': new Date(this.timeslot.TimeslotTime),
        //         'EndDateTime': new Date(this.timeslot.TimeslotTime+(30*60*1000))
        //     }
        // };
        // console.log(JSON.stringify(recInputObj));
        // updateRecord(recInputObj).then((result) => {console.log(result); console.log('record updated');})
    }

    dragOverHandler(ev){
        ev.preventDefault();
        //console.log('dragOverHandler ');
        ev.dataTransfer.dropEffect = "move";
        //console.log(this.lineLoc);
        //console.log(this.lineStyle);
    }

    //@api
    lineDebug(ev){
        //if(this.showLine){
            console.log(this.lineLoc);
            console.log(this.showLine);
            console.log(new Date(this.timeslotTime).toString());
        //}        
    }
}