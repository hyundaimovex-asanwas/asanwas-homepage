
package Ehr.common.util;

import java.nio.ByteBuffer;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.StringTokenizer;
import java.util.Vector;

/**
 * <pre>
 * 파일명   : JSPUtil.java
 * 파일설명 : JSP 페이지와 관련된 여러가지 메소드들을 제공하는 유틸리티 클래스
 * 수정이력 :
 * </pre>
 */
public class JSPUtil {

	public JSPUtil(){
	  super();
	}

	/**
	   * <pre>
	   * 기능 : 웹에서 한글은 꼭 이함수를 사용해야 함(한글이 깨지는현상을 막아줌)
	   * 작성 : 2004/07/19 [개발팀/아남정보통신(주)]
	   * </pre>
	   * @param  Object NULL이 아닌 문자열로 변경할 Object
	   * @return String - NULL이 아닌 문자열
	   */
	public static synchronized String toKor(String english) {

		String korean = "";

		if (english==null || english.equalsIgnoreCase(""))
			return korean ;
		else if (english.equalsIgnoreCase("''"))
			return english ;

		try {korean = new String(new String(english.getBytes("8859_1"), "KSC5601"));}
		catch (Exception e) {korean = new String(english);}
		return korean;

		}


  /**
   * <pre>
   * 기능 : NULL인 경우 빈 문자열 Return
   * 작성 : 2004/07/19 [개발팀/아남정보통신(주)]
   * </pre>
   * @param  Object NULL이 아닌 문자열로 변경할 Object
   * @return String - NULL이 아닌 문자열
   */
  public static String getNonNullString(Object argObject) {
    if (argObject == null) {
      return "";
    } else {
      return argObject.toString();
    }
  }




  /**
   * <pre>
   * 기능 : 문자열에서 글자사이에 특정 문자열을 특정 수만큼 채워넣기
   * 작성 : 2004/07/19 [개발팀/아남정보통신(주)]
   *         사용예) getFilledString("ERP전산팀", "..", 2);
   *                ==> "E....R....P....전....산....팀"
   * </pre>
   * @param  String 문자열
   * @param  String 채워넣을 문자열
   * @param  int    채워넣을 수
   * @return String - 글자 사이에 특정 문자열이 채워진 문자열
   */

   public static String n2s(String sz)
   {
	if(sz == null || sz.equals(""))
		   return "";
	   else
		   return sz;

   }

  public static String nchkno(String sz)
   {
	   if(sz == null || sz.equals(""))
		   return "0";
	   else
		   return sz;
   }

  public static String a2k(String str) {
			String rtn = null;
			try {
				rtn = (str==null)?"":new String(str.getBytes("8859_1"),"euc-kr");
			} catch (java.io.UnsupportedEncodingException e) {}
			return rtn;
	}

  public static String getFilledString(String argSourceStr, String argFillStr, int argFillCnt) {
    if (argSourceStr == null) {
      return "";
    }

    String filledStr = "";

    for (int inx = 0; inx < argSourceStr.length(); inx++) {
      filledStr += argSourceStr.substring(inx, inx + 1);

      if (inx != argSourceStr.length() - 1) {
        for (int inx1 = 0; inx1 < argFillCnt; inx1++) {
          filledStr += argFillStr;
        }
      }
    }

    return filledStr;
  }

  /**
   * <pre>
   * 기능 : 문자열을 특정 Byte(글자수)내에 같은 간격으로 공백 채워넣기
   * 작성 : 2004/07/19 [개발팀/아남정보통신(주)]
   *        사용예) getSameWidthString("ERP전산팀", 20, true);
   *                ==> "E&nbsp;&nbsp;R&nbsp;&nbsp;P&nbsp;&nbsp;전&nbsp;&nbsp;산&nbsp;&nbsp;팀"
   * </pre>
   * @param  String  문자열
   * @param  int     전체 글자수
   * @param  boolean 채울 공백을 "&nbsp;"로 대체여부
   * @return String - 같은 간격으로 공백이 채워진 문자열
   */
  public static String getSameWidthString(String argSourceStr, int argByte, boolean argIsNBSP) {
    if (argSourceStr == null) {
      return "";
    }

    String sameWidthStr = "";
    String fillStr      = " ";
    int    sourceLength = argSourceStr.getBytes().length;
    int    filledCnt    = argByte - sourceLength;

    if (filledCnt <= 0) {
      return argSourceStr;
    }

    filledCnt = filledCnt / (argSourceStr.length() - 1);
    if (argIsNBSP) {
      fillStr = "&nbsp;";
    }

    for (int inx = 0; inx < argSourceStr.length(); inx++) {
      sameWidthStr += argSourceStr.substring(inx, inx + 1);

      if (inx != argSourceStr.length() - 1) {
        for (int inx1 = 0; inx1 < filledCnt; inx1++) {
          sameWidthStr += fillStr;
        }
      }
    }

    return sameWidthStr;
  }

  /**
   * <pre>
   * 기능 : 문자열을 특정 Byte(글자수) 만큼 체크하여 뒤에 "..." 붙이기
   * 작성 : 2004/07/19 [개발팀/아남정보통신(주)]
   *         사용예) getCheckLengthString("ERP전산팀에서 만들었습니다.", 20);
   *                ==> "ERP전산팀에서 만..."
   * </pre>
   * @param  String  문자열
   * @param  int     전체 글자수
   * @return String - 길이 체크된 문자열
   */
  public static String getCheckLengthString(String argSourceStr, int argByte) {
    if (argSourceStr == null) {
      return "";
    }

    String checkLengthStr = "";
    String appendStr      = "...";
    int    checkByte      = argByte;

    if (argSourceStr.getBytes().length <= argByte) {
      return argSourceStr;
    }

    checkByte -= appendStr.getBytes().length;

    for (int inx = 0; inx < argSourceStr.length(); inx++) {
      String tempStr = argSourceStr.substring(inx, inx + 1);

      checkByte -= tempStr.getBytes().length;
      if (checkByte < 0) {
        break;
      }

      checkLengthStr += tempStr;
    }
    checkLengthStr += appendStr;

    return checkLengthStr;
  }

  /**
   * <pre>
   * 기능 : 문자열을 특정 Byte(글자수) 만큼 체크하여 뒤에 "<br>" 붙이기
   * 작성 : 2004/07/19 [개발팀/아남정보통신(주)]
   *          사용예) getCheckWidthString("ERP전산팀에서 만들었습니다.", 20);
   *                ==> "ERP전산팀에서 만들었<br>습니다."
   * </pre>
   * * @param  String  문자열
   * @param  int     한 라인의 글자수
   * @return String - 넓이가 체크된 문자열
   */
  public static String getCheckWidthString(String argSourceStr, int argByte) {
    if (argSourceStr == null) {
      return "";
    }

    String checkWidthStr = "";
    String appendStr     = "\r\n";
    int    checkByte     = argByte;

    argSourceStr = getNonNullString(argSourceStr);

    if (argSourceStr.getBytes().length <= argByte) {
      return argSourceStr;
    }

    for (int inx = 0; inx < argSourceStr.length(); inx++) {
      String tempStr = argSourceStr.substring(inx, inx + 1);

      if (tempStr.equals("\r") || tempStr.equals("\n")) {  // 캐리지리턴인 경우
        if (tempStr.equals("\n")) {  // 다시 계산...
          checkByte = argByte;
        }

      } else {
        checkByte -= tempStr.getBytes().length;

        if (checkByte < 0) {
          checkWidthStr += appendStr;
          checkByte      = argByte - 1;
        }
      }

      checkWidthStr += tempStr;
    }

    return checkWidthStr;
  }


