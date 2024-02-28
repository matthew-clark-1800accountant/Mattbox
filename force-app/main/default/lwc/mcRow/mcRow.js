import { api, wire, LightningElement } from "lwc";
import getTimeslots from "@salesforce/apex/MulticalendarDataService.getRepTimeslots";
import { refreshApex } from '@salesforce/apex';

export default class McRow extends LightningElement {

    isSyncingLeftScroll = false;
    isSyncingRightScroll = false;
    bottomRow;

    get repId() {
        if(this.rep){
            return this.rep.Id;
        } else {
            return null;
        }
    }

    @api
    get timeslotsLoaded(){        
        var loaded = (this.row?.Timeslots && this.row.Timeslots.length > 0);// && false;
        // if(loaded){
        //     console.log('timeslotsLoaded: ');
        //     console.log(this.row.Timeslots);
        // }
        return loaded;
    }

    get rowStyle(){
        if(this.isLastRow){
            return "overflow: hidden;";
        } else {
            return "overflow: hidden;";
        }
    }

    @api
    get rowScrollVal(){
        return 10;
    }

    savedScrollVal;
    set rowScrollVal(value){
        if(this.bottomRow){
            this.bottomRow.scrollLeft=value;
            if(value != null){
                this.savedScrollVal = value;
            }
            //console.log('value: '+value);
            //console.log('this.savedScrollVal: '+this.savedScrollVal);
        }
    }

    @api
    isLastRow;

    @api
    rep;

    @api
    rowId;

    @api
    row;
    row2;
    row3;

    @api
    dateString;

    @api
    hideBlockedReps;

    @api
    get isRepBlocked(){
        if(!this.row || !this.rep?.EndOfDay){
            return false;
        }
        if(this.rep.EndOfDay == -1){
            return true;
        }
        var filteredSlots = this.row.Timeslots.filter(x => 
            {
                var timeslotTimeCalc = (x.TimeslotTime + 30*60*1000);
                return (timeslotTimeCalc > Date.now()) && (x.TimeslotTime < this.rep.EndOfDay);
            });
        if(!this.row || filteredSlots.length == 0){
            return false;
        }
        for(var slot of filteredSlots){
            var aptCount = slot.Appointments?.length;
            if(aptCount == 0 || slot.Appointments.filter(x => x.AppointmentType != 'Calendar Block').length > 0){
                return false; //at least one slot is unblocked
            }
        }
        return true; //all slots contain a block and no other type of appointment//
        
    }

    oldDisplayRow;

    @api
    get displayRow(){
        // console.log('displayRow: '+this.rep?.Name);
        // console.log(this.savedScrollVal);
        var shouldDisplayRow = !(this.hideBlockedReps && this.isRepBlocked);
        if(!this.oldDisplayRow && shouldDisplayRow){
            // setTimeout((() => {
            //     // if(this.savedScrollVal){
            //     //     console.log('using savedScrollValue');
            //     //     this.rowScrollVal = this.savedScrollVal;
            //     // } else {
            //     //     console.log('resetting scroll');
            //     //     this.resetScroll();
            //     // }
            //     console.log('displaying row '+this.rep?.Name+' at scroll '+this.bottomRow.scrollLeft);
            // }).bind(this), 1000);
        } else if (this.oldDisplayRow && !shouldDisplayRow){
            this.rendered = false;
        }
        this.oldDisplayRow = shouldDisplayRow;
        return shouldDisplayRow;
    }


    // get isLoading(){
    //     return !(this.row?.Timeslots && this.row?.Timeslots.length > 0);
    // }

    connectedCallback(){
        if(this.rep?.Name == 'Matthew Clark'){
            console.log('connectedCallback()');
        }
        if(!this.row){
            this.row = {Id: this.rowId, Rep:this.rep, Timeslots:[]};
        }      
    }

    wireResults;
    @wire(getTimeslots, {repId: '$repId', dateString: '$dateString'})
    getRowData(value){
        this.wireResults = value;
        const { data, error } = value;
        if(error){
            console.log(error);
        } else if(data) {
            this.row.Timeslots = [...data];
            this.row = this.row;
        }
        setTimeout((() => {
            if(this.savedScrollVal){
                console.log(this.savedScrollVal);
                this.rowScrollVal = this.savedScrollVal;
            } else { 
                console.log('resetting scroll');
                this.resetScroll();
            }
            //console.log('displaying row '+this.rep?.Name+' at scroll '+this.bottomRow.scrollLeft);
        //}).bind(this), 500);
        }), 500);
    }

