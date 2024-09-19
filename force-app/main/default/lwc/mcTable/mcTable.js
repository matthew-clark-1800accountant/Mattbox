//import getRows from controller
import { api, wire, LightningElement, track } from "lwc";
import getReps from "@salesforce/apex/MulticalendarDataService.getReps";
import getViews from "@salesforce/apex/MulticalendarDataService.getCalendarViews";
import getCurrentUserData from "@salesforce/apex/MulticalendarDataService.getCurrentUserData";
import currentUserId from '@salesforce/user/Id';
import { getRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import generateData from "@salesforce/apex/MulticalendarDataService.makeDataForReps";
import getTimeslotLabels from "@salesforce/apex/MulticalendarDataService.getTimeslotLabels";
import getEnvironmentName from "@salesforce/apex/MulticalendarDataService.getEnvironmentName";
import showMaintenanceScreenWire from "@salesforce/apex/MulticalendarDataService.showMaintenanceScreen";
import SystemModstamp from "@salesforce/schema/AIApplication.SystemModstamp";


export default class McTable extends LightningElement {
    @api
    appliedFilters = ['ProfileId IN :profileIds', 'Sales_Team__c!=null', 'Sales_Team__c = \'BNA Team\''];

    basicRepFilters = ['ProfileId IN :profileIds', 'Sales_Team__c!=null'];
    //selectedViewFilters = ['Sales_Team__c = \'BNA Team\''];
    // @api
    // get appliedFilters(){
    //     return [...this.selectedViewFilters, this.searchValue, this.blockedToggleFilter];
    // }
    // set appliedFilters(value){}

    get blockedToggleFilter(){
        return this.toggleValue ? null : null;
    }

    @api
    availableViewFilters = [];
    headerList;

    @api
    userId = currentUserId;

    @wire(getCurrentUserData, {currentView: '$filterViewLabel'})
    currentUser;
    currentUserRetries = 0;

    @api
    showBlockFlow = false;

    //@wire(getRecord, {recordId: '$userId', fields: ['User.Name']})
    // @wire(getCurrentUserData)
    // currentUserWired(value){
    //     console.log('currentUserWired');
    //     const { data, error } = value;
    //     if(error){
    //         console.log(error);
    //     } else if(data) {
    //         this.currentUser = data;
    //         if(this.currentUser.SalesTeam){
    //             console.log('searching for '+this.currentUser.SalesTeam)
    //             // for(var cv of this.availableViewFilters){
    //             //     console.log(cv.label);
    //             //     if(cv.label.includes(this.currentUser.SalesTeam)){
    //             //         console.log('team found');
    //             //         this.appliedFilters = [...this.basicRepFilters, cv.value, this.searchValue, this.blockedToggleFilter];
    //             //         break;
    //             //     }
    //             // }
    //         } else {
    //             console.log('no sales team found for current user');
    //             console.log(JSON.stringify(currentUser));
    //         }
    //     }
    // }

    @wire(showMaintenanceScreenWire)
    showMaintenanceScreenWired;

    @wire(getTimeslotLabels, {})
    timeslotLabels;

    @wire(getEnvironmentName)
    environmentName;

    @api
    get slotsPerPage(){
        if(this.colWidth && window.innerWidth){
            var availableWindowSpace = window.innerWidth - 280;//account for rep column
            return Math.floor(availableWindowSpace / this.colWidth);
        } else {
            return 6;
        }
        
    }

    toggleValue;
    miniDetails;

    dateSuffix = 'T00:00:00.000-04:00';

    testId = '0055e000007Xtx2AAC';

    isLoading = false;

    selectedDate = new Date().toISOString().slice(0,10)+this.dateSuffix;
    todayDateString = new Date().toISOString().slice(0,10)+this.dateSuffix;
    // get todaysDateISO(){
    //     return new Date().toISOString()
    // }
    dataRefreshIntervalId;
    styleRefreshIntervalId;

    get showPageButtons() {
        return true; //this.filterViewValue == '';
    }

    @api
    get showCreateBlocksButton(){
        return !this.filterViewLabel?.includes('Advisory');
    }
    
    exampleRep = {
        Id: '0055e000007Xtx2AAC',
        UserId: '0055e000007Xtx2AAC',
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

    filterViewValue = 'Sales_Team__c = \'BNA Team\'';
    @api
    filterViewLabel = '';

    queryNonReps = false;
    handleViewSelection(ev){        
        this.isLoading = true;
        //console.log(this.timeslotLabels);
        console.log('handleViewSelection');
        //console.log({...ev.detail});
        this.filterViewValue = ev.detail.value;
        for(var view of this.availableViewFilters){
            if(view.value == this.filterViewValue) {
                this.filterViewLabel = view.label;
                break;
            }
        }
        //console.log('ev.detail: '+JSON.stringify(ev.detail));
        console.log(this.filterViewLabel);
        
        if(ev.detail.value.includes('Queue') || ev.detail.value.includes('CS Agent') || this.filterViewLabel?.includes('Advisory')){
            this.appliedFilters = [this.filterViewValue, this.searchValue, this.blockedToggleFilter];
            this.queryNonReps = true;
        } else {
            this.appliedFilters = [...this.basicRepFilters,this.filterViewValue, this.searchValue, this.blockedToggleFilter];
            this.queryNonReps = false;
        }
        console.log(this.appliedFilters);
        //this.appliedFilters = [this.filterViewValue, this.searchValue, this.blockedToggleFilter];
        console.log('queryNonReps '+this.queryNonReps);
        this.scrollToNow();
        //this.isLoading = false;
    }

    searchValue;


    rowIndexOffset = 0;
    wireResults;
    repList;

    get showMaintenanceScreen(){
        return this.showMaintenanceScreenWired?.data;
    }

    sortRepHelper(a,b){
        console.log('a name: '+a.Rep.Name);
        console.log('b name: '+b.Rep.Name);
        console.log('u name: '+this.currentUser.data?.Name);
        const nameA = a.Rep.Name.toUpperCase(); // ignore upper and lowercase
        const nameB = b.Rep.Name.toUpperCase(); // ignore upper and lowercase
        const curUserName = this.currentUser.data?.Name.toUpperCase();
        if (nameA == 'UNASSIGNED LEADS'){
            return -1;
        }
        if (nameB == 'UNASSIGNED LEADS'){
            return 1;
        }
        if (nameA == curUserName){
            return -1;
        }
        if (nameB == curUserName){
            return 1;
        }
        if (nameA < nameB) {
            return -1;
        }
        if (nameA > nameB) {
            return 1;
        }

        // names must be equal
        return 0;
    }

    @wire(getReps, {filterList: '$appliedFilters', selectedViewLabel: '$filterViewLabel'})
    wiredGetReps(value){
        console.log('wiredGetReps');
        console.log(JSON.stringify(this.appliedFilters));
        //console.log(JSON.stringify(value));
        this.wireResults = value;
        const { data, error } = value;
        if(error){
            console.log('wiredGetReps error: '+error);
        } else if(data) {
            //console.log('rep data:');
            //console.log(JSON.stringify(data));
            var rowList = [];
            var repList = [];
            var pinnedRepList = [];
            //console.log('filterViewValue: '+this.filterViewValue);
            //if(this.filterViewValue == this.availableViewFilters?.at(0)?.value){
            if(this.filterViewLabel == 'All Sales Reps'){
                //push unassigned leads row
                //rowList.push({Id:0, Rep:{Id:0, Name:'Unassigned Leads', Tags:[]}, Timeslots:[]});
                pinnedRepList.push({Id:0, Rep:{Id:0, Name:'Unassigned Leads', Tags:[]}, Timeslots:[]});
            }
            //push row for current user
            //rowList.push({Id:this.currentUser.data?.Id, Rep:this.currentUser.data, Timeslots:[]});
            if(this.currentUser?.data){
                pinnedRepList.push({Id:this.currentUser.data?.Id, Rep:this.currentUser.data, Timeslots:[]});
                repList.push({label: this.currentUser.data?.Name, value: this.currentUser.data?.Id});    
            }
            
            for(var i = 0; i < data.length; i++){
                var curRep = data[i];
                //rowList.push({Id:i+this.rowIndexOffset, Rep:data[i], Timeslots:[]});
                if(curRep?.IsManager){
                    pinnedRepList.push({Id:curRep?.Id, Rep:curRep, Timeslots:[]});
                } else {
                    rowList.push({Id:curRep?.Id, Rep:curRep, Timeslots:[]});
                }
                //rowList.push({Id:curRep?.Id, Rep:curRep, Timeslots:[]});
                repList.push({label: curRep?.Name, value: curRep?.Id});
            }
            //this.rowIndexOffset = data.length+1;
            //console.log('incoming data length: '+data.length);
            
            this.wiredRowList = [...rowList];
            this.repList = repList;
            this.pinnedRowList = [...pinnedRepList];
            this.isLoading = false;
            if(this.template.querySelector('.timeslot-row')){this.timeslotRow = this.template.querySelector('.timeslot-row');} else {
                console.log('timeslotRow not found');
            }

            
            
            
            this.scrollToNow();
            //this.timeslotRow.scrollLeft = this.scrollValue;
            //console.log('wiredRowList length: '+this.wiredRowList.length);            
        }
    }

    @api
    pinnedRowList;

    @api
    wiredRowList;
    //wiredRowList = [{Id:1, Rep:this.exampleRep, Timeslots:[]}];
    get rowsLoaded(){
        if(this.wiredRowList && this.pinnedRowList){
            return true;
        } else {
            return false;
        }
    }

    
    //populate available filters?
    connectedCallback(){
        //console.log('user rec: '+this.currentUser);
        //this.wiredRowList = [this.exampleRow];
        getViews({currentUserId: this.userId}).then(result => {
            console.log('**getviews');
            //console.log(JSON.stringify(result));
            this.availableViewFilters = [...result];

            var filter = this.availableViewFilters[0];
            if(filter?.label == 'All Sales Reps' && this.availableViewFilters.length > 1){ filter = this.availableViewFilters[1]; }
            this.handleViewSelection({detail:{value: filter.value}});

            setTimeout(() => {
                if(this.currentUser?.data?.SalesTeam){
                    console.log('searching for '+this.currentUser?.data?.SalesTeam)
                    for(var cv of this.availableViewFilters){
                        //console.log(cv.label);
                        if(cv.label.includes(this.currentUser?.data?.SalesTeam)){
                            console.log('team found');
                            this.appliedFilters = [...this.basicRepFilters, cv.value, this.searchValue, this.blockedToggleFilter];
                            this.filterViewValue = cv.value;
                            break;
                        }
                    }
                } else {
                    console.log('no sales team found for current user');
                    //console.log(JSON.stringify(this.currentUser));
                }
            }, 500);
            clearInterval(this.dataRefreshIntervalId);            
            clearInterval(this.styleRefreshIntervalId);
            this.dataRefreshIntervalId = setInterval(() => this.refreshTable(), 20*1000);
            this.styleRefreshIntervalId = setInterval(() => this.refreshStyles(), 20*1000);

            //console.log(this.availableViewFilters);
        }).catch(error => console.log(error));
        //console.log('window size: '+window.innerWidth);
        const reportWindowSize = (() => {
            //console.log(window.innerWidth+': '+this.slotsPerPage);
            //this.numberOfPages = 48 / this.slotsPerPage;
            var tableContainer = this.template.querySelector('.table-container');
            if(tableContainer){
                tableContainer.style.setProperty('--table-width', (280+this.slotsPerPage*this.colWidth)+'px');
            }
        });
        window.onresize = reportWindowSize;//.bind(this);
    }

    dateSelected(ev){
        //console.log('dateSelected');
        this.selectedDate = ev.detail.value + this.dateSuffix;
        //console.log(this.selectedDate);
        //console.log(typeof this.selectedDate);
        this.closeMiniDetails();
    }

    viewRightNow(){
        console.log('viewRightNow');
        this.selectedDate = new Date().toISOString().slice(0,10)+this.dateSuffix;
        this.scrollToNow();
        //this.closeMiniDetails();
    }

    dateForward(){
        //console.log('dateForward');
        this.selectedDate = this.incrementDayString(this.selectedDate, 1);
        //console.log(this.selectedDate);
        this.closeMiniDetails();
    }

    dateBackward(){
        //console.log('dateBackward');
        this.selectedDate = this.incrementDayString(this.selectedDate, -1);
        //console.log(this.selectedDate);
        this.closeMiniDetails();
    }
    
    incrementDay(dateString, increment){
        var originalDate = new Date(dateString);
        var day = originalDate.getDate();
        var month = originalDate.getMonth();
        var year = originalDate.getFullYear();
        //console.log(day+' '+month+' '+year);
        return new Date(year, month, day+increment);
    }

    incrementDayString(dateString, increment){
        return this.incrementDay(dateString, increment).toISOString().slice(0,10)+ this.dateSuffix;
    }

    rendered = false;
    renderedCallback(){
        console.log('renderedCallback mcTable.js');
        if(!this.timeslotRow){
            this.timeslotRow = this.template.querySelector('.timeslot-row');
        }
        this.timeslotRow.scrollLeft = this.scrollValue;
        var labelRow = this.template.querySelector('.timeslot-label');
        var tableContainer = this.template.querySelector('.table-container');
        if(labelRow && tableContainer && !this.rendered){
            this.rendered = true;
            //console.log('ladies and gentlemen, we got him.');
            this.colWidth = getComputedStyle(labelRow).getPropertyValue('--column-width').substring(0,3);
            tableContainer.style.setProperty('--table-width', (280+this.slotsPerPage*this.colWidth)+'px');
            //console.log(this.colWidth);
            //this.scrollToNow();
            var pinnedListHeight = this.template.querySelector('.pinned-row-list-item').offsetHeight;// * 1.15;
            var repListHeightOffset = pinnedListHeight+300;
            this.template.querySelector('.row-list-item').style.maxHeight = 'calc(1.0 * (100vh - '+repListHeightOffset+'px))';
        }
        if(!this.currentUser?.data && this.currentUserRetries < 10){
            //console.log('currentUserData not found');
            refreshApex(this.currentUser);
            if(!this.currentUser?.data){this.currentUserRetries++;}
        } else {
            //console.log('currentUserData: '+this.currentUser.data);
        }
        if(this.template.querySelector('.pinned-row-list-item')){
            console.log(this.wiredRowList?.length);
            if(!this.wiredRowList || this.wiredRowList.length == 0){
                this.template.querySelector('.pinned-row-list-item').style.maxHeight = 'calc(100vh - 300px)';
            } else {
                this.template.querySelector('.pinned-row-list-item').style.maxHeight = 'calc(0.3 * (100vh - 300px))'
            }
            console.log(this.template.querySelector('.pinned-row-list-item'));
        } else {
            console.log('pinned row not found');
        }
        //this.template.querySelector('.minidetails').addEventListener("focusin", () => console.log('focus in'));
    }

    rowDraggedFrom;
    rowDraggedFromHandler(ev){
        //console.log('rowDraggedFromHandler(ev)');
        //console.log(ev.detail?.refreshRow);
        this.rowDraggedFrom = ev.detail?.refreshRow;
    }

    //todo: change this to be triggerd by the updaterow event
    onApptDraggedHandler(ev){
        //console.log('onApptDraggedHandler(ev)');
        //console.log(this.rowDraggedFrom);
        if(this.rowDraggedFrom){
            this.rowDraggedFrom();
        }        
    }

    apptClickedHandler(ev){
        //console.log('apptClickedHandler(ev)'); 
        this.miniDetails = ev.detail?.data;
        var miniWindow = this.template.querySelector('.minidetails');
        //console.log(miniWindow);
        miniWindow.focus();
    }

    rowPinnedHandler(ev){
        var row = ev.detail?.rowObj();
        console.log(this.wiredRowList.find(thisRow => thisRow.Id == row.repId));
        console.log(this.pinnedRowList.find(thisRow =>thisRow.Id == row.repId));
        //console.log('row pinned: '+JSON.stringify(row.repId));
        //console.log(JSON.parse(JSON.stringify(this.pinnedRowList[0])));
        var rowIndex = this.pinnedRowList.findIndex(thisRow =>thisRow.Id == row.repId);
        if(rowIndex != -1){
            console.log('found in pinned row');
            console.log({Id: row.repId, Rep: row.rep, Timeslots: row.row.timeslots});
            //his.wiredRowList.push(JSON.parse(JSON.stringify(row)));
            this.wiredRowList = [...this.wiredRowList.toSpliced(this.wiredRowList.length, 0, 
                {Id: row.repId, Rep: row.rep, Timeslots: row.row.timeslots}).sort(this.sortRepHelper.bind(this))];
            this.pinnedRowList = [...this.pinnedRowList.toSpliced(rowIndex, 1)];
        } else {
            rowIndex = this.wiredRowList.findIndex(thisRow =>thisRow.Id == row.repId);
            if(rowIndex != -1){
                console.log('found in wired row');
                console.log({Id: row.repId, Rep: row.rep, Timeslots: row.row.timeslots});
                //this.pinnedRowList.push(JSON.parse(JSON.stringify(row)));
                this.pinnedRowList = [...this.pinnedRowList.toSpliced(this.pinnedRowList.length, 0, 
                    {Id: row.repId, Rep: row.rep, Timeslots: row.row.timeslots}).sort(this.sortRepHelper.bind(this))];
                this.wiredRowList = [...this.wiredRowList.toSpliced(rowIndex, 1)];
            }
        }
        console.log(this.template.querySelector('.pinned-row-list-item'));
        console.log(this.template.querySelector('.pinned-row-list-item')?.offsetHeight);
        
        var pinnedListHeight = this.template.querySelector('.pinned-row-list-item').offsetHeight;// * 1.15;
        var repListHeightOffset = pinnedListHeight+300;
        this.template.querySelector('.row-list-item').style.maxHeight = 'calc(0.80 * (100vh - '+repListHeightOffset+'px))';
        // console.log(JSON.stringify(this.pinnedRowList));
        // console.log(JSON.stringify(this.wiredRowList));
    }

    closeMiniDetails(ev){
        //console.log('closeMiniDetails');
        this.miniDetails=null;
    }

    focusHandler(ev){
        //console.log('hey look I have the focus');      
    }

    

    rowScrollHandler(ev){
        //console.log('rowScrollHandler '+ev.detail.scrollLeft);
        this.scrollValue = ev.detail.scrollLeft;
    }

    // handleToggle(ev){
    //     console.log(ev.target.checked);
    //     this.toggleValue=ev.target.checked;
    //     this.appliedFilters = [this.filterViewValue, this.searchValue, this.blockedToggleFilter];
    // }

    get showToggle(){
        return this.todayDateString == this.selectedDate;
    }

    @api
    blockToggled = false;

    handleBlockToggle(ev){
        
        this.blockToggled = !this.blockToggled;
        //console.log('toggle: '+ this.blockToggled);
    }

    handleSearch(ev){
        //console.log(ev.target.value);
        if(ev.target.value){
            this.searchValue='Name LIKE \'%'+ev.target.value+'%\'';
        } else {
            this.searchValue=null;
        }
        if(this.queryNonReps){
            this.appliedFilters = [this.filterViewValue, this.searchValue, this.blockedToggleFilter];
        } else {
            this.appliedFilters = [...this.basicRepFilters, this.filterViewValue, this.searchValue, this.blockedToggleFilter];
        }
        //this.appliedFilters = [this.filterViewValue, this.searchValue, this.blockedToggleFilter];
        //this.filterMap = new Map([[this.queryNonReps, this.appliedFilters]]);
        //console.log(this.appliedFilters);
    }

    generateTestData(ev){
        this.isLoading = true;
        generateData({
            filterList:[...this.appliedFilters].filter(x=>x)
        }).then(()=>{
            this.isLoading = false;
            this.scrollToNow();
        }).catch((error)=>{
            this.isLoading = false;
            //console.log(error);
        });
    }

    toggleLoading(ev){
        this.isLoading = !this.isLoading;
    }

    @api
    get numberOfPages(){
        return 48 / this.slotsPerPage;
    } 

    @api
    scrollValue = 1;
    pageValue = 0;
    //slotsPerPage = 6;
    
    timeslotRow;
    colWidth = 240;

    get computedScrollValue(){
        return this.pageValue*this.slotsPerPage*this.colWidth;
    }

    pageForward(ev){
        //console.log('pageForward');
        //console.log('colWidth: '+this.colWidth);
        if(this.pageValue < (this.numberOfPages-1) && this.timeslotRow){            
            this.pageValue = this.roundPageNumber(this.pageValue+1);
            this.scrollTo(this.computedScrollValue);                  
        }
    }

    pageBackward(ev){
        //console.log('pageBackward');
        if(this.pageValue > 0 && this.timeslotRow){
            this.pageValue = this.roundPageNumber(this.pageValue-1);
            this.scrollTo(this.computedScrollValue);            
        }
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

    scrollTo(scrollVal){
        console.log('scrollTo '+scrollVal);
        this.scrollValue = scrollVal;
        if(this.timeslotRow){this.timeslotRow.scrollLeft = scrollVal;}
        
        setTimeout((val) => {
            var timeslotRow = this.template.querySelector('.timeslot-row');
            if(timeslotRow && !this.timeslotRow){
                this.timeslotRow = timeslotRow;
            }
            if(timeslotRow){
                timeslotRow.scrollLeft = val;
            }
            //console.log('timeslotRow: '+JSON.stringify(timeslotRow));
            //console.log('timeout val: '+val);
        }, 200, scrollVal);
        
        //console.log(this.template.querySelector('.timeslot-row')?.scrollLeft);
        // console.log('pageNumber: '+this.pageValue);
        this.closeMiniDetails();
    }

    scrollToNow(){
        var curTime = new Date().toISOString();
        console.log('scrollToNow '+curTime);
        var hours = Number(curTime.slice(11,13)-4);
        var min = Number(curTime.slice(14,16));
        //console.log(hours+' '+min);
        var timeslotNumber = (hours*2) + (min >= 30 ? 1 : 0);
        //var pageNumber = Math.floor(timeslotNumber / this.slotsPerPage);
        var pageNumber = (timeslotNumber-1) / this.slotsPerPage;
        this.pageValue = this.roundPageNumber(pageNumber);
        this.scrollTo(this.computedScrollValue);
    }

    reassignmentHandler(ev){
        var newRepId = ev.detail?.newRepId;
        var oldRepId = ev.detail?.oldRepId;
        var rowList = this.template.querySelectorAll('c-mc-row');
        //console.log('rowlist.length: '+rowList.length);
        //console.log('newRepId: '+newRepId);
        //console.log('oldRepId: '+oldRepId);
        rowList.forEach((thisRow) => {
            //console.log(thisRow);
            var rowRepId = thisRow?.rep?.Id;
            if(rowRepId){
                //console.log('rowRepId: '+rowRepId);
                if(rowRepId == newRepId || rowRepId == oldRepId){
                    thisRow.refreshApexData();
                }
            }            
        });
    }

    refreshTable(ev){
        var rowList = this.template.querySelectorAll('c-mc-row');        
        rowList.forEach((thisRow) => {
            var rowRepId = thisRow?.rep?.Id;
            if(rowRepId || rowRepId == 0){
                thisRow.refreshApexData();                
            } else {
                console.log(JSON.stringify(thisRow?.rep));
            }
        });
        
        //console.log('table.refreshTable()');
        //window.location.reload();
        //refreshApex(this.wireResults);
    }

    refreshStyles(ev){
        var rowList = this.template.querySelectorAll('c-mc-row');        
        rowList.forEach((thisRow) => {
            var rowRepId = thisRow?.rep?.Id;
            if(rowRepId || rowRepId == 0){
                thisRow.refreshTimeslotStyles();                
            } else {
                console.log(JSON.stringify(thisRow?.rep));
            }
        });
        
        //console.log('table.refreshTable()');
        //window.location.reload();
        //refreshApex(this.wireResults);
    }

    disconnectedCallback(){
        clearInterval(this.dataRefreshIntervalId);
        clearInterval(this.styleRefreshIntervalId);
    }

    get showTestButton(){
        return (this.environmentName?.data && this.environmentName?.data != 'production');
    }


    launchBlockFlow(ev){
        this.showBlockFlow = true;
    }

    handleFlowStatusChange(ev){
        //console.log(ev.detail.status);
        if (ev.detail.status === 'FINISHED'){
            this.showBlockFlow = false;
        }
        console.log('this.showBlockFlow: '+this.showBlockFlow);
    }
}