  /**
	 * <pre>
	 * 기능 : 문자열에서 글자사이에 특정 문자열을 특정 수만큼 채워넣기
	 * 작성 : 2004/07/19 [개발팀/아남정보통신(주)]
	 *         사용예) split("123,456,789", ",");
	 *                ==> [0]=123, [1]=456, [2]=789

	 * </pre>
	 * @param  String 문자열
	 * @param  String 분리문자열
	 * @return String[] - 배열의 분리문자열에 해당하는 문자열
	 */

  public static String[] getToken(String argValue, String delimeter) {

	      String[] res = null;


		  if(argValue != null){
				StringTokenizer st = new StringTokenizer(argValue, delimeter);
				res = new String [st.countTokens()];

				try
				{
					int i =0;
					while(st.hasMoreTokens()) {
					 res[i] = st.nextToken();
					 i++;
					}
				}
				catch(java.util.NoSuchElementException _ex) { }
		  }
		  else
		 {
			   res = null;
		 }

		  return res;

		}


   public static Vector split(String argValue, String delimeter) {
		 Vector resVector = new Vector();

		 if(argValue != null){

  		   StringTokenizer st = new StringTokenizer(argValue, delimeter);
			   try
			   {
                   while (st.hasMoreTokens()) {

                        resVector.addElement(st.nextToken());

                   }
			   }
			   catch(java.util.NoSuchElementException _ex) { }
		 }
		   return resVector;
	   }




   public static String nullToStr(String s) {
		return s != null ? s.trim() : "";
	}

   public static int nullToZero(String s) {
		String s1 = nullToStr(s);
		return s1.equals("") ? 0 : Integer.parseInt(s1);
	}
	public static String changeCheck(String s) {
		String s1 = nullToStr(s);
		return s1.equals("1") ? "true" : "false";
	}


/**
	 * <pre>
	 * 기능 : 문자열에서 특정 문자열을 특정 수만큼 채워넣기
	 * 작성 : 2004/07/19 [개발팀/아남정보통신(주)]
	 *         사용예) getLpad("12", "0", 5);  ==> "00012"
	 *                     getRpad("12", "0", 5);  ==> "12000"

	 * </pre>
	 * @param  String 문자열
	 * @param  String 추가문자열
	 * @param  int       전체길이
	 * @return   String 추가된 문자열
	 */

   public static String getLpad(String argVal, String addVal ,int totalSize) {

	   String returnVal="";
	   for (int inx=0; inx < totalSize - argVal.trim().length() ; inx++ ){
			returnVal += addVal;
	   }

	   return returnVal + argVal.trim();

	}

	public static String getRpad(String argVal, String addVal ,int totalSize) {

		   String returnVal="";
		   for (int inx=0; inx < totalSize - argVal.trim().length() ; inx++ ){
				returnVal += addVal;
		   }

		   return  argVal.trim() + returnVal;

		}

	public static String change_code(String Source_str){

		String Target_str = "";

		if ( Source_str.equalsIgnoreCase(null) ||  Source_str.equalsIgnoreCase(""))
			return Target_str ;
		else if ( Source_str.equalsIgnoreCase("''"))
			return Source_str ;

		try {Target_str = new String(new String(Source_str.getBytes("8859_1"), "KSC5601"));}
		catch (Exception e) {Target_str = new String(Source_str);}

		for(int index = 0; (index = Target_str.indexOf("'", index)) >= 0;  index += 1)
			{Target_str= Target_str.substring(0, index) + "´" + Target_str.substring(index + 1);}

		for(int index = 0; (index = Target_str.indexOf("\\", index)) >= 0;  index += 1)
		   {Target_str= Target_str.substring(0, index) + "￦" + Target_str.substring(index + 1);}

		for(int index = 0; (index = Target_str.indexOf(",", index)) >= 0;  index += 1)
		   {Target_str= Target_str.substring(0, index) + "，" + Target_str.substring(index + 1);}

		return Target_str;

	}

		// 날짜가 형식에 맞는 월인지 체크하는 함수
		public static String checkDate(String sDate)
		 {
				 String sYear = "";
				 String sMonth = "";
				 String sDay = "";

				 int sYear_i  = 0;
				 int sDay_i = 0;
				 int sMonth_i = 0;



				 String result = "";


				 sYear =  sDate.substring(0,4);
				 sMonth = sDate.substring(4,6);
				 sDay = sDate.substring(6);

				sYear_i = Integer.parseInt(sYear);
				sMonth_i = Integer.parseInt(sMonth);
				sDay_i = Integer.parseInt(sDay);


				 if (sMonth.equals("02")){			//2월달일 경우

					if( sDay_i > 28 || sDay_i < 0 ){					//해달 날이 28일 이후이면

						System.out.println(sYear_i%4);
						System.out.println(sYear_i%100);
						System.out.println(sYear_i%400);
						if(sYear_i%4==0 && sYear_i%100>0 || sYear_i%400 ==0){  	//해당년이 윤년이면

							sDay = "29";

						}else{		//해당년이 윤년이 아닐경

							sDay = "28";
						}

					}



				 }else{										//2월이 아닌경우

						if( sMonth.equals("01") ||  sMonth.equals("03") || sMonth.equals("05") || sMonth.equals("07") || sMonth.equals("08") || sMonth.equals("10") ||sMonth.equals("12") )
						{
						//월이 1,3,5,7,8,10,12 경우(최고 31일)

							if (   sDay_i > 31 || sDay_i < 0 ){
								sDay = "31";
							}

						}else{											//월이 4, 6, 9 , 11 일경우 (최고 30일)
							if (sDay_i > 30 || sDay_i < 0 ){
								sDay = "30";
							}

						}


				 }

			result = sYear+sMonth+sDay;


			return result;
		 }

//	날짜가 형식에 맞는 월인지 체크하는 함수
		 public static String checkDate2(String sDate)
		  {
				  String sYear = "";
				  String sMonth = "";
				  String sDay = "";

				  int sYear_i  = 0;
				  int sDay_i = 0;
				  int sMonth_i = 0;



				  String result = "";


				  sYear =  sDate.substring(0,4);
				  sMonth = sDate.substring(5,7);
				  sDay = sDate.substring(8);

				 sYear_i = Integer.parseInt(sYear);
				 sMonth_i = Integer.parseInt(sMonth);
				 sDay_i = Integer.parseInt(sDay);


				  if (sMonth.equals("02")){			//2월달일 경우

					 if( sDay_i > 28 || sDay_i < 0 ){					//해달 날이 28일 이후이면

						 System.out.println(sYear_i%4);
						 System.out.println(sYear_i%100);
						 System.out.println(sYear_i%400);
						 if(sYear_i%4==0 && sYear_i%100>0 || sYear_i%400 ==0){  	//해당년이 윤년이면

							 sDay = "29";

						 }else{		//해당년이 윤년이 아닐경

							 sDay = "28";
						 }

					 }



				  }else{										//2월이 아닌경우

						 if( sMonth.equals("01") ||  sMonth.equals("03") || sMonth.equals("05") || sMonth.equals("07") || sMonth.equals("08") || sMonth.equals("10") ||sMonth.equals("12") )
						 {
						 //월이 1,3,5,7,8,10,12 경우(최고 31일)

							 if (   sDay_i > 31 || sDay_i < 0 ){
								 sDay = "31";
							 }

						 }else{											//월이 4, 6, 9 , 11 일경우 (최고 30일)
							 if (sDay_i > 30 || sDay_i < 0 ){
								 sDay = "30";
							 }

						 }


				  }

			 result = sYear+'-'+sMonth+'-'+sDay;


			 return result;
		  }

//	double 형태의 String 에서 소수점 밑의 자리를 다 버림

