/**
    An email processor class which sends email to all the contacts.
 */
public class WelcomeEmailProcessor {
    
    public WelcomeEmailProcessor() {
    }

    /**
        Method to send welcome emails to contacts.
     */
    public static void send() {
        List<Messaging.SingleEmailMessage> lstMails = new List<Messaging.SingleEmailMessage>();
        List<Contact> lstContacts = [SELECT Name, Email FROM Contact];
        for(Contact con : lstContacts) {
            if(String.isNotBlank(con.Email)) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new List<String>{con.Email});
                mail.setHtmlBody(getEmailBody(con.Name));
                mail.setSenderDisplayName('DreamHouse Realty');
                mail.setSubject('Explore houses at home');
                lstMails.add(mail);
            }
        }
        if(!lstMails.isEmpty()) {
            Messaging.sendEmail(lstMails);
        }
    }

    /**
        Helper method to create email body.
    */
    private static String getEmailBody(String name) {
        String body = '<p> Hi ' + name + ',</p>'
            + '<p>Hope you stay safe and healthy during the COVID-19.</p>'
            + '<p>Still looking for houses? We are launching a new site http://www.dreamhouseapp.io/ to help you<br/>explore the houses at home. If you have any questions, feel free to contact the broker: Victor Ochoa: 617-244-3672</p>'
            + '<p>Sincerely,<br/>DreamHouse Realty<br/>' + Date.today().format() + '</p>';
        return body;
    }

}
