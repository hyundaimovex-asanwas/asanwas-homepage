/*******************************************************************************
 * 1.클래스   명 : CalendarUtil.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 이태선
 * 7.작 성 일 자 : 2004-03-30
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-03-24      ;
 * @author 이태선
 * @version 1.0 2004-03-30
 * *****************************************************************************
 */

package sales.org.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class CalendarUtil {

	/**
	 * 현재 시간을 기본으로 Calendar에 인스턴스를 생성한다.
	 */
	private String year;

	private String month;

	private String day;

	private String hour;

	private String minute;

	private String second;

	private String milsec;

	private String tmp;

	Calendar nowdate;

	public CalendarUtil() {
		nowdate = Calendar.getInstance();
		setNow();
	}

	/**
	 * 연도, 월, 날짜를 입력 받아 시간을 설정한다.
	 */

	public void setNow() {
		year = getYear();
		month = getMonth();
		day = getDay();
		hour = getHour();
		minute = getMinute();
		second = getSecond();
		milsec = getMilliSecond();
		tmp = year + month + day;
	}

	/**
	 *  날짜부분만 남기고 시간부분을 0으로 설정한다.
	 */
	public void clearTime() {
		Calendar cal2 = (Calendar)nowdate.clone();
		nowdate.clear();
		nowdate.set(cal2.get(Calendar.YEAR), cal2.get(Calendar.MONTH), cal2.get(Calendar.DAY_OF_MONTH));
		setNow();
	}
	
	/**
	 * 연도, 월, 날짜를 입력 받아 시간을 설정한다.
	 */
	public void setTime(int year, int month, int day) {
		nowdate.clear();
		nowdate.set(year, month - 1, day);
		setNow();
	}

	/**
	 * 연도, 월을 입력 받아 시간을 설정한다.
	 */
	public void setTime(int year, int month) {
		nowdate.clear();
		nowdate.set(year, month - 1, 1);
		setNow();
	}

	/**
	 * String 형식의 yyyymmdd 날짜 입력.
	 */
	public void setTime(String yyyymmdd) {
		if (yyyymmdd.length() == 8) {
			nowdate.set(Integer.parseInt(yyyymmdd.substring(0, 4)), Integer.parseInt(yyyymmdd.substring(4, 6)) - 1, Integer.parseInt(yyyymmdd.substring(6, 8)));
			setNow();
		}else{
			throw new NumberFormatException();
		}
	}

	/**
	 * String 형식의 날짜를 입력한 패턴으로 해석해 날짜를 입력하며,
	 * 해석할 수 없는 경우 날짜를 입력하지 않는다. 
	 * @param strDate 날짜 문자열
	 * @param strPattern SimpleDateFormat에 사용되는 날짜 패턴 문자열(예: yyyy-MM-dd HH:mm:ss.SSS)
	 */
	public void setTime(String strDate, String strPattern) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat(strPattern);
			
			setTime(sdf.parse(strDate));
		}
		catch(ParseException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Date형식으로 날짜 입력.
	 */
	public void setTime(Date date) {
		nowdate.setTime(date);
		setNow();
	}


	/**
	 * Long형식으로 날짜 입력.
	 */
	public void setDate(long val) {
		nowdate.setTime(new Date(val));
	}

	/**
	 * Timestamp형식으로 날짜 입력.
	 */
	public void setDate(Timestamp ts) {
		setDate(ts.getTime());
	}

	/**
	 * 지정된 필드에 정해진 수치만큼 가감 연산을 수행한다.
	 */
	public void add(String field, int val) {
		tmp = field.toLowerCase();
		if (tmp.equals("year") || tmp.equals("years")) {
			nowdate.add(Calendar.YEAR, val);
		} else if (tmp.equals("month") || tmp.equals("months")) {
			nowdate.add(Calendar.MONTH, val);
		} else if (tmp.equals("date") || tmp.equals("day") || tmp.equals("dates")|| tmp.equals("daies")) {
			nowdate.add(Calendar.DAY_OF_MONTH, val);
		} else if (tmp.equals("hour") || tmp.equals("hours")) {
			nowdate.add(Calendar.HOUR_OF_DAY, val);
		} else if (tmp.equals("minute") || tmp.equals("minutes")) {
			nowdate.add(Calendar.MINUTE, val);
		} else if (tmp.equals("second") || tmp.equals("seconds")) {
			nowdate.add(Calendar.SECOND, val);
		}
	}

	/**
	 * Calendae로 시간을 리턴한다.
	 */
	public Calendar getCalendar() {
		return nowdate;
	}
	
	/**
	 * Timestamp 로 시간을 리턴한다.
	 */
	public Timestamp getTimestamp() {
		return new Timestamp(nowdate.getTime().getTime());
	}

	/**
	 * Long형식의 날짜 리턴.
	 */
	public long getLong() {
		return nowdate.getTime().getTime();
	}

	/**
	 * YYYYMMDD 형식의 날짜 리턴.
	 */
	public String getString() {
		year = getYear();
		month = getMonth();
		day = getDay();
		hour = getHour();
		String ret = year + month + day;
		return ret;
	}
	
	/**
	 * 입력된 패턴에 따라 설정된 시간을 리턴한다. 패턴 0 : 연도 + 월 + 일 + 시간 + 분 + 초 + 밀리초; 1 : 연도 2 : 연도 + 월 3 : 연도 + 월 + 일 4 : 연도 + 월 + 일 + 시간 5 : 연도 + 월 + 일 + 시간 + 분 6 : 연도 + 월 + 일 + 시간 + 분 + 초; 7 : 연도 + 월 + 일 + 시간 + 분 + 초 + 밀리초;
	 */
	public String getString(int pattern) {
		year = getYear();
		month = getMonth();
		day = getDay();
		hour = getHour();
		minute = getMinute();
		second = getSecond();
		milsec = getMilliSecond();
		String ret = year + month + day;
		switch (pattern) {
		case 0:
			ret = year + month + day + hour + minute + second + milsec;
			break;
		case 1:
			ret = year;
			break;
		case 2:
			ret = year + month;
			break;
		case 3:
			ret = year + month + day;
			break;
		case 4:
			ret = year + month + day + hour;
			break;
		case 5:
			ret = year + month + day + hour + minute;
			break;
		case 6:
			ret = year + month + day + hour + minute + second;
			break;
		case 7:
			ret = year + month + day + hour + minute + second + milsec;
			break;
		default:
			ret = year + month + day + hour + minute + second + milsec;
			break;
		}
		return ret;
	}

	/**
	 * 입력된 패턴에 따라 설정된 시간을 리턴한다. 패턴 0 : 연도 + 월 + 일 + 시간 + 분 + 초 + 밀리초; 1 : 연도 2 : 연도 + 월 3 : 연도 + 월 + 일 4 : 연도 + 월 + 일 + 시간 5 : 연도 + 월 + 일 + 시간 + 분 6 : 연도 + 월 + 일 + 시간 + 분 + 초; 7 : 연도 + 월 + 일 + 시간 + 분 + 초 + 밀리초;
	 */
	public String getString(int pattern,String seprater) {
		year = getYear();
		month = getMonth();
		day = getDay();
		hour = getHour();
		minute = getMinute();
		second = getSecond();
		milsec = getMilliSecond();
		String ret = year + month + day;
		switch (pattern) {
		case 0:
			ret = year + month + day + hour + minute + second + milsec;
			break;
		case 1:
			ret = year;
			break;
		case 2:
			ret = year + seprater + month;
			break;
		case 3:
			ret = year + seprater + month + seprater + day;
			break;
		case 4:
			ret = year + seprater + month + seprater + day + seprater + hour;
			break;
		case 5:
			ret = year + seprater + month + seprater + day + seprater + hour + seprater + minute;
			break;
		case 6:
			ret = year + seprater + month + seprater + day + seprater + hour + seprater + minute + seprater + second;
			break;
		case 7:
			ret = year + seprater + month + seprater + day + seprater + hour + seprater + minute + seprater + second + seprater + milsec;
			break;
		default:
			ret = year + seprater + month + seprater + day + seprater + hour + seprater + minute + seprater + second + seprater + milsec;
			break;
		}
		return ret;
	}

	/**
	 * 입력된 패턴 문자열에 따라 설정된 시간을 문자열로 리턴한다.
	 * @param SimpleDateFormat에 사용되는 날짜 패턴 문자열(예: yyyy-MM-dd HH:mm:ss.SSS) 
	 * @return
	 */
	public String getString(String strPattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(strPattern);
		
		return sdf.format(getTimestamp());
	}
	
	/**
	 * 입력된 패턴에 따라 설정된 시간을 리턴한다. 패턴 0 : 연도 + 월 + 일 + 시간 + 분 + 초 + 밀리초; 1 : 연도 2 : 연도 + 월 3 : 연도 + 월 + 일 4 : 연도 + 월 + 일 + 시간 5 : 연도 + 월 + 일 + 시간 + 분 6 : 연도 + 월 + 일 + 시간 + 분 + 초; 7 : 연도 + 월 + 일 + 시간 + 분 + 초 + 밀리초;
	 */
	public String getOraString(int pattern) {
		year = getYear();
		month = getMonth();
		day = getDay();
		hour = getHour();
		minute = getMinute();
		second = getSecond();
		milsec = getMilliSecond();
		String ret = year + month + day;
		switch (pattern) {
		case 0:
			ret = year + month + day + hour + minute + second + milsec;
			break;
		case 1:
			ret = year;
			break;
		case 2:
			ret = year + "-" + month;
			break;
		case 3:
			ret = year + "-" + month + "-" + day;
			break;
		case 4:
			ret = year + "-" + month + "-" + day + " " + hour;
			break;
		case 5:
			ret = year + "-" + month + "-" + day + " " + hour + ":" + minute;
			break;
		case 6:
			ret = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
			break;
		case 7:
			ret = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second + "." + milsec;
			break;
		default:
			ret = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second + "." + milsec;
			break;
		}
		return ret;
	}

	/**
	 * 입력된 패턴에 따라 설정된 시간을 리턴한다. 패턴 0 : 연도 + 월 + 일 + 시간 + 분 + 초 + 밀리초; 1 : 연도 2 : 연도 + 월 3 : 연도 + 월 + 일 4 : 연도 + 월 + 일 + 시간 5 : 연도 + 월 + 일 + 시간 + 분 6 : 연도 + 월 + 일 + 시간 + 분 + 초; 7 : 연도 + 월 + 일 + 시간 + 분 + 초 + 밀리초;
	 */
	public String getKorString(int pattern) {
		year = getYear();
		month = getMonth();
		day = getDay();
		hour = getHour();
		minute = getMinute();
		second = getSecond();
		milsec = getMilliSecond();
		String ret = year + month + day;
		switch (pattern) {
		case 0:
			ret = year + month + day + hour + minute + second + milsec;
			break;
		case 1:
			ret = year + "년";
			break;
		case 2:
			ret = year + "년 " + month + "월";
			break;
		case 3:
			ret = year + "년 " + month + "월 " + day + "일";
			break;
		case 4:
			ret = year + "년 " + month + "월 " + day + "일 " + hour + "시";
			break;
		case 5:
			ret = year + "년 " + month + "월 " + day + "일 " + hour + "시 " + minute + "분";
			break;
		case 6:
			ret = year + "년 " + month + "월 " + day + "일 " + hour + "시 " + minute + "분 " + second + "초";
			break;
		case 7:
			ret = year + "년 " + month + "월 " + day + "일 " + hour + "시 " + minute + "분 " + second + "." + milsec + "초";
			break;
		default:
			ret = year + "년 " + month + "월 " + day + "일 " + hour + "시 " + minute + "분 " + second + "." + milsec + "초";
			break;
		}
		return ret;
	}

	/**
	 * 년도 리턴.
	 */
	public String getYear() {
		tmp = Integer.toString(nowdate.get(Calendar.YEAR));
		tmp = (tmp.length() != 4) ? "0000" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 4);
		return tmp;
	}

	/**
	 * 월 리턴.
	 */
	public String getMonth() {
		tmp = Integer.toString(nowdate.get(Calendar.MONTH) + 1);
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * 일 리턴.
	 */
	public String getDay() {
		tmp = Integer.toString(nowdate.get(Calendar.DAY_OF_MONTH));
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * 시 리턴.
	 */
	public String getHour() {
		tmp = Integer.toString(nowdate.get(Calendar.HOUR_OF_DAY));
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * 분 리턴.
	 */
	public String getMinute() {
		tmp = Integer.toString(nowdate.get(Calendar.MINUTE));
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * 초 리턴.
	 */
	public String getSecond() {
		tmp = Integer.toString(nowdate.get(Calendar.SECOND));
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * 밀리 초 리턴.
	 */
	public String getMilliSecond() {
		tmp = Integer.toString(nowdate.get(Calendar.MILLISECOND));
		tmp = (tmp.length() != 3) ? "000" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 3);
		return tmp;
	}

	/**
	 * 달의 마지막날 리턴.
	 */
	public int getMaxDayOfMonth() {
		return nowdate.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 연도의 마지막달 리턴.
	 */
	public int getMaxMonthOfYear() {
		return nowdate.getActualMaximum(Calendar.MONTH) + 1;
	}

	/**
	 * 달에서 첫번째 날을 주일을 리턴한다.
	 */
	public int getFisrtDayOfMonth() {
		int val1 = Integer.parseInt(getDay());
		int val2 = 0;
		setTime(Integer.parseInt(getYear()), Integer.parseInt(month));
		val2 = nowdate.get(Calendar.DAY_OF_WEEK);
		setTime(Integer.parseInt(getYear()), Integer.parseInt(month), val1);
		return val2;
	}
	
	/**
	 * 입력받은 날짜가 기간내에 있는지 여부 리턴.
	 */
	public boolean isInDate(Date inDate,int period){
		if(inDate != null){
			int  tmpPeriod = 0;
			long tmpStart = 0;
			long tmpEnd = 0;
	
			if(period < 0){
				tmpPeriod = -1 * period;
			}else{
				tmpPeriod = period;
			}
	
			add("date",-1*tmpPeriod);
			tmpStart = getLong();
			add("date",tmpPeriod);
			
			add("date",tmpPeriod);
			tmpEnd = getLong();
			add("date",-1*tmpPeriod);
	
			if(tmpStart<= inDate.getTime() && tmpEnd >= inDate.getTime()){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
	}
}