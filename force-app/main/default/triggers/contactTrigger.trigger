trigger contactTrigger on Contact (before update) {
    for (Contact contact : Trigger.new) {
        String contactId = contact.id;
        WeatherAPI.CurrentWeather(contactId);
    }
}