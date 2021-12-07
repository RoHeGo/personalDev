trigger contactTrigger on Contact (before update) {
    for (Contact contact : Trigger.new) {
        WeatherAPI.CurrentWeather(contact.id);
    }
}