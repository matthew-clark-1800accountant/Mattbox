global class ArizonaTimeOffset{
    
    webservice static Integer offset(){
        
        //get User time zone and find offset to Phoenix
        //does not account for DST
        TimeZone tz = UserInfo.getTimeZone();
        Integer offset = tz.getOffset(datetime.now());
        System.debug('offset' + offset);
        //return((25200000+offset)/-(3600000))-1; //daylight saving ends
        return ((25200000+offset)/-3600000); //daylight saving time
    }
    
    
}