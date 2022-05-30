import { LightningElement, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import getSimilarAccountsAction from "@salesforce/apex/SimilarAccountsController.getSimilarAccountsAction";

const columns = [
    { label: 'Account Name', fieldName: 'Account_Name__c', actions: {} },
    { label: 'Website', fieldName: 'Website__c', type: 'url', actions: {} },
];

export default class newAccountForm extends NavigationMixin(LightningElement) {
    @api recordId;
    @track similarAccounts = false;

    columns = columns;
    newAccountFields;

    handleSubmit(event){
        event.preventDefault();

        const fields = event.detail.fields;
        this.newAccountFields = fields;
        
        getSimilarAccountsAction({accountName: fields.Name, accountWebsite: fields.Website})
        .then((result) => {
            if (result.length > 0){
                this.template.querySelector('lightning-record-form').classList.add('slds-hide');
                this.similarAccounts = result;
            } else {
                this.template.querySelector('lightning-record-form').submit(fields);
            }
        })
        .catch((error) => {
            console.log(error);
        });
     }

     handleSubmitAnyway(){
        this.template.querySelector('lightning-record-form').submit(this.newAccountFields);
        this.handleBack();
     }

     handleBack(){
        this.similarAccounts = false;
        this.template.querySelector('lightning-record-form').classList.remove('slds-hide');
     }

     handleCancel(event){
         this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            }
        });
     }

     handleSuccess(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                actionName: 'view'
            }
        });
     }
}