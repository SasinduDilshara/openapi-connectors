// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# This is a generated connector for [Avaza API v1](https://api.avaza.com/swagger/ui/index) OpenAPI specification.
# Avaza API allows to collaborate on projects, chat, schedule resources, track time, manage expenses & invoice customers.
@display {label: "Avaza", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials.
    # Create a [Avaza account](https://signup.avaza.com/account/signup) and obtain tokens by following [this guide](https://www.avaza.com/avaza-api-oauth2-authentication/).  
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.avaza.com/") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Account Details
    #
    # + return - Success 
    remote isolated function accountGet() returns AccountDetails|error {
        string resourcePath = string `/api/Account`;
        AccountDetails response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets minimal list of Companies.
    #
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + search - Search string to match against Company title 
    # + return - OK 
    remote isolated function companyLookup(int? pageSize = (), int? pageNumber = (), string? search = ()) returns CompanyDropdownList|error {
        string resourcePath = string `/api/Company/Lookup`;
        map<anydata> queryParam = {"pageSize": pageSize, "pageNumber": pageNumber, "search": search};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CompanyDropdownList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Companies
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + pageSize - Number of results per page 
    # + pageNumber - 1 based page number to retrieve 
    # + sort - (optional) Supply one of: "DateUpdated", "DateCreated", "CompanyName","DateUpdated desc","DateCreated desc", "CompanyName desc" 
    # + return - Success 
    remote isolated function companyGet(string? updatedAfter = (), int? pageSize = (), int? pageNumber = (), string? sort = ()) returns CompanyList|error {
        string resourcePath = string `/api/Company`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CompanyList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a Company record.
    #
    # + payload - A record of type `UpdateCompany` which contains the necessary data to update company 
    # + return - OK 
    remote isolated function companyPut(UpdateCompany payload) returns Company|error {
        string resourcePath = string `/api/Company`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Company response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Create a Company
    #
    # + payload - A record of type `NewCompany` which contains the necessary data to create company 
    # + return - Success 
    remote isolated function companyPost(NewCompany payload) returns Company|error {
        string resourcePath = string `/api/Company`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Company response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Gets Company by Company ID
    #
    # + id - Company ID Number 
    # + return - Success 
    remote isolated function companyGetbyid(int id) returns Company|error {
        string resourcePath = string `/api/Company/${getEncodedUri(id)}`;
        Company response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Contacts
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + sort - Sort method 
    # + companyIDFK - Company related to contacts 
    # + return - Success 
    remote isolated function contactGet(string? updatedAfter = (), int? pageSize = (), int? pageNumber = (), string? sort = (), int? companyIDFK = ()) returns ContactList|error {
        string resourcePath = string `/api/Contact`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort, "CompanyIDFK": companyIDFK};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ContactList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a Contact
    #
    # + payload - A record of type `NewCompanyContact` which contains the necessary data to create contact 
    # + return - Success 
    remote isolated function contactPost(NewCompanyContact payload) returns CompanyContact|error {
        string resourcePath = string `/api/Contact`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        CompanyContact response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Gets Contact by Contact ID
    #
    # + id - Contact ID number 
    # + return - Success 
    remote isolated function contactGetbyid(int id) returns CompanyContact|error {
        string resourcePath = string `/api/Contact/${getEncodedUri(id)}`;
        CompanyContact response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of CreditNotes
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + return - Success 
    remote isolated function creditnoteGet(string? updatedAfter = (), int? pageSize = (), int? pageNumber = ()) returns CreditNoteList|error {
        string resourcePath = string `/api/CreditNote`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "pageSize": pageSize, "pageNumber": pageNumber};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        CreditNoteList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets Credit Note by CreditNoteID
    #
    # + id - Credit Note ID Number 
    # + return - Success 
    remote isolated function creditnoteGetbyid(int id) returns CreditNote|error {
        string resourcePath = string `/api/CreditNote/${getEncodedUri(id)}`;
        CreditNote response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Currencies
    #
    # + return - Success 
    remote isolated function currencyGet() returns CurrencyList|error {
        string resourcePath = string `/api/Currency`;
        CurrencyList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Estimates
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + sort - Sort method 
    # + companyIDFK - Company related to estimates 
    # + return - Success 
    remote isolated function estimateGet(string? updatedAfter = (), int? pageSize = (), int? pageNumber = (), string? sort = (), int? companyIDFK = ()) returns EstimateList|error {
        string resourcePath = string `/api/Estimate`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort, "CompanyIDFK": companyIDFK};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        EstimateList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a new draft Estimate
    #
    # + payload - A record of type `NewEstimate` which contains the necessary data to create a new draft estimate 
    # + return - OK 
    remote isolated function estimatePost(NewEstimate payload) returns EstimateDetails|error {
        string resourcePath = string `/api/Estimate`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        EstimateDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Gets Estimate by Estimate ID
    #
    # + id - Estimate Estimate ID number 
    # + return - Unauthorized 
    remote isolated function estimateGetbyid(int id) returns http:Response|error {
        string resourcePath = string `/api/Estimate/${getEncodedUri(id)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create expense attachment
    #
    # + payload - Request to create expense attachment 
    # + return - OK 
    remote isolated function expenseAttachment(ExpenseAttachmentBody payload) returns ExpenseAttachmentUploadResult|error {
        string resourcePath = string `/api/Expense/Attachment`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ExpenseAttachmentUploadResult response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Submit Expenses for Approval.
    #
    # + userID - The user to submit the Expenses for. Defaults to current user. Only allowed to be different from the current user when the current user has rights to Impersonate other users. 
    # + sendNotifications - Send email alerts to expense approvers. Defaults to true 
    # + payload - A collection of ExpenseID's that should be submitted for approval. If not provided, submits all verified expenses for approval. 
    # + return - OK 
    remote isolated function expenseApproval(int[] payload, int? userID = (), boolean? sendNotifications = ()) returns json|error {
        string resourcePath = string `/api/ExpenseApproval/Submit`;
        map<anydata> queryParam = {"UserID": userID, "SendNotifications": sendNotifications};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        json response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Gets list of Expenses
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + expenseDateFrom - Start date to filter 
    # + expenseDateTo - End date to filter 
    # + userEmail - User email address 
    # + userID - User Id 
    # + categoryName - Category name 
    # + customerID - Customer Id 
    # + projectID - Project Id 
    # + isChargeable - Chargeable status 
    # + isInvoiced - Invoiced status 
    # + expenseReimbursementIDFK - Expense reimbursement 
    # + expensePaymentMethodIDFK - Expense payment method 
    # + expenseApprovalStatusCode - Expense apprval status code 
    # + search - Search query 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + sort - Sort method 
    # + return - Success 
    remote isolated function expenseGet(string? updatedAfter = (), string? expenseDateFrom = (), string? expenseDateTo = (), string? userEmail = (), int? userID = (), string? categoryName = (), int? customerID = (), int? projectID = (), boolean? isChargeable = (), boolean? isInvoiced = (), int? expenseReimbursementIDFK = (), int? expensePaymentMethodIDFK = (), string? expenseApprovalStatusCode = (), string? search = (), int? pageSize = (), int? pageNumber = (), string? sort = ()) returns ExpenseList|error {
        string resourcePath = string `/api/Expense`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "ExpenseDateFrom": expenseDateFrom, "ExpenseDateTo": expenseDateTo, "UserEmail": userEmail, "UserID": userID, "CategoryName": categoryName, "CustomerID": customerID, "ProjectID": projectID, "isChargeable": isChargeable, "isInvoiced": isInvoiced, "ExpenseReimbursementIDFK": expenseReimbursementIDFK, "ExpensePaymentMethodIDFK": expensePaymentMethodIDFK, "ExpenseApprovalStatusCode": expenseApprovalStatusCode, "Search": search, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ExpenseList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an Expense
    #
    # + payload - A record of type `UpdateExpense` which contains the necessary data to update expense 
    # + return - OK 
    remote isolated function expensePut(UpdateExpense payload) returns ExpenseDetails|error {
        string resourcePath = string `/api/Expense`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ExpenseDetails response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Create an Expense
    #
    # + payload - A record of type `NewExpense` which contains the necessary data to create expense 
    # + return - OK 
    remote isolated function expensePost(NewExpense payload) returns ExpenseDetails|error {
        string resourcePath = string `/api/Expense`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ExpenseDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a Timesheet Entry
    #
    # + return - OK 
    remote isolated function expenseDelete() returns ExpenseDeleteResultSet|error {
        string resourcePath = string `/api/Expense`;
        ExpenseDeleteResultSet response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Gets an Expense Entry by Expense ID
    #
    # + id - Expense ID number 
    # + return - Success 
    remote isolated function expenseGetbyid(int id) returns ExpenseDetails|error {
        string resourcePath = string `/api/Expense/${getEncodedUri(id)}`;
        ExpenseDetails response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Expense Categories
    #
    # + isEnabled - Optional filter on for enabled/disabled categories. Defaults to true. 
    # + return - Success 
    remote isolated function expensecategoryGet(boolean? isEnabled = ()) returns ExpenseCategoryList|error {
        string resourcePath = string `/api/ExpenseCategory`;
        map<anydata> queryParam = {"isEnabled": isEnabled};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ExpenseCategoryList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets minimal list of Expense Groups.
    #
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + search - Search string to match against Expense Group Name 
    # + return - OK 
    remote isolated function expenseGroupLookup(int? pageSize = (), int? pageNumber = (), string? search = ()) returns ExpenseGroupDropdownList|error {
        string resourcePath = string `/api/ExpenseGroup/Lookup`;
        map<anydata> queryParam = {"pageSize": pageSize, "pageNumber": pageNumber, "search": search};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ExpenseGroupDropdownList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets minimal list of Expense Merchants.
    #
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + search - Search string to match against Expense Group Name 
    # + return - OK 
    remote isolated function expenseMerchangeLookup(int? pageSize = (), int? pageNumber = (), string? search = ()) returns ExpenseMerchantDropdownList|error {
        string resourcePath = string `/api/ExpenseMerchant/Lookup`;
        map<anydata> queryParam = {"pageSize": pageSize, "pageNumber": pageNumber, "search": search};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ExpenseMerchantDropdownList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets minimal list of Expense Payment Methods.
    #
    # + return - OK 
    remote isolated function expensePaymentMethodLookup() returns ExpensePaymentMethodDropdownList|error {
        string resourcePath = string `/api/ExpensePaymentMethod/Lookup`;
        ExpensePaymentMethodDropdownList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets Basic Summary of Expense Statistics
    #
    # + modelGroupby - (Optional) Combine one, two or three levels of Grouping. Combine these possible grouping values: "Category", "ChargeableStatus", "Merchant", "ApprovalStatus", "ReimbursementStatus", "Customer", "Project", "User", "Task", "Year", "Month", "Day", "Week". 
    # + modelExpensedatefrom - (Required) Filter for expenses with expense dates greater or equal to the specified date. e.g. 2019-01-25. 
    # + modelExpensedateto - (Required) Filter for expenses with an expense date smaller or equal to the specified  date. e.g. 2019-01-25. 
    # + modelUserid - (Optional) Defaults to the current user. Provide one or more UserIDs of Users whose expenses should be retrieved. If the current user doesn't have impersonation rights, then they will only see their own data. 
    # + modelProjectid - (Optional) Filter by Project 
    # + return - OK 
    remote isolated function expensesummaryGet(string[]? modelGroupby = (), string? modelExpensedatefrom = (), string? modelExpensedateto = (), int[]? modelUserid = (), int? modelProjectid = ()) returns ExpenseSummaryResult|error {
        string resourcePath = string `/api/ExpenseSummary`;
        map<anydata> queryParam = {"model.groupBy": modelGroupby, "model.expenseDateFrom": modelExpensedatefrom, "model.expenseDateTo": modelExpensedateto, "model.userID": modelUserid, "model.projectID": modelProjectid};
        map<Encoding> queryParamEncoding = {"model.groupBy": {style: FORM, explode: true}, "model.userID": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        ExpenseSummaryResult response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Fixed Amounts
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + entryDateFrom - Start date to filter 
    # + entryDateTo - End date to filter 
    # + projectID - (Optional) The ProjectID of a Project to filter Fixed Amounts for 
    # + taskID - (Optional) The TaskID of a Task to filter Fixed Amounts for 
    # + isInvoiced - Invoiced status 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + sort - Optional sorting instruction. Currently possible values: "DateUpdated", "DateCreated", "DateUpdated desc", "DateCreated desc","EntryDate", "EntryDate desc", "StartTimeLocal","StartTimeLocal desc", "TimeSheetEntryID", "TimeSheetEntryID desc" 
    # + return - Success 
    remote isolated function fixedamountGet(string? updatedAfter = (), string? entryDateFrom = (), string? entryDateTo = (), int? projectID = (), int? taskID = (), boolean? isInvoiced = (), int? pageSize = (), int? pageNumber = (), string? sort = ()) returns FixedAmountList|error {
        string resourcePath = string `/api/FixedAmount`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "EntryDateFrom": entryDateFrom, "EntryDateTo": entryDateTo, "ProjectID": projectID, "TaskID": taskID, "isInvoiced": isInvoiced, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        FixedAmountList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Inventory
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + return - Success 
    remote isolated function inventoryGet(string? updatedAfter = (), int? pageSize = (), int? pageNumber = ()) returns InventoryList|error {
        string resourcePath = string `/api/Inventory`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "pageSize": pageSize, "pageNumber": pageNumber};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        InventoryList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets InventoryItem by InventoryItem ID
    #
    # + id - InventoryItem ID number 
    # + return - Unauthorized 
    remote isolated function inventoryGetbyid(int id) returns http:Response|error {
        string resourcePath = string `/api/Inventory/${getEncodedUri(id)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Invoices
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + sort - Sort method 
    # + companyIDFK - Invoice issued company 
    # + return - Success 
    remote isolated function invoiceGet(string? updatedAfter = (), int? pageSize = (), int? pageNumber = (), string? sort = (), int? companyIDFK = ()) returns InvoiceList|error {
        string resourcePath = string `/api/Invoice`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort, "CompanyIDFK": companyIDFK};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        InvoiceList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a new draft invoice
    #
    # + payload - A record of type `NewInvoice` which contains the necessary data to create invoice 
    # + return - OK 
    remote isolated function invoicePost(NewInvoice payload) returns Invoice|error {
        string resourcePath = string `/api/Invoice`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Invoice response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Gets Invoice by Invoice ID
    #
    # + id - Invoice Transaction ID number 
    # + return - Unauthorized 
    remote isolated function invoiceGetbyid(int id) returns http:Response|error {
        string resourcePath = string `/api/Invoice/${getEncodedUri(id)}`;
        http:Response response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Payments
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + return - Success 
    remote isolated function paymentGet(string? updatedAfter = (), int? pageSize = (), int? pageNumber = ()) returns PaymentList|error {
        string resourcePath = string `/api/Payment`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "pageSize": pageSize, "pageNumber": pageNumber};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        PaymentList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create new Payment and optionally assign payment allocations to Invoices
    #
    # + payload - A record of type `NewPayment` which contains the necessary data to create payment 
    # + return - OK 
    remote isolated function paymentPost(NewPayment payload) returns Payment|error {
        string resourcePath = string `/api/Payment`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Payment response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Gets Payment by Payment Transaction ID
    #
    # + id - Invoice Transaction ID Number 
    # + return - Success 
    remote isolated function paymentGetbyid(int id) returns Payment|error {
        string resourcePath = string `/api/Payment/${getEncodedUri(id)}`;
        Payment response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets minimal list of active Projects for the current user
    #
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + timesheetUserID - Optionally Filter to the projects that the supplied UserID can add timesheets to 
    # + companyIDFK - Optionally Filter for a specific Company ID 
    # + search - Search string to match against Project title and Customer name 
    # + return - OK 
    remote isolated function projectLookup(int? pageSize = (), int? pageNumber = (), int? timesheetUserID = (), int? companyIDFK = (), string? search = ()) returns ProjectDropdownList|error {
        string resourcePath = string `/api/Project/Lookup`;
        map<anydata> queryParam = {"pageSize": pageSize, "pageNumber": pageNumber, "TimesheetUserID": timesheetUserID, "CompanyIDFK": companyIDFK, "search": search};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ProjectDropdownList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Projects
    #
    # + updatedAfter - Only show project records updated after a certain date (UTC) 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + sort - A column to sort on. Current possible values: "DateUpdated", "DateCreated", "DateUpdated desc", "DateCreated desc" 
    # + timesheetUserID - Filter to the projects that the supplied UserID can add timesheets to 
    # + includeArchived - Include Archived Projects in the results 
    # + return - OK 
    remote isolated function projectGet(string? updatedAfter = (), int? pageSize = (), int? pageNumber = (), string? sort = (), int? timesheetUserID = (), boolean? includeArchived = ()) returns ProjectList|error {
        string resourcePath = string `/api/Project`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort, "TimesheetUserID": timesheetUserID, "includeArchived": includeArchived};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ProjectList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an Project
    #
    # + payload - A record of type `UpdateProjectModel` which contains the necessary data to update project 
    # + return - OK 
    remote isolated function projectPut(UpdateProjectModel payload) returns ProjectDetails|error {
        string resourcePath = string `/api/Project`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ProjectDetails response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Create a Project
    #
    # + payload - A record of type `NewProjectModel` which contains the necessary data to create project 
    # + return - Success 
    remote isolated function projectPost(NewProjectModel payload) returns ProjectDetails|error {
        string resourcePath = string `/api/Project`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ProjectDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Gets Project by Project ID
    #
    # + id - Project ID number 
    # + return - Success 
    remote isolated function projectGetbyid(int id) returns ProjectDetails|error {
        string resourcePath = string `/api/Project/${getEncodedUri(id)}`;
        ProjectDetails response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Assign a user as a Member of a Project
    #
    # + payload - A record of type `NewProjectMember` which contains the necessary data to assign user to project 
    # + return - OK 
    remote isolated function projectmemberPost(NewProjectMember payload) returns ProjectMemberDetails|error {
        string resourcePath = string `/api/ProjectMember`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ProjectMemberDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Gets list of Project Timesheet Categories
    #
    # + projectID - Get categories filtered by ProjectID 
    # + return - Success 
    remote isolated function projecttimesheetcategoryGet(int? projectID = ()) returns ProjectTimesheetCategoryList|error {
        string resourcePath = string `/api/ProjectTimesheetCategory`;
        map<anydata> queryParam = {"ProjectID": projectID};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ProjectTimesheetCategoryList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Schedule Assignments.
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + scheduleDateFrom - Filter for schedule assignement  that are  on or after a specific date 
    # + scheduleDateTo - Filter for schedules that are on or before a specific date 
    # + scheduleSeriesID - Filter to records for a particular Schedule Series 
    # + userID - The UserID of a schedule user to filter assignments for. Only api users with Admin role can see all schedules across all users. Users with ScheduleUser role can access their own ScheduleSeries. 
    # + userEmail - The email of the user who has been scheduled 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + sort - Optional sorting instruction. Currently possible values: "DateUpdated", "DateCreated", "DateUpdated desc", "DateCreated desc" 
    # + return - Success 
    remote isolated function scheduleassignmentGet(string? updatedAfter = (), string? scheduleDateFrom = (), string? scheduleDateTo = (), int? scheduleSeriesID = (), int? userID = (), string? userEmail = (), int? pageSize = (), int? pageNumber = (), string? sort = ()) returns ScheduleAssignmentList|error {
        string resourcePath = string `/api/ScheduleAssignment`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "ScheduleDateFrom": scheduleDateFrom, "ScheduleDateTo": scheduleDateTo, "ScheduleSeriesID": scheduleSeriesID, "UserID": userID, "UserEmail": userEmail, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ScheduleAssignmentList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create new Schedule Booking
    #
    # + payload - A record of type `CreateBooking` which contains the necessary data to create schedule booking 
    # + return - OK 
    remote isolated function scheduleseriesAddbooking(CreateBooking payload) returns ScheduleSeriesDetails|error {
        string resourcePath = string `/ScheduleSeries/AddBooking`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ScheduleSeriesDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Create new Leave Booking
    #
    # + payload - A record of type `CreateLeave` which contains the necessary data to create leave booking 
    # + return - OK 
    remote isolated function scheduleseriesAddleave(CreateLeave payload) returns ScheduleSeriesDetails|error {
        string resourcePath = string `/ScheduleSeries/AddLeave`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ScheduleSeriesDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Edit Leave Booking
    #
    # + payload - A record of type `EditLeave` which contains the necessary data to edit leave booking 
    # + return - OK 
    remote isolated function scheduleseriesEditleave(EditLeave payload) returns ScheduleSeriesDetails|error {
        string resourcePath = string `/ScheduleSeries/EditLeave`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ScheduleSeriesDetails response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Edit Booking
    #
    # + payload - A record of type `EditBooking` which contains the necessary data to edit booking 
    # + return - OK 
    remote isolated function scheduleseriesEditbooking(EditBooking payload) returns ScheduleSeriesDetails|error {
        string resourcePath = string `/ScheduleSeries/EditBooking`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ScheduleSeriesDetails response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Gets list of Schedule Series
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + scheduleStartDateFrom - Filter for schedules that start on or after a specific date 
    # + scheduleStartDateTo - Filter for schedules that start on or before a specific date 
    # + scheduleEndDateFrom - Filter for schedules that end on or after a specific date 
    # + scheduleEndDateTo - Filter for schedules that end on or before a specific date 
    # + userID - The UserID of a schedule user to filter assignments for. Only api users with Admin role can see all schedules across all users. Users with ScheduleUser role can access their own ScheduleSeries. 
    # + userEmail - The email of the user who has been scheduled 
    # + timeSheetCategoryID - Filter for schedule records linked to a specific timesheeet category 
    # + timeSheetCategoryName - Filter for schedule records with a specific timesheeet category name (exact string match) 
    # + leaveTypeID - Filter to records of a particular leave type 
    # + projectID - Filter to only include books linked to a specific project 
    # + companyID - Filter to only include records linked to projects, where that project belongs to a specific customer company 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + sort - Optional sorting instruction. Currently possible values: "DateUpdated", "DateCreated", "DateUpdated desc", "DateCreated desc" 
    # + return - Success 
    remote isolated function scheduleseriesGet(string? updatedAfter = (), string? scheduleStartDateFrom = (), string? scheduleStartDateTo = (), string? scheduleEndDateFrom = (), string? scheduleEndDateTo = (), int? userID = (), string? userEmail = (), int? timeSheetCategoryID = (), string? timeSheetCategoryName = (), int? leaveTypeID = (), int? projectID = (), int? companyID = (), int? pageSize = (), int? pageNumber = (), string? sort = ()) returns ScheduleSeriesList|error {
        string resourcePath = string `/api/ScheduleSeries`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "ScheduleStartDateFrom": scheduleStartDateFrom, "ScheduleStartDateTo": scheduleStartDateTo, "ScheduleEndDateFrom": scheduleEndDateFrom, "ScheduleEndDateTo": scheduleEndDateTo, "UserID": userID, "UserEmail": userEmail, "TimeSheetCategoryID": timeSheetCategoryID, "TimeSheetCategoryName": timeSheetCategoryName, "LeaveTypeID": leaveTypeID, "ProjectID": projectID, "CompanyID": companyID, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        ScheduleSeriesList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Sections
    #
    # + projectID - Get sections for Project with ProjectID 
    # + return - Success 
    remote isolated function sectionGet(int projectID) returns SectionList|error {
        string resourcePath = string `/api/Section`;
        map<anydata> queryParam = {"ProjectID": projectID};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        SectionList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Create a Section
    #
    # + payload - A record of type `NewSection` which contains the necessary data to create section 
    # + return - OK 
    remote isolated function sectionPost(NewSection payload) returns SectionDetails|error {
        string resourcePath = string `/api/Section`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        SectionDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a Section
    #
    # + sectionID - Unique identifier for section 
    # + return - OK 
    remote isolated function sectionDelete(int sectionID) returns json|error {
        string resourcePath = string `/api/Section`;
        map<anydata> queryParam = {"SectionID": sectionID};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        json response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Gets minimal list of Tasks for the current user
    #
    # + projectID - (required) The ProjectID to use when filtering Tasks 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + hideCompleted - (optional) true/false to hide completed tasks. Defaults false 
    # + search - (optional) Search string to match against Task title. Performs begins-with match 
    # + return - OK 
    remote isolated function taskLookup(int projectID, int? pageSize = (), int? pageNumber = (), boolean? hideCompleted = (), string? search = ()) returns TaskDropdownList|error {
        string resourcePath = string `/api/Task/Lookup`;
        map<anydata> queryParam = {"projectID": projectID, "pageSize": pageSize, "pageNumber": pageNumber, "hideCompleted": hideCompleted, "search": search};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TaskDropdownList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Tasks
    #
    # + updatedAfter - Optional filter to records updated after a specific date. 
    # + pageSize - Number of items per page. Defaults to 20. 
    # + pageNumber - Page to display. Starts from 1. Defaults to 1 
    # + sort - Optional sorting instruction. Currently possible values: "DateUpdated", "DateCreated", "DateUpdated desc", "DateCreated desc", "SectionTitle", "Title" 
    # + isComplete - Optional filter to only display tasks linked to a Task Status where isComplete=false, or where isComplete=true 
    # + projectID - Optional filter to only display tasks belonging to a specific ProjectID 
    # + return - Success 
    remote isolated function taskGet(string? updatedAfter = (), int? pageSize = (), int? pageNumber = (), string? sort = (), boolean? isComplete = (), int? projectID = ()) returns TaskList|error {
        string resourcePath = string `/api/Task`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort, "isComplete": isComplete, "ProjectID": projectID};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TaskList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a Task.
    #
    # + payload - A record of type `UpdateTask` which contains the necessary data to update task 
    # + return - OK 
    remote isolated function taskPut(UpdateTask payload) returns TaskDetails|error {
        string resourcePath = string `/api/Task`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        TaskDetails response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Create a Task
    #
    # + payload - A record of type `NewTask` which contains the necessary data to create task 
    # + return - OK 
    remote isolated function taskPost(NewTask payload) returns TaskDetails|error {
        string resourcePath = string `/api/Task`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        TaskDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete a Task
    #
    # + taskID - Task Id 
    # + return - OK 
    remote isolated function taskDelete(int taskID) returns json|error {
        string resourcePath = string `/api/Task`;
        map<anydata> queryParam = {"TaskID": taskID};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        json response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Gets Task by Task ID
    #
    # + id - Task ID number 
    # + return - Success 
    remote isolated function taskGetbyid(int id) returns TaskDetails|error {
        string resourcePath = string `/api/Task/${getEncodedUri(id)}`;
        TaskDetails response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Task Statuses
    #
    # + return - Success 
    remote isolated function taskstatusGet() returns TaskStatusList|error {
        string resourcePath = string `/api/TaskStatus`;
        TaskStatusList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Task Types
    #
    # + return - Success 
    remote isolated function tasktypeGet() returns TaskTypeList|error {
        string resourcePath = string `/api/TaskType`;
        TaskTypeList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get List of Taxes configured in the Avaza account.
    #
    # + return - OK 
    remote isolated function taxGet() returns TaxList|error {
        string resourcePath = string `/api/Tax`;
        TaxList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets list of Timsheets
    #
    # + updatedAfter - Limit results to records updated after the specified date 
    # + entryDateFrom - Timesheet start entry date to filter 
    # + entryDateTo - Timesheet end entry date to filter 
    # + userID - The UserID of a timesheet user to filter timesheets for. Only api users with certain higher roles can see timesheets across multiple users. 
    # + userEmail - User email address 
    # + categoryName - Category name 
    # + projectID - Project Id 
    # + isBillable - Billable status 
    # + isInvoiced - Invoiced status 
    # + isTimerRunning - Timer running status 
    # + pageSize - Number of items per page (max 1000) 
    # + pageNumber - Page to display. Starts from 1. 
    # + sort - Optional sorting instruction. Currently possible values: "DateUpdated", "DateCreated", "DateUpdated desc", "DateCreated desc","EntryDate", "EntryDate desc", "StartTimeLocal","StartTimeLocal desc", "TimeSheetEntryID", "TimeSheetEntryID desc" 
    # + return - Success 
    remote isolated function timesheetGet(string? updatedAfter = (), string? entryDateFrom = (), string? entryDateTo = (), int? userID = (), string? userEmail = (), string? categoryName = (), int? projectID = (), boolean? isBillable = (), boolean? isInvoiced = (), boolean? isTimerRunning = (), int? pageSize = (), int? pageNumber = (), string? sort = ()) returns TimesheetList|error {
        string resourcePath = string `/api/Timesheet`;
        map<anydata> queryParam = {"UpdatedAfter": updatedAfter, "EntryDateFrom": entryDateFrom, "EntryDateTo": entryDateTo, "UserID": userID, "UserEmail": userEmail, "CategoryName": categoryName, "ProjectID": projectID, "isBillable": isBillable, "isInvoiced": isInvoiced, "isTimerRunning": isTimerRunning, "pageSize": pageSize, "pageNumber": pageNumber, "Sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        TimesheetList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update a Timesheet
    #
    # + payload - A record of type `UpdateTimesheetModel` which contains the necessary data to update timesheet 
    # + return - OK 
    remote isolated function timesheetPut(UpdateTimesheetModel payload) returns TimesheetDetails|error {
        string resourcePath = string `/api/Timesheet`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        TimesheetDetails response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Create a new Timesheet Entry
    #
    # + payload - A record of type `NewTimesheet` which contains the necessary data to create timesheet 
    # + return - OK 
    remote isolated function timesheetPost(NewTimesheet payload) returns TimesheetDetails|error {
        string resourcePath = string `/api/Timesheet`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        TimesheetDetails response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Gets a Timesheet Entry by Timesheet ID
    #
    # + id - Timesheet ID number 
    # + return - Success 
    remote isolated function timesheetGetbyid(int id) returns TimesheetDetails|error {
        string resourcePath = string `/api/Timesheet/${getEncodedUri(id)}`;
        TimesheetDetails response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete a Timesheet Entry
    #
    # + id - The id of the timesheet entry to be deleted 
    # + return - OK 
    remote isolated function timesheetDelete(int id) returns json|error {
        string resourcePath = string `/api/Timesheet/${getEncodedUri(id)}`;
        json response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Submit Timesheets for Approval.
    #
    # + sendNotifications - Send email alerts to timesheet approvers. Defaults to true 
    # + wholeWeekOf - A date (yyyy-MM-dd) that falls within  a Week to have all timesheets in that week submitted. Respects the First Day of Week setting in your account Timesheet Settings to determine the week range. 
    # + wholeDayOf - A date (yyyy-MM-dd) to submit all timesheets on this day 
    # + userID - The user to submit timesheets for. Defaults to current user. Only allowed to be different from the current user when the current user has rights to Impersonate other users. 
    # + return - OK 
    remote isolated function timesheetsubmissionPost(boolean? sendNotifications = (), string? wholeWeekOf = (), string? wholeDayOf = (), int? userID = ()) returns json|error {
        string resourcePath = string `/api/TimesheetSubmission`;
        map<anydata> queryParam = {"SendNotifications": sendNotifications, "WholeWeekOf": wholeWeekOf, "WholeDayOf": wholeDayOf, "UserID": userID};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        json response = check self.clientEp-> post(resourcePath, request);
        return response;
    }
    # Gets Basic Summary of Timesheet Statistics
    #
    # + modelGroupby - (Optional) Combine one, two or three levels of Grouping. Combine these possible grouping values: "Customer", "Project", "Category", "User", "Task", "Year", "Month", "Day", "Week". 
    # + modelEntrydatefrom - (Required) Filter for timesheets greater or equal to the specified date. e.g. 2019-01-25. You can optionally include a time component, otherwise it assumes 00:00 
    # + modelEntrydateto - (Required) Filter for timesheets with an entry date smaller or equal to the specified  date. e.g. 2019-01-25. You can optionally include a time component, otherwise it assumes 00:00 
    # + modelUserid - (Optional) Defaults to the current user. Provide one or more UserIDs of Users whose timesheets should be retrieved. If the current user doesn't have impersonation rights, then they will only see their own data. 
    # + modelProjectid - (Optional) Filter by Project 
    # + modelIsbillable - (Optional) Filter by the billable status of Timesheets. 
    # + modelIsinvoiced - (Optional) Filter for timesheets by whether they have been Invoiced or not. 
    # + return - OK 
    remote isolated function timesheetsummaryGet(string[]? modelGroupby = (), string? modelEntrydatefrom = (), string? modelEntrydateto = (), int[]? modelUserid = (), int? modelProjectid = (), boolean? modelIsbillable = (), boolean? modelIsinvoiced = ()) returns TimesheetSummaryResult|error {
        string resourcePath = string `/api/TimesheetSummary`;
        map<anydata> queryParam = {"model.groupBy": modelGroupby, "model.entryDateFrom": modelEntrydatefrom, "model.entryDateTo": modelEntrydateto, "model.userID": modelUserid, "model.projectID": modelProjectid, "model.isBillable": modelIsbillable, "model.isInvoiced": modelIsinvoiced};
        map<Encoding> queryParamEncoding = {"model.groupBy": {style: FORM, explode: true}, "model.userID": {style: FORM, explode: true}};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam, queryParamEncoding);
        TimesheetSummaryResult response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Gets the  Running Timer if there is one for a user.
    #
    # + userID - Optional - User ID number if impersonating a different user. Otherwise assumes the current user. Only users with certain security roles have permission to impersonate other users 
    # + return - Success 
    remote isolated function timesheettimerGetrunningtimer(int? userID = ()) returns json|error {
        string resourcePath = string `/api/TimesheetTimer`;
        map<anydata> queryParam = {"UserID": userID};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        json response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Starts a Timer running on an existing Timesheet Entry
    #
    # + id - id of timesheet entry that should be used as the basis for running a timer. If the existing timesheet is not on the current day, or you have start/end times enabled, then a new timesheet will be created for the timer. 
    # + userID - Optional - User ID number if impersonating a different user. Otherwise assumes the current user. Only users with certain security roles have permission to impersonate other users 
    # + return - Success 
    remote isolated function timesheettimerStarttimer(int id, int? userID = ()) returns json|error {
        string resourcePath = string `/api/TimesheetTimer/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"UserID": userID};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        http:Request request = new;
        //TODO: Update the request as needed;
        json response = check self.clientEp-> post(resourcePath, request);
        return response;
    }
    # Stop the timer running on an existing Timesheet Entry
    #
    # + id - The ID of the existing timesheet entry that needs its timer stopped 
    # + userID - Optional - User ID number if impersonating a different user. Otherwise assumes the current user. Only users with certain security roles have permission to impersonate other users 
    # + return - Success 
    remote isolated function timesheettimerStoptimer(int id, int? userID = ()) returns json|error {
        string resourcePath = string `/api/TimesheetTimer/${getEncodedUri(id)}`;
        map<anydata> queryParam = {"UserID": userID};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        json response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Get Collection of Users who have roles in the current Avaza account.
    #
    # + roles - Optional list of comma separated role codes to filter users by (e.g. "TimesheetUser,Admin") 
    # + tags - User role tags 
    # + currentUserOnly - Optional boolean (true/false) to filter to only show current authenticated user (always true for non Admin/InvoiceManager users) 
    # + companyIDFK - Optionally filter by Company ID 
    # + return - OK 
    remote isolated function userprofileGet(string? roles = (), string? tags = (), boolean? currentUserOnly = (), int? companyIDFK = ()) returns UserList|error {
        string resourcePath = string `/api/UserProfile`;
        map<anydata> queryParam = {"Roles": roles, "Tags": tags, "CurrentUserOnly": currentUserOnly, "CompanyIDFK": companyIDFK};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        UserList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get list of Webhook Subscriptions
    #
    # + return - OK 
    remote isolated function webhookGet() returns WebhookList|error {
        string resourcePath = string `/api/Webhook`;
        WebhookList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Subscribe to Webhook. On success, returns ID of webhook subscription.
    #
    # + payload - A record of type `CreateSubscription` which contains the necessary data to subscribe to webhook 
    # + return - Subscription created 
    remote isolated function webhookPost(CreateSubscription payload) returns SubscribeResult|error {
        string resourcePath = string `/api/Webhook`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        SubscribeResult response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Delete webhook subscription by URL
    #
    # + targetUrl - Target URL that should be used to delete subscriptions 
    # + return - Subscription Deleted OK 
    remote isolated function webhookDeletebyurl(string targetUrl) returns json|error {
        string resourcePath = string `/api/Webhook`;
        map<anydata> queryParam = {"target_url": targetUrl};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        json response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Get Webhook Subscription by SubscriptionID
    #
    # + id - Subscription Id 
    # + return - OK 
    remote isolated function webhookGetbyid(int id) returns WebhookList|error {
        string resourcePath = string `/api/Webhook/${getEncodedUri(id)}`;
        WebhookList response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Delete Webhook Subscription by ID
    #
    # + id - Subscription id to be deleted 
    # + return - Subscription deleted ok 
    remote isolated function webhookDelete(int id) returns json|error {
        string resourcePath = string `/api/Webhook/${getEncodedUri(id)}`;
        json response = check self.clientEp-> delete(resourcePath);
        return response;
    }
}