		  public static String getD2S(String param){

			 String result = "";

				 if (param != ""){
					 result = param.substring(0,param.indexOf("."));
				 }


			 return result;

		  }

	/**  두 날짜 사이의 차이
	   *
	   *  @param startDate 시작 날짜
	   *  @param endDate   종료 날짜
	   *  @param format    날짜 형식
	   *  @return long     날짜 차이
	   */
		public static long calDateRange( String startDate, String endDate ) throws Exception{

			String	format = "yyyy-MM-dd";
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			Date sDate;
			Date eDate;
			long day2day = 0;
			try {
				sDate = sdf.parse(startDate);
				eDate = sdf.parse(endDate);
				day2day = (eDate.getTime() - sDate.getTime()) / (1000*60*60*24);
			} catch(Exception e) {
				throw new Exception("wrong format string");
			}

			return day2day;
		}

		/**
		 * 파라메터의 값을 숫자화할 수 있는 것만 추출해서 문자열로 리턴한다.
		 */
		public static String getNum(String pValue){
		    String rValue = "0";
		    StringBuffer sb = new StringBuffer();

		    if(pValue != null){
		        for(int i=0;i<pValue.length();i++){
		            if("-0123456789.".indexOf(pValue.substring(i,i+1)) >= 0){
		                sb.append(pValue.substring(i,i+1));
		            }
		        }

		        rValue = sb.toString();
		        if(pValue.indexOf("(") == 0){//괄호가 쳐져 있는 경우는 -(마이너스)로 인식한다.
			        rValue = "-" + rValue;
		        }
		    }

		    return rValue.equals("") ? "0" : rValue;
		}
		public static String getNum(java.math.BigDecimal pValue){
		    return pValue == null ? "0" : pValue + "";
		}
		public static String getNum(Object pValue){
	        return JSPUtil.getNum((String) pValue);
		}
		public static String getNum(int pValue){
		    return pValue + "";
		}
		public static String getNum(long pValue){
		    return pValue + "";
		}
		/** 문자열로 숫자를 리턴한다. 고정소수점 형식으로 리턴한다.(지수표현을 사용안함)  */
		public static String getNum(double pValue){
		    return new DecimalFormat("0.##########").format(pValue);
		}
		/** 문자열로 숫자를 리턴한다. 고정소수점 형식으로 리턴한다.(지수표현을 사용안함)  */
		public static String getNum(float pValue){
		    return new DecimalFormat("0.##########").format(pValue);
		}

		/**
		 * 파라메터의 값을 숫자화할 수 있는 것만 추출해서 double로 리턴한다.
		 */
		public static double getDouble(String pValue){
		    return Double.parseDouble(getNum(pValue));
		}
		public static double getDouble(java.math.BigDecimal pValue){
		    return pValue == null ? 0 : pValue.doubleValue();
		}
		public static double getDouble(Object pValue){
	        return JSPUtil.getDouble((String) pValue);
		}
		public static double getDouble(int pValue){
		    return pValue;
		}
		public static double getDouble(long pValue){
		    return pValue;
		}
		public static double getDouble(double pValue){
		    return pValue;
		}
		public static double getDouble(float pValue){
		    return pValue;
		}

		/**
		 * 파라메터의 값을 숫자화할 수 있는 것만 추출해서 Long으로 리턴한다. 소수점 이하는 버린다.
		 */
		public static long getLong(String pValue){
		    String v = getNum(pValue);
		    if(v.indexOf(".") != -1){
		        return Math.round(Math.floor(Double.parseDouble(v)));
		    }else{
		        return Long.parseLong(getNum(pValue));
		    }
		}
		public static long getLong(java.math.BigDecimal pValue){
		    return pValue == null ? 0 : pValue.longValue();
		}
		public static long getLong(Object pValue){
	        return JSPUtil.getLong((String) pValue);
		}
		public static long getLong(int pValue){
		    return pValue;
		}
		public static long getLong(long pValue){
		    return pValue;
		}
		public static long getLong(double pValue){
		    return Math.round(Math.floor(pValue));
		}
		public static long getLong(float pValue){
		    return Math.round(Math.floor(pValue));
		}
		/**
		 * 파라메터의 값을 숫자화할 수 있는 것만 추출해서 Int으로 리턴한다. 소수점 이하는 버린다.
		 */
		public static int getInt(String pValue){
		    String v = getNum(pValue);
		    if(v.indexOf(".") != -1){
		        return Integer.parseInt(Math.floor(Double.parseDouble(v)) + "");
		    }else{
		        return Integer.parseInt(getNum(pValue));
		    }
		}
		public static int getInt(java.math.BigDecimal pValue){
		    return pValue == null ? 0 : pValue.intValue();
		}
		public static int getInt(Object pValue){
	        return JSPUtil.getInt((String) pValue);
		}
		public static int getInt(int pValue){
		    return pValue;
		}
		public static int getInt(long pValue){
		    return (int) pValue;
		}
		public static int getInt(double pValue){
		    return (int) Math.round(Math.floor(pValue));
		}
		public static int getInt(float pValue){
		    return (int) Math.round(Math.floor(pValue));
		}

		/** 입력된 숫자형문자열을 1000 단위 구분자를 추가하여 문자열로 리턴한다. */
		public static String getMFormat(String pValue){
		    return JSPUtil.getMFormat(JSPUtil.getDouble(pValue));
		}
		public static String getMFormat(java.math.BigDecimal pValue){
	        return new DecimalFormat("###,##0.##########").format(pValue);
		}
		public static String getMFormat(Object pValue){
	        return JSPUtil.getMFormat((String) pValue);
		}
		/** 1000 단위 구분자를 추가하여 문자열로 리턴한다. */
		public static String getMFormat(double pValue){
		    return new DecimalFormat("###,##0.##########").format(pValue);
		}
		/** 1000 단위 구분자를 추가하여 문자열로 리턴한다. */
		public static String getMFormat(float pValue){
		    return new DecimalFormat("###,##0.##########").format(pValue);
		}
		/** 1000 단위 구분자를 추가하여 문자열로 리턴한다. */
		public static String getMFormat(int pValue){
		    return new DecimalFormat("###,##0.##########").format(pValue);
		}
		/** 1000 단위 구분자를 추가하여 문자열로 리턴한다. */
		public static String getMFormat(long pValue){
		    return new DecimalFormat("###,##0.##########").format(pValue);
		}

		/** pFormat 형식에 맞게 숫자포맷으로 값을 리턴한다. */
		public static String getMFormat(String pValue, String pFormat){
		    return JSPUtil.getMFormat(JSPUtil.getDouble(pValue));
		}
		public static String getMFormat(java.math.BigDecimal pValue, String pFormat){
	        return new DecimalFormat(pFormat).format(pValue);
		}
		public static String getMFormat(Object pValue, String pFormat){
	        return JSPUtil.getMFormat((String) pValue);
		}
		public static String getMFormat(double pValue, String pFormat){
		    return new DecimalFormat(pFormat).format(pValue);
		}
		public static String getMFormat(float pValue, String pFormat){
		    return new DecimalFormat(pFormat).format(pValue);
		}
		public static String getMFormat(int pValue, String pFormat){
		    return new DecimalFormat(pFormat).format(pValue);
		}
		public static String getMFormat(long pValue, String pFormat){
		    return new DecimalFormat(pFormat).format(pValue);
		}

		/**
		 * 문자열에 아무런 데이터가 없으면  빈공백 추가하고 데이터가 있으면 trim을 해준다
		 */
		public static String rns(String pValue){
			if(pValue == null){
				return "";
			}else{
				if(pValue.trim().equals("")){
					return "";
				}else{
					return pValue.trim();
				}
			}
		}

