/*
 * *******************************************************************************
 *
 * 1.클래스   명 : StringUtil.java
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

import java.util.Hashtable;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.Vector;

public class CommonUtil {
    private CommonUtil() {
    }

    /**
     * 널체크
     */
    public static boolean isNull(String str) {
        if (str == null || str.equals(null) || str.equals("")) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean isNotNull(String str) {
        if (str != null && !str.equals(null) && !str.equals("")) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 스트링 비교
     */
    public static boolean equals(String str1, String str2) {
        if (isNotNull(str1) && isNotNull(str2)) {
            if (str1.equals(str2)) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    public static boolean equalsIgnoreCase(String str1, String str2) {
        if (isNotNull(str1) && isNotNull(str2)) {
            if (str1.equalsIgnoreCase(str2)) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    /**
     * 스트링 리플레이스
     */
    public static String strReplace(String inputStr, String findStr, String targetStr){
        String tmpStr = "";
        for (int i = 0; i < inputStr.length(); i++) {
            if (i + findStr.length() > inputStr.length()) {
                tmpStr = tmpStr + inputStr.substring(i, inputStr.length());
                return tmpStr;
            }
            if (inputStr.substring(i, i + findStr.length()).equals(findStr)) {
                tmpStr = tmpStr + targetStr;
                i = (i + findStr.length()) - 1;
            } else {
                tmpStr = tmpStr + inputStr.substring(i, i + 1);
            }
        }
        return tmpStr;
    }

    /**
     * 문자열에서 특정 문자열을 찾아 마지막 부분까지 자른다.
     */
    public static String lastToFinal(String inputStr, String findStr) {
        if (isNotNull(inputStr)) {
            if (isNotNull(findStr)) {
                return inputStr.substring(inputStr.lastIndexOf(findStr) + 1);
            } else {
                return inputStr;
            }
        } else {
            return "";
        }
    }

    /**
     * 널처리
     */
    public static String nvl(String str) {
        if (isNull(str)) {
            str = "";
        } else if (str.equalsIgnoreCase("null")) {
            str = "";
        }
        return str;
    }

    public static String nvl(String str, String chstr) {
        if (isNull(str)) {
            str = chstr;
        } else if (str.equalsIgnoreCase("null")) {
            str = chstr;
        }
        return str;
    }

    // 추가 했심.. pronema

    public static long nvlLong(String str) {
        long result = 0;

        try {
            result = Long.parseLong(nvl(str, "0"));
        } catch (Exception e) {
            result = 0;
        }

        return result;
    }

    public static long nvlLong(String str, long value) {
        long result = 0;

        try {
            result = Long.parseLong(nvl(str, "" + value));
        } catch (Exception e) {
            result = 0;
        }

        return result;
    }

    public static long nvlInt(String str) {
        long result = 0;

        try {
            result = Integer.parseInt(nvl(str, "0"));
        } catch (Exception e) {
            result = 0;
        }

        return result;
    }

    public static int nvlInt(String str, int value) {
        int result = 0;

        try {
            result = Integer.parseInt(nvl(str, "" + value));
        } catch (Exception e) {
            result = 0;
        }

        return result;
    }

    /**
     * 오라클 쿼토 처리
     */
    public static String oraQuato(String str) {
        return str.replaceAll("'", "''");
    }

    /**
     * HTML특수문자 변환
     */
    public static String textToHtml(String str) {
        str = str.replaceAll("&", "&amp;");
        str = str.replaceAll("\"", "&quot;");
        str = str.replaceAll("<", "&lt;");
        str = str.replaceAll(">", "&gt;");
        return str;
    }

    public static String htmlToText(String str) {
        str = str.replaceAll("&gt;", ">");
        str = str.replaceAll("&lt;", "<");
        str = str.replaceAll("&quot;", "\"");
        str = str.replaceAll("&amp;", "&");
        return str;
    }

    public static String nlToBr(String str) {
        str = str.replaceAll("\n", "<br>");
        return str;
    }

    public static String brToNl(String str) {
        str = str.replaceAll("<br>", "\n");
        return str;
    }

    /**
     * 자바스크립트에서 사용 가능한 문자열로 변환
     * @param inputStr 변환하고자 하는 문자열
     * @return
     */
    public static String toJavaScript(String str) {
        str = str.replaceAll("\\\\", "\\\\\\\\");
        str = str.replaceAll("\r", "");
        str = str.replaceAll("\n", "\\\\n");
        str = str.replaceAll("\"", "\\\\\"");
        str = str.replaceAll("'", "\\\\'");
        return str;
    }

    /**
     * 한글2바이트 자르기
     */
    public static String cutKor(String p_sString, int p_iTo) {
        byte[] b = p_sString.getBytes();
        if (b.length < p_iTo) {
            return p_sString;
        } else {
            byte[] b1;
            b1 = new byte[p_iTo];
            for (int i = 0; i < p_iTo; ++i) {
                b1[i] = b[i];
            }
            String s = new String(b1);
            if (s.equals("")) {
                b1 = new byte[p_iTo + 1];
                for (int i = 0; i < p_iTo + 1; ++i) {
                    b1[i] = b[i];
                }
            }
            s = new String(b1) + "...";
            return s;
        }
    }

    /**
     * 스트링을 토큰으로 구분한 벡터로 변환
     */
    public static Hashtable stringToHash(String inString, String token) {
        StringTokenizer st1 = new StringTokenizer(inString, token);
        Vector tmpVector = new Vector();
        Hashtable tmpHash = new Hashtable();
        String tmpstr = "";
        while (st1.hasMoreTokens()) {
            tmpVector.add(st1.nextToken());
        }
        for (int i = 0; i < tmpVector.size(); i++) {
            tmpstr = (String) tmpVector.get(i);
            tmpHash.put(tmpstr.substring(0, tmpstr.indexOf("=")), tmpstr.substring(tmpstr.indexOf("=") + 1));
        }
        return tmpHash;
    }

    /**
     * 벡터를 토큰을 가진 스트링으로 변환
     */
    public static String vectorToString(Vector inVector, String token) {
        String tmpString = "";
        String tmpToken = "";
        StringBuffer tmpBuffer = new StringBuffer();
        Iterator it = inVector.iterator();
        int i = 0;
        while (it.hasNext()) {
            if (i != 0) {
                tmpString = token + it.next().toString();
            } else {
                tmpString = it.next().toString();
            }
            i++;
            tmpBuffer.append(tmpString);
        }

        return tmpBuffer.toString();
    }

    /**
     * 스트링을 토큰으로 구분한 벡터로 변환
     */
    public static Vector stringToVector(String inString, String token) {
        StringTokenizer st1 = new StringTokenizer(inString, token);
        Vector tmpVector = new Vector();

        while (st1.hasMoreTokens()) {
            tmpVector.add(st1.nextToken());
        }
        return tmpVector;
    }

    /**
     * 스트링배열을 토큰을 가진 스트링으로 변환
     */
    public static String arrayToString(String[] inArray, String token) {
        String tmpString = "";
        String tmpToken = "";
        StringBuffer tmpBuffer = new StringBuffer();

        for (int i = 0; i < inArray.length; i++) {
            if (i != 0) {
                tmpString = token + inArray[i];
            } else {
                tmpString = inArray[i];
            }
            tmpBuffer.append(tmpString);
        }
        return tmpBuffer.toString();
    }

    /**
     * 스트링 배열내에 입력스트링이 있는지 대소문자 무시하고 체크
     */
    public static boolean isArrayInignoreCase(String[] inArray, String in) {
        boolean ret = false;
        if (inArray != null && in != null) {
            for (int i = 0; i < inArray.length; i++) {
                if (inArray[i].equalsIgnoreCase(in)) {
                    ret = true;
                }
            }
        }
        return ret;
    }

    /**
     * 스트링 배열내에 입력스트링이 있는지 대소문자 무시하고 체크
     */
    public static boolean isArrayIn(String[] inArray, String in) {
        boolean ret = false;
        if (inArray != null && in != null) {
            for (int i = 0; i < inArray.length; i++) {
                if (inArray[i].equals(in)) {
                    ret = true;
                }
            }
        }
        return ret;
    }

    /**
     * 벡터 내에 입력스트링이 있는지 대소문자 무시하고 체크
     */
    public static boolean isVectorInIgnoreCase(Vector inVector, String in) {
        boolean ret = false;
        String tmpStr = "";
        if (inVector != null && in != null) {
            Iterator it = inVector.iterator();
            while (it.hasNext()) {
                tmpStr = (String) it.next();
                if (tmpStr.equalsIgnoreCase(in)) {
                    ret = true;
                }
            }
        }
        return ret;
    }

    /**
     * 벡터 내에 입력스트링이 있는지 대소문자 체크
     */
    public static boolean isVectorIn(Vector inVector, String in) {
        boolean ret = false;
        String tmpStr = "";
        if (inVector != null && in != null) {
            Iterator it = inVector.iterator();
            while (it.hasNext()) {
                tmpStr = (String) it.next();
                if (tmpStr.equals(in)) {
                    ret = true;
                }
            }
        }
        return ret;
    }

    /**
     * 스트링을 토큰으로 구분한 스트링배열로 변환
     */
    public static String[] stringToArray(String inString, String token) {
        StringTokenizer st1 = new StringTokenizer(inString, token);
        String[] tmpArray = new String[st1.countTokens()];
        for (int i = 0; i < tmpArray.length; i++) {
            tmpArray[i] = st1.nextToken();
        }
        return tmpArray;
    }

    /**
     * 인코딩
     */
    public static String encoding(String str, String encode, String decode) {
        if (isNotNull(str)) {
            try {
                return new String(str.getBytes(encode), decode);
            } catch (Exception e) {
                return str;
            }
        } else {
            return str;
        }
    }

    /**
     * 한글인코딩
     */
    public static String encoding(String str) {
        return encoding(str, "KSC5601", "EUC-KR");
    }

    /**
     * 한글디코딩
     */
    public static String decoding(String str) {
        return encoding(str, "EUC-KR", "KSC5601");
    }

    /**
     * 36진번호 연산
     */
    public static String antilog36(String str) {
        String index = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String ret = "";
        String str1 = "";
        String str2 = "";
        int i1 = 0;
        int i2 = 0;
        int sum = 0;
        int next = 0;
        int next1 = 0;
        int next2 = 0;
        int max = index.length() * index.length();
        if (str == null || str.equals(null) || str.equals("")) {
            ret = "01";
        } else if (str.length() != 2) {
            ret = "01";
        } else {
            str1 = str.substring(0, 1);
            str2 = str.substring(1, 2);
            i1 = index.indexOf(str1);
            i2 = index.indexOf(str2);
            sum = (i1 * index.length()) + i2;
            next = sum + 1;
            next1 = next / index.length();
            next2 = next % index.length();
            if (next >= max) {
                ret = "-1";
            } else {
                try {
                    ret = ret + String.valueOf(index.charAt(next1));
                    ret = ret + String.valueOf(index.charAt(next2));
                } catch (StringIndexOutOfBoundsException e) {
                    ret = "-2";
                }
            }
        }
        return ret;
    }

    /**
     * 앞부분에 0제거
     */
    public static String stripZero(String str) {
        String ret = "";
        for (int i = 0; i < str.length(); i++) {
            if (!str.substring(i, i + 1).equals("0")) {
                ret = str.substring(i, str.length());
                break;
            }
        }
        return ret;
    }

    /**
     * seq Encode
     */
    public static String thread_idToStr(String str) {
        String index = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String tmpStr = "";
        String ret = "";
        tmpStr = stripZero(str);
        for (int i = 0; i < tmpStr.length(); i++) {
            ret = ret + index.indexOf(tmpStr.substring(i, i + 1).toUpperCase());
        }
        return ret;
    }

    public static long thread_idToLong(String str) {
        return Long.parseLong(thread_idToStr(str));
    }

    /**
     * 좌측반복문자 붙이기
     */
    public static String paddingLeft(String str, String pad, int cnt) {
        for (int i = 0; i < cnt; i++) {
            str = pad + str;
        }
        return str;
    }

    /**
     * 우측반복문자 붙이기
     */
    public static String paddingRight(String str, String pad, int cnt) {
        for (int i = 0; i < cnt; i++) {
            str = str + pad;
        }
        return str;
    }
}