package common;
//package sales.common;

import java.util.*;

public class sdhTest {
	

        public static void main(String[] args) {              

        	Calendar cal = Calendar.getInstance();

        	String param = "20070810";
        	cal.set(Integer.parseInt(param.substring(0,4)),Integer.parseInt(param.substring(4,6)) - 1,Integer.parseInt(param.substring(6,8)));
            
        	String year = String.valueOf(cal.get(Calendar.YEAR));
            String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
            String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
            String weekDay = String.valueOf(cal.get(Calendar.DAY_OF_WEEK));	//sunday=1, saturday=7
        	
            
            try {
                  System.out.println(year);
                  System.out.println(month);
                  System.out.println(day);
                  System.out.println(weekDay);
                  if (weekDay.equals("6") || weekDay.equals("7") ){
                	  System.out.println("Y");
                  }else{
                	  System.out.println("N");
                  };

            }catch(Exception e) {

                  System.out.println("JCE Installation Failure!");

            }
        }

} 
