public with sharing class WeatherAPI {
    @future (callout=true)
    public void CurrentWeather(String contact) {
        List<Contact> updatedContacts = new List<Contact>();
        List<Contact> con = [select id, MailingPostalCode, Department from Contact where id =:contact];
            String zip = con.MailingPostalCode;
            String apiKey = 'f824517a88ee092aaea1fb9c3a3d0a19';
            String requestEndPoint = 'https://api.openweathermap.org/data/2.5/weather?q=';
            requestEndPoint += zip;
            requestEndPoint += '&units=imperial' + '&appid=' + apiKey;

            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(requestEndPoint);
            request.setMethod('GET');
            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                Map<String, Object> results =(Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                System.debug(results);
                String mainResults = String.valueOf(results.get('main'));
                System.debug(mainResults);
                String temp = String.valueOf(mainResults.get('temp'));
                System.debug(temp);
                con.Department = temp;
                updatedContacts.add(con);
            }

            else {
                System.debug('Oops! I guess there isn&#39;t any weather here');
                con.Department = 'mainResults';
                updatedContacts.add(c);
            }
        update updatedContacts;
        }
}