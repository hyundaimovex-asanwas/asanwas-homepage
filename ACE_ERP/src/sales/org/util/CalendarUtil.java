/*******************************************************************************
 * 1.Ŭ����   �� : CalendarUtil.java
 * 2.Ŭ���� ���� :
 * 3.���� ���̺� :
 * 4.���� Ŭ���� :
 * 5.���� ������ :
 * 6.��   ��  �� : ���¼�
 * 7.�� �� �� �� : 2004-03-30
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2004-03-24      ;
 * @author ���¼�
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
	 * ���� �ð��� �⺻���� Calendar�� �ν��Ͻ��� �����Ѵ�.
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
	 * ����, ��, ��¥�� �Է� �޾� �ð��� �����Ѵ�.
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
	 *  ��¥�κи� ����� �ð��κ��� 0���� �����Ѵ�.
	 */
	public void clearTime() {
		Calendar cal2 = (Calendar)nowdate.clone();
		nowdate.clear();
		nowdate.set(cal2.get(Calendar.YEAR), cal2.get(Calendar.MONTH), cal2.get(Calendar.DAY_OF_MONTH));
		setNow();
	}
	
	/**
	 * ����, ��, ��¥�� �Է� �޾� �ð��� �����Ѵ�.
	 */
	public void setTime(int year, int month, int day) {
		nowdate.clear();
		nowdate.set(year, month - 1, day);
		setNow();
	}

	/**
	 * ����, ���� �Է� �޾� �ð��� �����Ѵ�.
	 */
	public void setTime(int year, int month) {
		nowdate.clear();
		nowdate.set(year, month - 1, 1);
		setNow();
	}

	/**
	 * String ������ yyyymmdd ��¥ �Է�.
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
	 * String ������ ��¥�� �Է��� �������� �ؼ��� ��¥�� �Է��ϸ�,
	 * �ؼ��� �� ���� ��� ��¥�� �Է����� �ʴ´�. 
	 * @param strDate ��¥ ���ڿ�
	 * @param strPattern SimpleDateFormat�� ���Ǵ� ��¥ ���� ���ڿ�(��: yyyy-MM-dd HH:mm:ss.SSS)
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
	 * Date�������� ��¥ �Է�.
	 */
	public void setTime(Date date) {
		nowdate.setTime(date);
		setNow();
	}


	/**
	 * Long�������� ��¥ �Է�.
	 */
	public void setDate(long val) {
		nowdate.setTime(new Date(val));
	}

	/**
	 * Timestamp�������� ��¥ �Է�.
	 */
	public void setDate(Timestamp ts) {
		setDate(ts.getTime());
	}

	/**
	 * ������ �ʵ忡 ������ ��ġ��ŭ ���� ������ �����Ѵ�.
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
	 * Calendae�� �ð��� �����Ѵ�.
	 */
	public Calendar getCalendar() {
		return nowdate;
	}
	
	/**
	 * Timestamp �� �ð��� �����Ѵ�.
	 */
	public Timestamp getTimestamp() {
		return new Timestamp(nowdate.getTime().getTime());
	}

	/**
	 * Long������ ��¥ ����.
	 */
	public long getLong() {
		return nowdate.getTime().getTime();
	}

	/**
	 * YYYYMMDD ������ ��¥ ����.
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
	 * �Էµ� ���Ͽ� ���� ������ �ð��� �����Ѵ�. ���� 0 : ���� + �� + �� + �ð� + �� + �� + �и���; 1 : ���� 2 : ���� + �� 3 : ���� + �� + �� 4 : ���� + �� + �� + �ð� 5 : ���� + �� + �� + �ð� + �� 6 : ���� + �� + �� + �ð� + �� + ��; 7 : ���� + �� + �� + �ð� + �� + �� + �и���;
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
	 * �Էµ� ���Ͽ� ���� ������ �ð��� �����Ѵ�. ���� 0 : ���� + �� + �� + �ð� + �� + �� + �и���; 1 : ���� 2 : ���� + �� 3 : ���� + �� + �� 4 : ���� + �� + �� + �ð� 5 : ���� + �� + �� + �ð� + �� 6 : ���� + �� + �� + �ð� + �� + ��; 7 : ���� + �� + �� + �ð� + �� + �� + �и���;
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
	 * �Էµ� ���� ���ڿ��� ���� ������ �ð��� ���ڿ��� �����Ѵ�.
	 * @param SimpleDateFormat�� ���Ǵ� ��¥ ���� ���ڿ�(��: yyyy-MM-dd HH:mm:ss.SSS) 
	 * @return
	 */
	public String getString(String strPattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(strPattern);
		
		return sdf.format(getTimestamp());
	}
	
	/**
	 * �Էµ� ���Ͽ� ���� ������ �ð��� �����Ѵ�. ���� 0 : ���� + �� + �� + �ð� + �� + �� + �и���; 1 : ���� 2 : ���� + �� 3 : ���� + �� + �� 4 : ���� + �� + �� + �ð� 5 : ���� + �� + �� + �ð� + �� 6 : ���� + �� + �� + �ð� + �� + ��; 7 : ���� + �� + �� + �ð� + �� + �� + �и���;
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
	 * �Էµ� ���Ͽ� ���� ������ �ð��� �����Ѵ�. ���� 0 : ���� + �� + �� + �ð� + �� + �� + �и���; 1 : ���� 2 : ���� + �� 3 : ���� + �� + �� 4 : ���� + �� + �� + �ð� 5 : ���� + �� + �� + �ð� + �� 6 : ���� + �� + �� + �ð� + �� + ��; 7 : ���� + �� + �� + �ð� + �� + �� + �и���;
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
			ret = year + "��";
			break;
		case 2:
			ret = year + "�� " + month + "��";
			break;
		case 3:
			ret = year + "�� " + month + "�� " + day + "��";
			break;
		case 4:
			ret = year + "�� " + month + "�� " + day + "�� " + hour + "��";
			break;
		case 5:
			ret = year + "�� " + month + "�� " + day + "�� " + hour + "�� " + minute + "��";
			break;
		case 6:
			ret = year + "�� " + month + "�� " + day + "�� " + hour + "�� " + minute + "�� " + second + "��";
			break;
		case 7:
			ret = year + "�� " + month + "�� " + day + "�� " + hour + "�� " + minute + "�� " + second + "." + milsec + "��";
			break;
		default:
			ret = year + "�� " + month + "�� " + day + "�� " + hour + "�� " + minute + "�� " + second + "." + milsec + "��";
			break;
		}
		return ret;
	}

	/**
	 * �⵵ ����.
	 */
	public String getYear() {
		tmp = Integer.toString(nowdate.get(Calendar.YEAR));
		tmp = (tmp.length() != 4) ? "0000" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 4);
		return tmp;
	}

	/**
	 * �� ����.
	 */
	public String getMonth() {
		tmp = Integer.toString(nowdate.get(Calendar.MONTH) + 1);
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * �� ����.
	 */
	public String getDay() {
		tmp = Integer.toString(nowdate.get(Calendar.DAY_OF_MONTH));
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * �� ����.
	 */
	public String getHour() {
		tmp = Integer.toString(nowdate.get(Calendar.HOUR_OF_DAY));
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * �� ����.
	 */
	public String getMinute() {
		tmp = Integer.toString(nowdate.get(Calendar.MINUTE));
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * �� ����.
	 */
	public String getSecond() {
		tmp = Integer.toString(nowdate.get(Calendar.SECOND));
		tmp = (tmp.length() != 2) ? "00" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 2);
		return tmp;
	}

	/**
	 * �и� �� ����.
	 */
	public String getMilliSecond() {
		tmp = Integer.toString(nowdate.get(Calendar.MILLISECOND));
		tmp = (tmp.length() != 3) ? "000" + tmp : tmp;
		tmp = tmp.substring(tmp.length() - 3);
		return tmp;
	}

	/**
	 * ���� �������� ����.
	 */
	public int getMaxDayOfMonth() {
		return nowdate.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	/**
	 * ������ �������� ����.
	 */
	public int getMaxMonthOfYear() {
		return nowdate.getActualMaximum(Calendar.MONTH) + 1;
	}

	/**
	 * �޿��� ù��° ���� ������ �����Ѵ�.
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
	 * �Է¹��� ��¥�� �Ⱓ���� �ִ��� ���� ����.
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