		/**
		 * 문자열에 아무런 데이터가 없으면  & nbsp; 추가하고 데이터가 있으면 trim을 해준다
		 */
		public static String rns2(String pValue){
			if(pValue == null){
				return "&nbsp;";
			}else{
				if(pValue.trim().equals("")){
					return "&nbsp;";
				}else{
					return pValue.trim();
				}
			}
		}

		/**
		 * 정수형문자열에 아무런 데이터가 없으면  빈공백을  추가하고 데이터가 있으면 trim 및 콤마를 제거한다.
		 */
		public static String rns3(String pValue){
			if(pValue == null){
				return "0";
			}else{
				if(pValue.trim().equals("")){
					return "0";
				}else{
					return pValue.trim().replaceAll(",", "");
				}
			}
		}

		/**
		 *Converts String to float.
		 *
		 *Parameters:
		 *    value -
		 *    defaultValue -
		 *Returns:
		 *    converted value, or default value if error
		 */
		public static float toFloat(String value, float defaultValue) {
			if (value == null)
				return defaultValue;
			try {
				return Float.parseFloat(value);
			} catch (NumberFormatException nfex) {
				return defaultValue;
			}
		}

		/**
		 *Converts String to double.
		 *
		 *Parameters:
		 *    value -
		 *    defaultValue -
		 *Returns:
		 *    converted value, or default value if error
		 */
		public static double toDouble(String value, double defaultValue) {
			if (value == null)
				return defaultValue;
			try {
				return Double.parseDouble(value);
			} catch (NumberFormatException nfex) {
				return defaultValue;
			}
		}

		/**
		 *Converts String to int.
		 *
		 *Parameters:
		 *    value -
		 *    defaultValue -
		 *Returns:
		 *    converted value, or default value if error
		 */
		public static int toInt(String value, int defaultValue) {
			if (value == null)
				return defaultValue;
			try {
				return Integer.parseInt(value);
			} catch (NumberFormatException nfex) {
				return defaultValue;
			}
		}

		/**
		 *Converts String to long.
		 *
		 *Parameters:
		 *    value -
		 *    defaultValue -
		 *Returns:
		 *    converted value, or default value if error
		 */
		public static long toLong(String value, long defaultValue) {
			if (value == null)
				return defaultValue;
			try {
				return Long.parseLong(value);
			} catch (NumberFormatException nfex) {
				return defaultValue;
			}
		}

		/**
		 *Converts String to byte.
		 *
		 *Parameters:
		 *    value -
		 *defaultValue -
		 *    Returns:
		 *    converted value, or default value if error
		*/
		public static byte toByte(String value, byte defaultValue) {
			if (value == null)
				return defaultValue;
			try {
				return Byte.parseByte(value);
			} catch (NumberFormatException nfex) {
				return defaultValue;
			}
		}

		/**
		 *윤년인지 판단한다.
 		 *
		 *Parameters:
		 *    year - 년도
		 *Returns:
		 *    윤년 true 아니면 fals
		 */
		public static boolean isLeafYear(int year) {
			return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
		}

		/**
		 * source의 길이가 length만큼 될 때 까지 source 앞에 0을 붙여 리턴한다.
 		 * 예) fillZero('123',5) ==> '00123'
		 *
		 * Parameters:
		 *     source - 앞에 0을 붙일 문자열
		 *     length - 0을 붙여 만들 문자열의 전체 길이
		 * Returns:
		 *     java.lang.String
		 */
		public static String fillZero(String source, int length) {
			if (source == null)
				return "";
			if (source.length() >= length)
				return source;
			for (; source.length() < length; source = "0" + source)
				;
			return source;
		}

		/**
		 * YYYYMM 의 파라메터를 받아 해당월의 마지막 일자를 반환한다.
		 */
		public static int Last_Date(String ss){
			int in_i=0, in_k=0, Last_Date=0;

			in_k = Integer.parseInt(ss.substring( 0, 4 ));
			in_i = Integer.parseInt(ss.substring( 4, 6));

			if( in_i == 1 || in_i == 3 || in_i == 5 || in_i == 7 || in_i == 8 || in_i == 10 || in_i == 12 ){
				Last_Date = 31;
			}else if( in_i == 4 || in_i == 6 || in_i == 9 || in_i == 11 ){
				Last_Date = 30;
			}else if( in_i == 2 ) {
				if(isLeafYear(in_k)) Last_Date = 29;
				else Last_Date = 28;
			}else{
				Last_Date = -1;
			}
			return Last_Date;
		}

		/**
		 * YYYYMMDD 의 파라메터를 받아 두기간의 월차이를 반환한다.
		 */
		public static int monthDiff(String from, String to){
			int s_y, s_m, e_y, e_m;
			int rValue = 0;

			if(from.trim().length() >= 6 && to.trim().length() >= 6){
				s_y = Integer.parseInt(from.substring(0,4));
				s_m = Integer.parseInt(from.substring(4,6));

				e_y = Integer.parseInt(to.substring(0,4));
				e_m = Integer.parseInt(to.substring(4,6));

				rValue = ((e_y - s_y) * 12) + (e_m - s_m);
			}

			return rValue;
		}

		/**
		 * YYYYMMDD 의 파라메터를 받아 두기간의 근속기간을 년도만 반환한다.
		 */
		public static double Gunsok_Year(String s, String d){
			String stt_str, stt_y;

			stt_str = Gunsok_Date(s,d);
			stt_y = stt_str.substring(0,4);
			return toDouble(stt_y, 0.0);
		}

		/**
		 * YYYYMMDD 의 파라메터를 받아 두기간의 근속기간을 년월을 1.5년 형식으로 반환한다.
		 */
		public static double Gunsok_Month(String s, String d){
			String stt_str, stt_y, stt_m, stt_d;

			stt_str = Gunsok_Date(s,d).replaceAll("-","");

			stt_y = stt_str.substring(0,4);
			stt_m = stt_str.substring(4,6);
			stt_d = stt_str.substring(6,8);

			return (toInt(stt_y,0) + (toInt(stt_m,0) / 12.0) + (toInt(stt_d,0) / 365.0));
		}

		/**
		 * YYYYMMDD 의 파라메터를 받아 두기간의 근속기간을 YYYYMMDD 형식으로 반환한다.(ex 1년 4개월 22일 경우 00010422 반환)
		 */
		public static String Gunsok_Date(String s, String d){
			int stt_y = 0, stt_m = 0, stt_d = 0, stt_month;
			int tmpSDay, tmpDDay;

			tmpSDay = toInt(s.substring(6,8),0);
			tmpDDay = toInt(d.substring(6,8),0);

			stt_month = (int) monthDiff(s,d);
			stt_y = stt_month / 12;
			stt_m = stt_month % 12;

			if(tmpSDay == 1){
				if(tmpDDay >= Last_Date(d)){
					stt_m += 1;
					stt_d = 0;
				}else{
					stt_d = tmpDDay;
				}
			}else if(tmpSDay - 1 <= tmpDDay)
				stt_d = tmpDDay - tmpSDay + 1;
			else if(tmpDDay >= Last_Date(d))
				stt_d = Last_Date(s) - tmpSDay + 1;
			else{
				if(stt_month == 0){
					//잘못된 데이터 입니다.;
				}else{
					stt_m -= 1;

					stt_d = (Last_Date(s) - tmpSDay + 1) + tmpDDay;
				}
			}

			if(stt_m < 0){
				stt_y -= 1;
				stt_m = 11;
			}else if(stt_m == 12){
				stt_y += 1;
				stt_m = 0;
			}

			return fillZero(stt_y + "",4) + fillZero(stt_m + "",2) + fillZero(stt_d + "",2);
		}

