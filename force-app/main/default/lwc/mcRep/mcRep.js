import { api, wire, LightningElement } from "lwc";
import getRepPresence from "@salesforce/apex/MulticalendarDataService.getRepPresence";
import { refreshApex } from '@salesforce/apex';

export default class McRep extends LightningElement {
    @api
    rep; //= {Name: 'Rep'};
    @api 
    currentview;
    @api
    icon = {Name: "utility:routing_offline"};

    exampleRep = {
        Id: '0003E2NNCL94X',
        Name: 'Rep McGee',
        Tags: [{
            Id: 1,
            Text: "Paid Digital"
        },
        {
            Id: 2,
            Text: "No Zen"
        }]
    }

    @api
    get repId(){
        if(this.rep?.Id){
            return this.rep.Id;
        } else {
            return '';
        }
    }

    get repName(){
        if(this.rep && this.rep.Name){
            return this.rep.Name;
        } else {
            return 'Rep';
        }
    }

    wireResults;
    @wire(getRepPresence, {repId: '$repId'})
    wiredGetRepPresence(value){
        const { data, error } = value;
        this.wireResults = value;
        if(error){
            console.log(error);
        } else if(data) {
            this.icon = this.statusToIconMap.get(this.presenceToStatusMap.get(data));
        }
    }

    intervalId;
    connectedCallback(){
        //console.log('currentview: '+this.currentview);
        clearInterval(this.intervalId);
        this.intervalId = setInterval(() => this.updatePresence(), 5*1000);

    }

    updatePresence(){
        if(!this.wireResults.error){
            refreshApex(this.wireResults);
        }
    }

    // constructor(){
    //     super();
    //     this.rep = {Name: 'Rep'};
    // }

    presenceToStatusMap = new MapWithDefault([
        ['Logged Out',        'Inactive'],
        ['No Summary',        'Inactive'],
        ['Team Meeting',      'Busy'],
        ['In Meeting',        'Busy'],
        ['Training',          'Busy'],
        ['Lunch',             'Busy'],
        ['Paperwork',         'Busy'],
        ['Extended Away',     'Busy'],
        ['Comfort Break',     'Busy'],
        ['Break',             'Busy'],
        ['Away',              'Busy'],
        ['Wrap Up',           'Busy'],
        ['Ready',             'Active'],
        ['Ready (Outbound)',  'Active'],
        ['Ringing Inbound',   'Inbound'],
        ['Busy Inbound',      'Inbound'],
        ['Ringing Outbound',  'Outbound'],
        ['Busy Outbound',     'Outbound']
    ], 'Inactive');

    statusToIconMap = new MapWithDefault([
        ['Inactive',                 {Name: "utility:routing_offline", Size: "x-small"}],
        ['Busy',   {Name: "utility:ban", Variant: "error", Size: "x-small"}],
        ['Active',     {Name: "utility:record", Variant: "success", Size: "x-small"}],
        ['Inbound',               {Name: "utility:incoming_call", Variant: "error", Size: "x-small"}],
        ['Outbound',          {Name: "utility:outbound_call", Variant: "error", Size: "x-small"}]
    ], {Name: "utility:routing_offline"});

    
    get repTags(){ return this.rep?.Tags; }

    get showTags(){ return this.repTags && this.repTags.length > 0}

    pinClicked(ev){
        this.dispatchEvent(new CustomEvent('rowpinned', {
            //'bubbles': true,
            'composed': true,
            'detail' : {
                repId: this.rep.Id
            }
        }));
    }

    refreshClicked(ev){
        this.dispatchEvent(new CustomEvent('rowrefreshed', {
            //'bubbles': true,
            'composed': true,
            'detail' : {
                repId: this.rep.Id
            }
        }));
    }

    openMenu() {}
}

class MapWithDefault{
    mapData;
    defaultValue;

    constructor(mapData, defaultValue){
        try{
            this.mapData = new Map(mapData);
        }catch (e){
            this.mapData = mapData;
        }
        
        this.defaultValue = defaultValue;
    }

    get(key){
        if(this.mapData?.has(key)){
            return this.mapData.get(key);
        } else {
            return this.defaultValue;
        }
    }
}