    // get timeslotsLoaded(){
    //     return (this.row?.Timeslots && this.row.Timeslots.length > 0);
    // }

    rendered = false;
    renderedCallback(){
        
        //console.log('renderedCallback()');
        if(!this.rendered || !this.bottomRow){
            
            this.bottomRow = this.template.querySelector('lightning-layout.row');
            
            if(this.bottomRow){
                this.rendered = true;          
                //console.log('rendered');
                //console.log(this.savedScrollVal);
                //console.log(this.computedScrollValue);
                this.notifyLoaded();    
                if(this.savedScrollVal){
                    this.bottomRow.scrollLeft = this.savedScrollVal;  
                } else {
                    this.bottomRow.scrollLeft = this.computedScrollValue;
                }
            }             
                     
        }
        setTimeout(() => {
            if(this.rep?.Name == 'Matthew Clark' || this.rep?.Name == 'Rep'){
                console.log('renderedCallback()');
            }
            if(this.bottomRow?.scrollLeft == 0){
                this.resetScroll();
                //this.bottomRow.addEventListener("scroll", this.rowScroll.bind(this));  
            } 
        }, 2000);

    }

    @api
    refreshApexData(){
        refreshApex(this.wireResults);
    }

    apptDraggedHandler(ev){
        this.dispatchEvent(new CustomEvent('rowdraggedfrom', {
            'detail': {refreshRow: () => refreshApex(this.wireResults)}//this.refreshApexData.bind(this)}
        }));
    }

    notifyLoaded(){
        this.dispatchEvent(new CustomEvent('rowloaded', {
        }));
    }

    

    pageValue = 0;
    slotsPerPage = 6;
    numberOfPages = 48 / this.slotsPerPage;
    @api
    columnWidth;

    get computedScrollValue(){
        var curTime = new Date().toISOString();
        var hours = Number(curTime.slice(11,13)-5);
        var min = Number(curTime.slice(14,16));
        var timeslotNumber = (hours*2) + (min >= 30 ? 1 : 0);
        var pageNumber = (timeslotNumber-1) / this.slotsPerPage;
        this.pageValue = this.roundPageNumber(pageNumber);        
        return this.pageValue*this.slotsPerPage*this.columnWidth;
    }

    get spinnerStyle(){
        var margin = this.columnWidth/2;
        return 'position:relative; height:10px; margin-left: '+margin+'px';
    }

    roundPageNumber(pageNum){
        if(pageNum < 0){
            return 0;
        } else if (pageNum > this.numberOfPages - 1){
            return this.numberOfPages - 1;
        } else {
            return pageNum;
        }
    }

    rowRefreshedHandler(ev){
        this.refreshApexData();
        this.resetScroll();
        var slotList = this.template.querySelectorAll('c-mc-time-slot');
        slotList.forEach((slot) => {slot.updateStyle(); slot.updateAppointments();});
        console.log('refreshed');
    }

    rowPinnedHandler(ev){
        //console.log(JSON.stringify(this.rep));
        this.dispatchEvent(new CustomEvent('rowpinned', {
            //'bubbles': true,
            'composed': true,
            'detail' : {
                rowObj: ()=>{return this;}
                //rowObj: this
            }
        }));
    }

    @api
    repDebug(ev){
        console.log(this.rep?.Name == 'Matthew Clark');
        // console.log('sanity');
        // console.log(this.spinnerStyle);
        //console.log(this.timeslotsLoaded);
        // this.refreshApexData();
        // var slotList = this.template.querySelectorAll('c-mc-time-slot');
        // slotList.forEach((slot) => {slot.updateStyle(); slot.updateAppointments();});
        // console.log('refreshed');
        //console.log('repDebug: '+this.rep?.Name);
        //console.log('isBlocked: '+this.isRepBlocked);
        //console.log('rep.EndOfDay: '+this.rep?.EndOfDay);
        //console.log('scrollLeft: '+this.bottomRow?.scrollLeft);
        //console.log(this.savedScrollVal);
        //console.log(this.computedScrollValue);
        console.log(document.documentElement.clientHeight);
    }

    @api
    resetScroll(ev){
        this.bottomRow = null;
        this.bottomRow = this.template.querySelector('lightning-layout.row');
        this.savedScrollVal = null;
        if(this.bottomRow){
            this.bottomRow.scrollLeft = null;
        }        
        this.rowScrollVal = this.computedScrollValue;
    }
}