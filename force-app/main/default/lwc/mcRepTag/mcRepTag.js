import { api, wire, LightningElement } from "lwc";

export default class McRepTag extends LightningElement {
    @api tag;
    @api currentview;

    csTagsToDisplay = ['Manager', 'Team Lead'];
    
    get displayTag(){
        return !(this.currentview == 'Userrole.Name = \'CS Agent\'') || (this.csTagsToDisplay.includes(this.tag.Text));
    }

    connectedCallback(){
        console.log(this.displayTag);
    }
}