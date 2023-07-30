trigger ContactActiveTrigger on Contact (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            ContactActiveTriggerHandler.activeContacts(Trigger.new, Trigger.old, Trigger.oldMap);
        }
        else if (Trigger.isDelete) {
            ContactActiveTriggerHandler.activeContacts(null, Trigger.old, Trigger.oldMap);
        }
        else if (Trigger.isUndelete) {
            ContactActiveTriggerHandler.activeContacts(Trigger.new, null, null);
        }
    }
}