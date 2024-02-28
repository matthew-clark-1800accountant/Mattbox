import { api, wire, LightningElement, track } from "lwc";
import { FlowAttributeChangeEvent, FlowNavigationFinishEvent  } from 'lightning/flowSupport';
import { EnclosingTabId, closeTab, openSubtab, getAllTabInfo } from 'lightning/platformWorkspaceApi';

export default class OpenUrlFromFlow extends LightningElement {
    @api 
    urlParam;

    @api
    targetParam;

    //@wire(EnclosingTabId) enclosingTabId;
    
    @api
    connectedCallback(){
        if(this.targetParam.replace('_','') == 'subtab'){
            this.openSubtab();
        } else {
            this.openWindow(this.targetParam);
        }
        const navigateFinishEvent = new FlowNavigationFinishEvent();
        this.dispatchEvent(navigateFinishEvent);
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

    openSubtab() {
      console.log(this.urlParam);
      console.log(this.targetParam);
        this.invokeWorkspaceAPI('isConsoleNavigation').then(isConsole => {
          if (isConsole) {
            getAllTabInfo().then(tabList=> {
              console.log(tabList);
              var focusedTabId;
              for(var tab of tabList){
                if(tab.focused){
                  focusedTabId = tab.tabId;
                }
              }
              openSubtab(focusedTabId, {url: this.urlParam});
            });


            // this.invokeWorkspaceAPI('getFocusedTabInfo').then(focusedTab => {
            //   this.invokeWorkspaceAPI('isSubtab', {tabId: focusedTab.tabId}).then(result => {
            //     console.log('isSubtab: '+result);
            //   });
            //   console.log('tabId: '+focusedTab.tabId);
            //   openSubtab(focusedTab.tabId, {url: this.urlParam});
            //   getAllTabInfo().then(result => console.log(JSON.stringify(result)));
            //   console.log(JSON.stringify(focusedTab));
            //   this.invokeWorkspaceAPI('openSubtab', {
            //     parentTabId: focusedTabId,
            //     url: this.urlParam,
            //     focus: true
            //   });//.catch(e => console.log(`Critical fail: ${JSON.stringify(e.message)}`));
            //   .then(tabId => {
            //     console.log("Solution #2 - SubTab ID: ", tabId);
            //     this.closeDetails();
            //   });
            // });
          } else {
            this.openWindow('_self');
          }
        });
    }

    openWindow(target){
        window.open(this.urlParam, target);
    }
}