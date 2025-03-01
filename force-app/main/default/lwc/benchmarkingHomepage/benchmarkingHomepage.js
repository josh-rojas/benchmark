import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { loadStyle } from 'lightning/platformResourceLoader';
import benchmarkingStyles from '@salesforce/resourceUrl/benchmarkingStyles';
import userId from '@salesforce/user/Id';
import getBenchmarkFirm from '@salesforce/apex/BenchmarkingController.getBenchmarkFirm';

export default class BenchmarkingHomepage extends LightningElement {
    userId = userId;
    firmData;
    lastSubmission;
    isLoading = true;
    error;
    
    @wire(CurrentPageReference)
    pageRef;
    
    connectedCallback() {
        Promise.all([
            loadStyle(this, benchmarkingStyles + '/css/benchmarking.css')
        ])
        .then(() => {
            this.loadFirmData();
        })
        .catch(error => {
            this.error = 'Error loading stylesheets: ' + error.body.message;
        });
    }
    
    loadFirmData() {
        this.isLoading = true;
        getBenchmarkFirm({ userId: this.userId })
            .then(result => {
                this.firmData = result;
                this.lastSubmission = result.lastSubmission;
                this.error = undefined;
            })
            .catch(error => {
                this.error = 'Error retrieving firm data: ' + error.body.message;
                this.firmData = undefined;
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
    
    get hasSubmissionHistory() {
        return this.lastSubmission && this.lastSubmission.Submission_Date__c;
    }
    
    get welcomeMessage() {
        return this.firmData ? 
            `Welcome, ${this.firmData.Firm_Identifier__c}` : 
            'Welcome to the Benchmarking Platform';
    }
    
    navigateToSubmit() {
        const submitEvent = new CustomEvent('navigate', {
            detail: {
                target: '/submit-benchmark'
            }
        });
        this.dispatchEvent(submitEvent);
    }
    
    navigateToResults() {
        const resultEvent = new CustomEvent('navigate', {
            detail: {
                target: '/view-benchmarks'
            }
        });
        this.dispatchEvent(resultEvent);
    }
} 