		/**
		 * str을 size길이에 맞도록 왼쪽에 f_char로 채운다.
		 *
		 * Parameters:
		 *     str - 원래 문자열
		 *     f_char - 원래 문자열 뒤에 붙일 문자열
		 *     size - f_char를 붙여 만들 문자열의 길이
		 *
		 * Returns:
		 *     String 원래 문자열에 f_char를 붙여 만든 문자열
		 */
		public static String lpad(String str, String f_char, int size) {
			if (str.length() >= size)
				return str;
			else
				return getFillChar("", f_char, size - str.length()) + str;
		}

		/**
		 * byte단위로 str을 size길이에 맞도록 왼쪽에 f_char로 채운다.
		 */
		public static String byteLpad(String str, String f_char, int size) {
			str = rns(str);

			if (str.getBytes().length >= size){
				return str;

			}else{
				byte[] lineByte = str.getBytes();
				ByteBuffer byteBuffer = ByteBuffer.allocate(size);

                for(int i=0; i<size-lineByte.length; i++) {
                	byteBuffer.put(f_char.getBytes());
                }

                //byte 단위로 읽어옴
                byteBuffer.put(lineByte);

				return new String(byteBuffer.array());

			}
		}

		/**
		 * str을 size길이에 맞도록 오른쪽에 f_char로 채운다.
		 *
		 * Parameters:
		 *     str - 원래 문자열
		 *     f_char - 원래 문자열 뒤에 붙일 문자열
		 *     size - f_char를 붙여 만들 문자열의 길이
		 *
		 * Returns:
		 *     String 원래 문자열에 f_char를 붙여 만든 문자열
		 */
		public static String rpad(String str, String f_char, int size) {
			if (str.length() >= size)
				return str;
			else
				return str + getFillChar("", f_char, size - str.length());
		}

		/**
		 * byte단위로 str을 size길이에 맞도록 오른쪽에 f_char로 채운다.
		 */
		public static String byteRpad(String str, String f_char, int size) {
			str = rns(str);

			if (str.getBytes().length >= size){
				return str;

			}else{
				byte[] lineByte = str.getBytes();
				ByteBuffer byteBuffer = ByteBuffer.allocate(size);

                //byte 단위로 읽어옴
                byteBuffer.put(lineByte);

                for(int i=lineByte.length; i<size; i++) {
                	byteBuffer.put(f_char.getBytes());
                }

				return new String(byteBuffer.array());

			}
		}

		/**
		 * str을 size길이에 맞도록 뒤에 f_char로 채운다.
		 *
		 * Parameters:
		 *     str - 원래 문자열
		 *     f_char - 원래 문자열 뒤에 붙일 문자열
		 *     size - f_char를 붙여 만들 문자열의 길이
		 *
		 * Returns:
		 *     String 원래 문자열에 f_char를 붙여 만든 문자열
		 */
		public static String getFillChar(String str, String f_char, int size) {
			String fillChar = "";
			if (str.length() >= size)
				return str;
			for (int index = 0; index < size - str.length(); index++)
				fillChar = fillChar + f_char;

			return str + fillChar;
		}

