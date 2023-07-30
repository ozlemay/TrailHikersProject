import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import SA_LIST_UPDATE_MESSAGE from '@salesforce/messageChannel/SAListUpdate__c';
import { NavigationMixin } from 'lightning/navigation';
import searchSas from '@salesforce/apex/SAManager.searchSas';

export default class SAManageApex extends NavigationMixin(LightningElement) {
  searchTerm = '';
  sadetails;
  delayTimeout;

  @wire(MessageContext) messageContext;

  @wire(searchSas, { searchTerm: '$searchTerm' })
  loadSAdetails(result) {
    this.sadetails = result;

    if (result.data) {
      const message = {
        sadetails: result.data
      };
      publish(this.messageContext, SA_LIST_UPDATE_MESSAGE, message);
    }
  }

  handleSearchTermChange(event) {
    clearTimeout(this.delayTimeout);
    const searchTerm = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.searchTerm = searchTerm;
    }, 300);
  }

  get hasResults() {
    return this.sadetails && this.sadetails.data && this.sadetails.data.length > 0;
  }

  handleSAView(event) {
    const saId = event.detail;
    this[NavigationMixin.Navigate]({
      type: 'standard__recordPage',
      attributes: {
        recordId: saId,
        objectApiName: 'SA_Detail__c',
        actionName: 'view'
      }
    });
  }
}