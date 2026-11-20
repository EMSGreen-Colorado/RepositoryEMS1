// Send a business proposal to each new Contact
trigger ProposalEmail on Contact (before insert) {
  // Step 0: Create a master list to hold all the emails (multiple email messages) we'll send
    List<Messaging.SingleEmailMessage> manyEmailsSending = new List<Messaging.SingleEmailMessage>();
    for (Contact myContact : Trigger.new){
        if (myContact.Email != null && myContact.FirstName != null){
            // Step 1: Create one new Email message
            Messaging.SingleEmailMessage oneEmailSending = new Messaging.SingleEmailMessage();
            // Step 2: Set list of people who should get the email
            List<String> sendTo = new List<String>();
            sendTo.add(myContact.Email);
            oneEmailSending.setToAddresses(sendTo);
            // Step 3: Set who the email is sent from
            oneEmailSending.setReplyTo('ericmswanson@yahoo.com');
            oneEmailSending.setSenderDisplayName('Eric Sender');
            // (Optional) Set list of people who should be CC'ed            
            List<String> ccTo = new List<String>();
            ccTo.add('ericmswanson@yahoo.com');
            oneEmailSending.setCcAddresses(ccTo);
            // Step 4. Set email contents - you can use variables!
            oneEmailSending.setSubject('This is the email subject');
            String emailBody = 'Dear ' + myContact.FirstName + ', ';
            emailBody += ' This is some text';
            emailBody += 'and this is more text';
            oneEmailSending.setHtmlBody(emailBody);
            // Step 5. Add your one email to the master list
            manyEmailsSending.add(oneEmailSending);
        }
    }
    // Step 6: Send all emails in the master list            
    Messaging.sendEmail(manyEmailsSending);
}