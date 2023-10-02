import { api, wire, LightningElement } from "lwc";

export default class McRep extends LightningElement {
    @api
    rep; //= {Name: 'Rep'};

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

    get repName(){
        if(this.rep && this.rep.Name){
            return this.rep.Name;
        } else {
            return 'Rep';
        }
    }

    connectedCallback(){
        //this.rep = this.exampleRep; //testing
    }

    // constructor(){
    //     super();
    //     this.rep = {Name: 'Rep'};
    // }

    
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