		/**<pre>
		 * 작성 : 한학현
		 * 내역 : 양력->음력, 음력->양력으로 변환 한다.
		 * 			 gf_year : 년(yyyy), gf_month : 월(MM), gf_day : 일(dd), gubun : 구분(+ or -)
		 *          (gubun 값이 '+'이면 음력->양력, '-'이면 양력->음력으로 변환)
		 * 			리턴 - 양력 : yyyy-MMdd요일
		 *                   음력 : yyyy-MMdd
		 * 	         (ASP의 yuchange module의 gf_lun2sol function 참고)
		 *
		 * @param gf_year
		 * @param gf_month
		 * @param gf_day
		 * @param gubun
		 * @return
		 * @throws Exception
		 * </pre>
		 */
		public static String changeCalendar(String gf_year, String gf_month, String gf_day, String Gubun){

			String gf_lun2sol = "";

			int syear = 0, smonth = 0, sday = 0;//양력 (단기 syear + 2333)
			String sweek = "";//양력
			//Dim gf_year As Integer, gf_month As Integer, gf_day As Integer    ' 음력 변수

			//전달 변수
			int exyear = 0, exmonth = 0;
			long exday = 0;
			String exyuk = "", exddi = "", exweek = "";

			// Dim Gubun As String '양력 체크 구분자
			int gf_Is_Yun = 0, num = 0;

			String LTBLSTR ="";

			String[] LTBL = new String[170+1];
			String LDAYSTR = "";
			String[] LDAY = new String[40+1];
			String[] DT = new String[170+1];
			long TD = 0;

			String YUKSTR = "";
			String[] YUK = new String[100+1];
			String GAPSTR = "";
			String[] GAP = new String[100+1];
			String DDISTR = "";
			String[] DDI = new String[100+1];
			String WEEKSTR = "";
			String[] WEEK = new String[100+1];

			String SYUK = "";
			String SGAP = "";
			String SDDI = "";

			boolean GF_YUN = false;
			boolean LEAP = false;

			long Y = 0;
			int i = 0;
			int j = 0;
			int W = 0;
			int a = 0;
			int b = 0;

			String temp;

			//임시변수
			long TD1 = 0;
			long TD2 = 0;
			long K11 = 0;
			double TD0 = 0;

			//임시변수
			int GF_SOL2LUN = 0;
			int ryear = 0;
			int JCOUNT = 0;
			int K1 = 0;
			int K2 = 0;

			//================================================(2006-02)... 버그 수정하면서... 약간 보기좋게... 인터넷에 떠도는거!.. BY 90002
			//LTBL(124) = "1212122122110" '기존 1212122122120 를 변경
			//LTBL(125) = "2121212322122" '기존 1121212322122 를 변경
			//======================================================================
			//LTBLSTR = "1212122322121-1212121221220-1121121222120-2112132122122-2112112121220-2121211212120-2212321121212-2122121121210-" _
			//& "2122121212120-1232122121212-1212121221220-1121123221222-1121121212220-1212112121220-2121231212121-2221211212120-1221212121210-" _
			//& "2123221212121-2121212212120-1211212232212-1211212122210-2121121212220-1212132112212-2212112112210-2212211212120-1221412121212-" _
			//& "1212122121210-2112212122120-1231212122212-1211212122210-2121123122122-2121121122120-2212112112120-2212231212112-2122121212120-" _
			//& "1212122121210-2132122122121-2112121222120-1211212322122-1211211221220-2121121121220-2122132112122-1221212121120-2121221212110-" _
			//& "2122321221212-1121212212210-2112121221220-1231211221222-1211211212220-1221123121221-2221121121210-2221212112120-1221241212112-" _
			//& "1212212212120-1121212212210-2114121212221-2112112122210-2211211412212-2211211212120-2212121121210-2212214112121-2122122121120-" _
			//& "1212122122120-1121412122122-1121121222120-2112112122120-2231211212122-2121211212120-2212121321212-2122121121210-2122121212120-" _
			//& "1212142121212-1211221221220-1121121221220-2114112121222-1212112121220-2121211232122-1221211212120-1221212121210-2121223212121-" _
			//& "2121212212120-1211212212210-2121321212221-2121121212220-1212112112210-2223211211221-2212211212120-1221212321212-1212122121210-" _
			//& "2112212122120-1211232122212-1211212122210-2121121122210-2212312112212-2212112112120-2212121232112-2122121212110-2212122121210-" _
			//& "2112124122121-2112121221220-1211211221220-2121321122122-2121121121220-2122112112322-1221212112120-1221221212110-2122123221212-" _
			//& "1121212212210-2112121221220-1211231212222-1211211212220-1221121121220-1223212112121-2221212112120-1221221232112-1212212122120-" _
			//& "1121212212210-2112132212221-2112112122210-2211211212210-2221321121212-2212121121210-2212212112120-1232212122112-1212122122120-" _
			//& "1121212322122-1121121222120-2112112122120-2211231212122-2121211212120-2122121121210-2124212112121-2122121212120-1212121223212-" _
			//& "1211212221220-1121121221220-2112132121222-1212112121220-2121211212120-2122321121212-1221212121210-2121221212120-1232121221212-" _
			//& "1211212212210-2121123212221-2121121212220-1212112112220-1221231211221-2212211211220-1212212121210-2123212212121-2112122122120-" _
			//& "1211212322212-1211212122210-2121121122120-2212114112122-2212112112120-2212121211210-2212232121211-2122122121210-2112122122120-" _
			//& "1231212122212-1211211221220-2121121321222-2121121121220-2122112112120-2122141211212-1221221212110-2121221221210-2114121221221"		  '2050
			LTBLSTR = "1212122322121-1212121221220-1121121222120-2112132122122-2112112121220-2121211212120-2212321121212-2122121121210-";//1881~1988
			LTBLSTR = LTBLSTR + "2122121212120-1232122121212-1212121221220-1121123221222-1121121212220-1212112121220-2121231212121-2221211212120-1221212121210-";//1889~1897
			LTBLSTR = LTBLSTR + "2123221212121-2121212212120-1211212232212-1211212122210-2121121212220-1212132112212-2212112112210-2212211212120-1221412121212-";//1898~1906
			LTBLSTR = LTBLSTR + "1212122121210-2112212122120-1231212122212-1211212122210-2121123122122-2121121122120-2212112112120-2212231212112-2122121212120-";//1907~1915
			LTBLSTR = LTBLSTR + "1212122121210-2132122122121-2112121222120-1211212322122-1211211221220-2121121121220-2122132112122-1221212121120-2121221212110-";//1916~1924
			LTBLSTR = LTBLSTR + "2122321221212-1121212212210-2112121221220-1231211221222-1211211212220-1221123121221-2221121121210-2221212112120-1221241212112-";//1925~1933
			LTBLSTR = LTBLSTR + "1212212212120-1121212212210-2114121212221-2112112122210-2211211412212-2211211212120-2212121121210-2212214112121-2122122121120-";//1934~1942
			LTBLSTR = LTBLSTR + "1212122122120-1121412122122-1121121222120-2112112122120-2231211212122-2121211212120-2212121321212-2122121121210-2122121212120-";//1943~1951
			LTBLSTR = LTBLSTR + "1212142121212-1211221221220-1121121221220-2114112121222-1212112121220-2121211232122-1221211212120-1221212121210-2121223212121-";//1952~1960
			LTBLSTR = LTBLSTR + "2121212212120-1211212212210-2121321212221-2121121212220-1212112112210-2223211211221-2212211212120-1221212321212-1212122121210-";//1961~1969
			LTBLSTR = LTBLSTR + "2112212122120-1211232122212-1211212122210-2121121122210-2212312112212-2212112112120-2212121232112-2122121212110-2212122121210-";//1970~1978
			LTBLSTR = LTBLSTR + "2112124122121-2112121221220-1211211221220-2121321122122-2121121121220-2122112112322-1221212112120-1221221212110-2122123221212-";//1979~1987
			LTBLSTR = LTBLSTR + "1121212212210-2112121221220-1211231212222-1211211212220-1221121121220-1223212112121-2221212112120-1221221232112-1212212122120-";//1988~1996
			LTBLSTR = LTBLSTR + "1121212212210-2112132212221-2112112122210-2211211212210-2221321121212-2212121121210-2212212112120-1232212122112-1212122122110-";//1997~2005
			LTBLSTR = LTBLSTR + "2121212322122-1121121222120-2112112122120-2211231212122-2121211212120-2122121121210-2124212112121-2122121212120-1212121223212-";//2006~2014
			LTBLSTR = LTBLSTR + "1211212221220-1121121221220-2112132121222-1212112121220-2121211212120-2122321121212-1221212121210-2121221212120-1232121221212-";//2015~2023
			LTBLSTR = LTBLSTR + "1211212212210-2121123212221-2121121212220-1212112112220-1221231211221-2212211211220-1212212121210-2123212212121-2112122122120-";//2024~2032
			LTBLSTR = LTBLSTR + "1211212322212-1211212122210-2121121122120-2212114112122-2212112112120-2212121211210-2212232121211-2122122121210-2112122122120-";//2033~2041
			LTBLSTR = LTBLSTR + "1231212122212-1211211221220-2121121321222-2121121121220-2122112112120-2122141211212-1221221212110-2121221221210-2114121221221";//2042~2050

			LTBL[0] = LTBLSTR.substring(0,13);
			DT[0] = LTBL[0];
			for(a=14; a<=170; a++){
				for(b=1; b<=168; b++){
					LTBL[b] = LTBLSTR.substring(a,a+13);
					DT[b] = LTBL[b];
					a = a + 14;
				}
			}

			LDAYSTR = "31-00-31-30-31-30-31-31-30-31-30-31";
			LDAY[0] = LDAYSTR.substring(0,2);
			for(a=3; a<=13; a++){
				for(b=1; b<=11; b++){
					LDAY[b] = LDAYSTR.substring(a, a+2);
					a = a +3;
				}
			}

			YUKSTR = "갑을병정무기경신임계";
	        for(K1=1; K1<=10; K1++){
		            YUK[K1] = YUKSTR.substring(K1-1,K1).trim();
	        }

	        GAPSTR = "자축인묘진사오미신유술해";
	        for(K2=1; K2<=12; K2++){
	            YUK[K2] = GAPSTR.substring(K2-1,K2).trim();
	        }

	        DDISTR = "쥐소호랑이토끼용뱀말양원숭이닭개돼지";
	        for(K2=1; K2<=12; K2++){
	        	if(K2 == 1 || K2 == 2){
	        		DDI[K2] = DDISTR.substring(K2-1,K2).trim();
	        	}else if(K2 == 3){
	        		DDI[K2] = DDISTR.substring(K2-1,K2+2).trim();
	        	}else if(K2 == 4){
	        		DDI[K2] = DDISTR.substring(K2+1,K2+3).trim();
	        	}else if(K2 == 5 || K2 == 6 || K2 == 7 || K2 == 8){
	        		DDI[K2] = DDISTR.substring(K2+2,K2+3).trim();
	        	}else if(K2 == 9){
	        		DDI[K2] = DDISTR.substring(K2+2,K2+5).trim();
	        	}else if(K2 == 10 || K2 == 11){
	        		DDI[K2] = DDISTR.substring(K2+4,K2+5).trim();
	        	}else if(K2 == 12){
	        		DDI[K2] = DDISTR.substring(K2+4,K2+6).trim();
	        	}
	        }

	        WEEKSTR = "월화수목금토일";
	        //마지막에 공백이 쓰인다?asp에는 1부터 8까지
	        //for(W=1; W<=8; W++){
	        for(W=1; W<=7; W++){
	        	WEEK[W] = WEEKSTR.substring(W-1,W).trim();
	        }

	        long M1 = 0, M2 = 0, N1 = 0, N2 = 0;//중간 변수 //수정

	        M1 = Long.parseLong(gf_year) - 1881;
	        if(Long.parseLong(LTBL[(int)M1].substring(12,13)) == 0){//윤달이 없는 해임
	        	gf_Is_Yun = 0;
	        }else{
	        	if(Long.parseLong(LTBL[(int)M1].substring(Integer.parseInt(gf_month),Integer.parseInt(gf_month)+1)) > 2){
	        		gf_Is_Yun = 1;
	        	}else{
	        		gf_Is_Yun = 0;
	        	}
	        }

	        if(Gubun.equals("+")){
	        	//#########################################################
	            //   음력을 양력으로 변환함
	            //#########################################################
	        	M1 = -1;
	        	TD = 0;
	        	if(Integer.parseInt(gf_year) > 1881 && Integer.parseInt(gf_year) < 2050){
	        		M1 = Long.parseLong(gf_year) - 1882;
	        		for(i=0; i<=M1; i++){
	        			for(j=1; j<=13; j++){
	        				TD = TD + Long.parseLong(LTBL[i].substring(j-1,j));
	        			}
	        			if(Long.parseLong(LTBL[i].substring(12,13)) == 0){
	        				TD = TD + 336;
	        			}else{
	        				TD = TD + 362;
	        			}
	        		}
	        	}else{
	        		gf_lun2sol = "0";
	        	}

	        	M1 = M1 + 1;
		        N2 = Long.parseLong(gf_month) - 1;
		        M2 = -1;

		        while(true){
		        	M2 = M2 + 1;
		        	if(Long.parseLong(LTBL[(int)M1].substring((int)M2, (int)M2+1)) > 2){
		        		TD = TD + 26 + Long.parseLong(LTBL[(int)M1].substring((int)M2, (int)M2+1));//수정
	                    N2 = N2 + 1;
		        	}else{
		        		if(M2 == N2){
		        			if(GF_YUN == true){
		        				TD = TD + 28 + Long.parseLong(LTBL[(int)M1].substring((int)M2, (int)M2+1));
		        			}
		        			break;
		        		}else{
		        			TD = TD + 28 + Long.parseLong(LTBL[(int)M1].substring((int)M2, (int)M2+1));
		        		}
		        	}
		        }

		        TD = TD + Long.parseLong(gf_day) + 29;
		        M1 = 1880;

		        while(true){
		        	M1 = M1 + 1;
		        	if(M1%400 == 0 || M1%100 != 0 && M1%4 == 0){
		        		LEAP = true;
		        	}else{
		        		LEAP = false;
		        	}

		        	if(LEAP){
		        		M2 = 366;
		        	}else{
		        		M2 = 365;
		        	}

		        	if(TD < M2){
		        		break;
		        	}

		        	TD = TD - M2;
		        }

		        syear = (int)M1;
		        LDAY[1] = Long.toString(M2 - 337);
		        M1 = 0;

		        while(true){
		        	M1 = M1 + 1;
		        	if(TD <= Long.parseLong(LDAY[(int)(M1-1)])){
		        		break;
		        	}
		        	TD = TD - Long.parseLong(LDAY[(int)(M1-1)]);
		        }

		        smonth = (int)M1;
		        sday = (int)TD;
		        Y = (long)(syear-1);
		        TD = (long)(Y * 365) + (long)(Y / 4) - (long)(Y / 100) + (long)(Y / 400);

		        if(syear%400 == 0 || syear%100 != 0 && syear%4 == 0){
		        	LEAP = true;
	        	}else{
	        		LEAP = false;
	        	}

		        if(LEAP){
		        	LDAY[1] = "29";
		        }else{
		        	LDAY[1] = "28";
		        }

		        for(i=0; i<=smonth-2; i++){
		        	TD = TD + Long.parseLong(LDAY[i]);
		        }

	            TD = TD + (long)sday;
	            W = (int)(TD%7);

	            sweek = WEEK[W];
	            gf_lun2sol = "1";

	            exyear = syear;
	            exmonth = smonth;
	            exday = sday;
	            exweek = sweek;
	            //음력(gf_year년,gf_month월, gf_day일) -> 양력  syear년 (단기 syear + 2333 년) smonth월 sday일 sweek 요일

	        }else{
	            //#########################################################
	            //   양력을 음력으로 변환함
	            //#########################################################

	        	for(i=0; i<=168; i++){
	        		DT[i] = "0";
	        		for(j=1; j<=12; j++){
	        			if(LTBL[i].substring(j-1,j).equals("1") || LTBL[i].substring(j-1,j).equals("3")){
	        				DT[i] = Long.toString(Long.parseLong(DT[i]) + 29);
	        			}else if(LTBL[i].substring(j-1,j).equals("2") || LTBL[i].substring(j-1,j).equals("4")){
	        				DT[i] = Long.toString(Long.parseLong(DT[i]) + 30);
	        			}
	        		}

	        		if(LTBL[i].substring(12,13).equals("0")){

	        		}else if(LTBL[i].substring(12,13).equals("1") || LTBL[i].substring(12,13).equals("3")){
	        			DT[i] = Long.toString(Long.parseLong(DT[i]) + 29);
	        		}else if(LTBL[i].substring(12,13).equals("2") || LTBL[i].substring(12,13).equals("4")){
	        			DT[i] = Long.toString(Long.parseLong(DT[i]) + 30);
	        		}
	        	}

	        	TD1 = (long)((long)1880 * (long)365) + (long)(1880/4) - (long)(1880/100) + (long)(1880/400) + 30;
	        	K11 = (long)(Long.parseLong(gf_year) - 1);
	        	TD2 = K11 * (long)(365) + (long)(K11/4) - (long)(K11/100) + (long)(K11/400);

	        	if(Long.parseLong(gf_year)%400 == 0 || Long.parseLong(gf_year)%100 != 0 && Long.parseLong(gf_year)%4 == 0){
	        		LDAY[1] = "29";
	        	}else{
	        		LDAY[1] = "28";
	        	}

	        	if(Long.parseLong(gf_month) > 13){
	        		GF_SOL2LUN = 0;
	        	}

	        	if(Long.parseLong(gf_day) > Long.parseLong(LDAY[Integer.parseInt(gf_month.trim())-1])){
	        		GF_SOL2LUN = 0;
	        	}

	        	for(i=0; i<=Long.parseLong(gf_month)-2; i++){
	        		TD2 = TD2 + Long.parseLong(LDAY[i]);//수정
	        	}

	        	TD2 = TD2 + Long.parseLong(gf_day);
	            TD = TD2 - TD1 + 1;
	            TD0 = Double.parseDouble(DT[0]);

	            for(i=0; i<=168; i++){
	            	if(TD <= TD0){
	            		break;
	            	}
	            	TD0 = TD0 + Double.parseDouble(DT[i+1]);
	            }

	            ryear = i + 1881;
	            TD0 = TD0 - Double.parseDouble(DT[i]);
	            TD = TD - (long)TD0;//double값을 long에 집어 넣는다???

	            if(Long.parseLong(LTBL[i].substring(12,13)) == 0){
	            	JCOUNT = 11;
	            }else{
	            	JCOUNT = 12;
	            }
	            M2 = 0;

	            for(j=0; j<=JCOUNT; j++){//달수 check, 윤달 > 2 (by harcoon)
	            	if(Long.parseLong(LTBL[i].substring(j,j+1)) <= 2){
	            		M2 = M2 +1;
	            		M1 = Long.parseLong(LTBL[i].substring(j,j+1)) + 28;
	            		GF_YUN = false;
	            	}else{
	            		M1 = Long.parseLong(LTBL[i].substring(j,j+1)) + 26;
	            		GF_YUN = true;
	            	}
	            	if(TD <= (long)M1){
	            		break;
	            	}
	            	TD = TD - (long)M1;
	            }

	            K1 = (ryear + 6) % 10;
	            SYUK = YUK[K1];
	            K2 = (ryear + 8) % 12;
	            SGAP = GAP[K2];
	            SDDI = DDI[K2+1];

	            GF_SOL2LUN = 1;

	            exyear = ryear;
	            exmonth = (int)M2;//long에서 int로 다운캐스팅??
	            exday = TD;
	            exyuk = (SYUK + SGAP).trim();
	            exddi = SDDI;
	        }

	        // temp = (exyear + "-" + lpad(Integer.toString(exmonth),"0", 2) + lpad(Long.toString(exday),"0", 2) + exweek).trim();//+ exyuk + " " + exddi)
	        // '2007-01-01' 양식으로 리턴되게 수정.(2007/01/03 채갑병)
	        temp = (exyear + "-" + lpad(Integer.toString(exmonth),"0", 2) + "-" + lpad(Long.toString(exday),"0", 2)).trim();//+ exyuk + " " + exddi)
	        gf_lun2sol = temp;

	        return gf_lun2sol;
		}

