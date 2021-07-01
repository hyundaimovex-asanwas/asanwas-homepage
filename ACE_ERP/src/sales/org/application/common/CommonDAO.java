/*******************************************************************************
 * 1.클래스   명 : CommonDAO.java
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
 ******************************************************************************/

package sales.org.application.common;

import java.sql.*;

import java.io.CharArrayReader;
import java.io.Reader;
import java.io.Writer;
import java.sql.ResultSet;
import java.sql.Clob;

import sales.org.common.log.LogUtil;
import sales.org.util.CalendarUtil;


public class CommonDAO{

    protected CalendarUtil cal;

    public CommonDAO(){
        cal = new CalendarUtil();
    }

    /**
     * 리소스 반환
     *
     * @param pstmt
     * @param rs
     */
    public void close(PreparedStatement pstmt, ResultSet rs) {
        if(rs != null){
            try {
                rs.close();
                rs = null;
            }catch (Exception e){
                LogUtil.error(e);
            }
        }
        if(pstmt != null){
            try{
                pstmt.close();
                pstmt = null;
            }catch(Exception e){
                LogUtil.error(e);
            }
        }
    }

    /**
     * CLOB에 문자열을 삽입
     *
     * @param clob
     * @param toBeInserted
     *            삽입할 문자열
     * @throws Exception
     */
    public static void clobInsert(Clob clob, String toBeInserted) throws Exception {
        Writer writer = clob.setCharacterStream(0);
        Reader src = new CharArrayReader(toBeInserted.toCharArray());
        char[] buffer = new char[1024];
        int read = 0;
        while((read = src.read(buffer,0,buffer.length)) != -1){
            writer.write(buffer, 0, read); // write clob.
            buffer = new char[1024];
        }
        src.close();
        writer.close();
    }

    /**
     * CLOB로부터 문자열 얻기
     *
     * @param clob
     * @return
     * @throws Exception
     */
    public static String clobToString(Clob clob) throws Exception {
        if(clob == null) return "";

        StringBuffer output = new StringBuffer();

        Reader input = clob.getCharacterStream();

        char[] buffer = new char[1024];
        int byteRead;

        while((byteRead=input.read(buffer,0,1024))!=-1){
            output.append(buffer,0,byteRead);
            buffer = new char[1024];
        }

        input.close();

        return output.toString();
    }
}