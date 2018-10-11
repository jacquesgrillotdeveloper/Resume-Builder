/* This Class will update ALL record types to the proper type based on the Account's data
To execute run the below script through Execute Anonymous in the Dev Console:

UpdateAccountRTs batchAccounts = new UpdateAccountRTs(); 
Id batchId = Database.executeBatch(batchAccounts);

*/
public class UpdateAccountRTs implements Database.Batchable<sObject>, Database.Stateful {
    //track number of records processed
    public Integer recordsProcessed = 0;
    
    //locator start method to query ALL Account records
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
            'SELECT Id, RecordTypeId, Name, Industry FROM Account' 
        );
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        //process each batch of records
        // query the record types to change to 
        Id RecordTypeIdEdu = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Education Organization').getRecordTypeId();
        Id RecordTypeIdPro = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Professional Organization').getRecordTypeId();
        // Declare and instantiate a new list to story updated experience records
        List<Account> accounts = new List<Account>();
        for (Account account : scope){
            // Records with "Education" for Industry field populated are Educational Organizations. Increment county by 1 for records processed
            if(account.Industry == 'Education'){
                account.RecordTypeId = RecordTypeIdEdu;
                accounts.add(account);
                recordsProcessed = recordsProcessed +1;
            }
            else{
                account.RecordTypeId = RecordTypeIdPro;
                accounts.add(account);
                recordsProcessed = recordsProcessed +1;
            }
        }
        // Update all records processed.
        update accounts;
    }
    public void finish(Database.BatchableContext bc){
        //Return number of records processed to debug log.
        System.debug(recordsProcessed + ' Achievement records processed.');
    }
}