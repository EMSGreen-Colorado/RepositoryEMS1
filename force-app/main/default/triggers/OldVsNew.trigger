trigger OldVsNew on Opportunity (before update) {
    for (Opportunity opp : Trigger.new){
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
        Boolean oldOppIsWon = oldOpp.StageName == 'Closed Won';
        Boolean newOppIsWon = opp.StageName == 'Closed Won';
        if (!oldOppIsWon && newOppIsWon) {
            opp.Description = 'An APEX Win!';
        }
    }
}