        /**
         * double type을 소수점 둘째자리까지 자르고 반환 시킴
         * @param num
         * @return
         */
        public static String getDoubleNum(String num) {
            return getDoubleNum(new Double(num).doubleValue());
        }
        
        /**
         * double type을 소수점 둘째자리까지 자르고 반환 시킴
         * @param num
         * @return
         */
        public static String getDoubleNum(Double num) {
            return getDoubleNum(num.doubleValue());
        }
        
        /**
         * double type을 소수점 둘째자리까지 자르고 반환 시킴
         * @param num
         * @return
         */
        public static String getDoubleNum(double num) {
            DecimalFormat dformat = new DecimalFormat("######.##");
            return dformat.format(num);
        }
        
        
        /**
         * 페이징 처리
         * @param pageNum
         * @param listRowSize
         * @param totalListCount
         * @param prevImg
         * @param nextImg
         * @param onclickEventMethodName
         * @return String
         */
        public static String getPaging(
                int currentPageNum,
                int listRowSize,
                int totalListRow,
                String lastImg,
                String prevImg,
                String nextImg,
                String firstImg,
                String onclickEventMethodName) {
            StringBuffer result     = new StringBuffer();

            //pageNum의 총 갯수를 가져옴
            int totalPageNum        = totalListRow/listRowSize;
            if(totalListRow%listRowSize > 0) 
                totalPageNum++;
            
            //현재 Row를 Page단위로 10개씩 묶어 현재 pageRange가 어디에 있는지 확인
            int currentPageRange    = currentPageNum/10;
            if(currentPageRange != 0 && currentPageNum%10 == 0) 
                currentPageRange--;

            result.append("     <table>\n");
            result.append("         <tr>\n");
            result.append("             <td width=70>Page ("+currentPageNum+"/"+totalPageNum+") </td>\n");
            result.append("             <td>\n");
            if(currentPageRange > 0) {
                result.append("                 ");
                result.append("<a href=\"javascript:"+onclickEventMethodName+"("+((currentPageRange-1)*10+1)+")\">");
                result.append("<img src=\""+lastImg+"\" border=\"0\">");
                result.append("</a>\n");
            } else {
                result.append("                 <img src=\""+lastImg+"\" border=\"0\">\n");
            }
            result.append("                 ");
            result.append("<a href=\"javascript:"+onclickEventMethodName+"("+((currentPageNum-1) > 0 ? currentPageNum-1 : 1)+")\">");
            result.append("<img src=\""+prevImg+"\" border=\"0\">");
            result.append("</a>\n");
            result.append("             </td>\n");
            result.append("             <td>\n");

            //pageNum 들을 10개식 뿌림
            if(totalListRow > 0) {
                for(int count=currentPageRange*10+1; count<=totalPageNum && count <= currentPageRange *10 + 10; count++) {
                    result.append("                 ");
                    result.append("<a href=\"javascript:"+onclickEventMethodName+"("+count+")\">"+count+"</a>\n");
                }
            }else {
                result.append("                 ");
                result.append("<a href=\"javascript:"+onclickEventMethodName+"(1)\">1</a>\n");
                //result.append("&nbsp;\n");
            }

            result.append("             </td>\n");
            result.append("             <td>\n");
            result.append("                 ");
            result.append("<a href=\"javascript:"+onclickEventMethodName+"("+((currentPageNum+1) <= totalPageNum ? currentPageNum+1 : currentPageNum)+")\">");
            result.append("<img src=\""+nextImg+"\" border=\"0\">");
            result.append("</a>\n");

            if(totalPageNum/10 > currentPageRange && totalPageNum%10 > 0 ) {
                result.append("                 ");
                result.append("<a href=\"javascript:"+onclickEventMethodName+"("+((currentPageRange+1)*10+1)+")\">\n");
                result.append("<img src=\""+firstImg+"\" border=\"0\">\n");
                result.append("</a>\n");
            } else {
                result.append("                 <img src=\""+firstImg+"\" border=\"0\">\n");
            }
            result.append("             </td>\n");
            result.append("         </tr>\n");
            result.append("     </table>\n");


            return result.toString();
        }
        
