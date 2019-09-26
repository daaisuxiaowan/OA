package utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeUtil {
	public static String dateformat(Date date){
		 DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(date);
	}
	
	public static String dateformatNumber(Date date){
		 DateFormat df = new SimpleDateFormat("yyMMddHHmmss");
		return df.format(date);
	}
}
