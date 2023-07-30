trigger AccountOppTrigger on Account (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            AccountOppHandler.accWithoutOpp(Trigger.new);
        }
    }
}