        /**
         * 특수문자를 변환 예(Ａ -> A, １ -> 1)
         * @param num
         * @return
         */
        public static String getChangeString(String str) {

        	char tmpChar; 
        	String rtnValue = "";
        	
        	for(int i=0; i<str.length(); i++){

        		switch (str.charAt(i)) {
					case '　' : tmpChar = ' '; break;
					case '０' : tmpChar = '0'; break;
					case '１' : tmpChar = '1'; break;
					case '２' : tmpChar = '2'; break;
					case '３' : tmpChar = '3'; break;
					case '４' : tmpChar = '4'; break;
					case '５' : tmpChar = '5'; break;
					case '６' : tmpChar = '6'; break;
					case '７' : tmpChar = '7'; break;
					case '８' : tmpChar = '8'; break;
					case '９' : tmpChar = '9'; break;
					case 'Ａ' : tmpChar = 'A'; break;
					case 'Ｂ' : tmpChar = 'B'; break;
					case 'Ｃ' : tmpChar = 'C'; break;
					case 'Ｄ' : tmpChar = 'D'; break;
					case 'Ｅ' : tmpChar = 'E'; break;
					case 'Ｆ' : tmpChar = 'F'; break;
					case 'Ｇ' : tmpChar = 'G'; break;
					case 'Ｈ' : tmpChar = 'H'; break;
					case 'Ｉ' : tmpChar = 'I'; break;
					case 'Ｊ' : tmpChar = 'J'; break;
					case 'Ｋ' : tmpChar = 'K'; break;
					case 'Ｌ' : tmpChar = 'L'; break;
					case 'Ｍ' : tmpChar = 'M'; break;
					case 'Ｎ' : tmpChar = 'N'; break;
					case 'Ｏ' : tmpChar = 'O'; break;
					case 'Ｐ' : tmpChar = 'P'; break;
					case 'Ｑ' : tmpChar = 'Q'; break;
					case 'Ｒ' : tmpChar = 'R'; break;
					case 'Ｓ' : tmpChar = 'S'; break;
					case 'Ｔ' : tmpChar = 'T'; break;
					case 'Ｕ' : tmpChar = 'U'; break;
					case 'Ｖ' : tmpChar = 'V'; break;
					case 'Ｗ' : tmpChar = 'W'; break;
					case 'Ｘ' : tmpChar = 'X'; break;
					case 'Ｙ' : tmpChar = 'Y'; break;
					case 'Ｚ' : tmpChar = 'Z'; break;
					default  : tmpChar = str.charAt(i); break;
        		}
        		
        		rtnValue = rtnValue + Character.toString(tmpChar);
        	}
        	
        	
            return rtnValue;

        }
}

