
/**
 * @author jwpark
 *
 * 실제 IDTECK DB에 쿼리 실행
 */

package com.hmm.asan.common.dao;


import com.hmm.ejb.common.UtilDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

import com.hmm.asan.common.util.Utility;


public class MultiDAO {

    //Exception 처리를 위하여 int value를 return 한다
    // return value int = 0  ------ 정상처리(true)
    // return value int = 1 ------- 비정상처리(false)

    static final int SUCCESS = 1;
    static final int FAIL = 0;

    Utility utility = new Utility();

    /**
     * 쿼리로만 실행시 사용
     */
    public ArrayList selectQuery(String query) {

        //table의 전체 row 값들을 담을 자료형
        ArrayList beans = new ArrayList();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        ResultSetMetaData rmeta = null;
        StringBuffer queryTmp = new StringBuffer(query);

        //System.out.println(query);

        try {
            con = UtilDB.getConnection("jdbc/tourds");
            pstmt = con.prepareStatement(query.toString());
            rset = pstmt.executeQuery();
            rmeta = rset.getMetaData();

            int colnum = rmeta.getColumnCount();

            while(rset.next()) {

                //table의 하나의 row 값을 담는 객체 bean(xxxRec) 대신 사용
                HashMap entity = new HashMap(colnum);

                for(int i=1; i<= colnum; i++) {
                    Object value = null;
                    value = rset.getObject(i);


                    /*if(!rmeta.getColumnTypeName(i).equals("text"))
                     value = rset.getObject(i);
                     else {

                     StringBuffer tmp = new StringBuffer("");
                     Reader reader  = rset.getCharacterStream(i);

                     char[] buffer = new char[1024];
                     int byteRead;

                     if(reader.ready()) {

                     value = rset.getObject(i);
                     reader.close();
                     }

                     }*/

                    if(value != null) {
                        entity.put(rmeta.getColumnName(i), Utility.en(value.toString()));
                    } else {
                        entity.put(rmeta.getColumnName(i), null);
                    }

                }
                //row 값을 담고있는 HashMap 들을 ArrayList 에 담는다.
                beans.add(entity);
            }

        } catch(Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            UtilDB.closeConnection(con, pstmt, rset);
        }

        return beans;
    }

    /**
     * 페이징이 들어간 list select시 사용 curpage :현재 페이지 번호 rows : 페이지당 들어갈 row수
     */
    public ArrayList selectQuery(String query,int curpage, int rows) {

        //table의 전체 row 값들을 담을 자료형
        ArrayList beans = new ArrayList();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        ResultSetMetaData rmeta = null;
        StringBuffer queryTmp = new StringBuffer(query);


        int rowNum = rows * (curpage - 1);

        //System.out.println(query);

        try {
            con = UtilDB.getConnection("jdbc/tourds");
            pstmt = con.prepareStatement(query.toString(), 1004, 1007);
            pstmt.setMaxRows(rowNum + rows);
            rset = pstmt.executeQuery();

            rmeta = rset.getMetaData();

            int colnum = rmeta.getColumnCount();

            if(curpage > 1 && !rset.absolute(rowNum));

            while(rset.next()) {

                //table의 하나의 row 값을 담는 객체 bean(xxxRec) 대신 사용
                HashMap entity = new HashMap(colnum);

                for(int i=1; i<= colnum; i++) {
                    Object value = rset.getObject(i);
                    if(value != null) {
                        entity.put(rmeta.getColumnName(i), Utility.en(value.toString()));
                    } else {
                        entity.put(rmeta.getColumnName(i), null);
                    }

                }
                //row 값을 담고있는 HashMap 들을 ArrayList 에 담는다.
                beans.add(entity);
            }
            //System.out.println("end query" + beans.size());
        } catch(Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            UtilDB.closeConnection(con, pstmt, rset);
        }

        return beans;
    }


    /**
     * 쿼리로만 실행시 사용, 모든로를 한 HashMap에 담는다
     * 코드, 코드명을 불러 올때 주로 사용, 코드를 키로 코드명을 값으로 사용
     */
    public HashMap selectQueryHashMap(String query) {

        //table의 전체 row 값들을 담을 자료형
        HashMap data = new HashMap();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rset = null;

        try {
            con = UtilDB.getConnection("jdbc/tourds");
            pstmt = con.prepareStatement(query.toString());
            rset = pstmt.executeQuery();

            while(rset.next()) {
                data.put(rset.getString(1), rset.getString(2));
            }
        } catch(Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            UtilDB.closeConnection(con, pstmt, rset);
        }
        return data;
    }

    /**
     * 삭제 쿼리 실행
     */
    public int deleteQuery(String query) {

        Connection con = null;
        PreparedStatement pstmt = null;
        StringBuffer queryTmp = new StringBuffer(query);
        int result = FAIL;

        System.out.println(query);

        try {
            con = UtilDB.getConnection("jdbc/tourds");
            //con.setAutoCommit(false);

            pstmt = con.prepareStatement(Utility.ko(queryTmp.toString()));
            pstmt.executeUpdate();

            //정상처리시 commit 시킨다.
            //con.commit();

            result = SUCCESS;

        } catch(SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();

            //비정상 처리시 rollback
            /*
            try {
                con.rollback();
            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                e1.printStackTrace();
            }
            */

        } finally {
            //commit 자동으로 샛팅
            /*
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            */
            UtilDB.closeConnection(con, pstmt);
        }

        return result;
    }

    /**
     * 쿼리로만 실행 하고 싶을때 사용
     */
    public int updateQuery(String query) {
        int  errorCode = 1;
        int result = FAIL;

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = UtilDB.getConnection("jdbc/tourds");
            //con.setAutoCommit(false);

            pstmt = con.prepareStatement(query.toString());
            pstmt.executeUpdate();

            //con.commit();

            result = SUCCESS;
        } catch( SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            /*
            try {
                con.rollback();
            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                e1.printStackTrace();
            }
            */
        } finally {
            /*
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            */
            UtilDB.closeConnection(con, pstmt);
        }
        return result;
    }

    /**
     * 테이블명,HashMap(컬럼명과 컬럼에 들어갈 값 저장), 옵션(조건절)로 실행
     */
    public int updateQuery(String table_name, HashMap values, String where) {
        int errorCode = 1;
        int result = FAIL;

        Connection con = null;
        PreparedStatement pstmt = null;
        //HashMap key values를 Set으로 돌려준다. (HashMap 키값을 column name으로 했기때문에 column names 담긴다.)
        Set set = values.keySet();

        StringBuffer query = new StringBuffer("update "+table_name);

        //Set 을 배열로 돌려준다.(컬럼이름이 담긴다.)
        Object[] col_name = set.toArray();

        //columns count..
        int col_num = col_name.length;

        query.append(" set ");

        // column name & values append at query
        for(int i=0; i<col_num; i++) {
            query.append(col_name[i].toString()+"= ?");
            if(i != col_num-1)
                query.append(",");
        }

        query.append(" "+where);

        //System.out.println("update | "+query.toString());

        try {
            con = UtilDB.getConnection("jdbc/tourds");
            //con.setAutoCommit(false);

            pstmt = con.prepareStatement(query.toString());

            for(int i=1 ; i<=col_num; i++)
                pstmt.setObject(i, values.get(col_name[i-1]).toString());

            //System.out.println(query.toString());
            pstmt.executeUpdate();

            //con.commit();

            result = SUCCESS;
        } catch( SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            /*
            try {
                con.rollback();
            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                e1.printStackTrace();
            }
            */
        } finally {
            /*
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            */
            UtilDB.closeConnection(con, pstmt);
        }
        return result;
    }

    /**
     *  문자열로 쿼리를 더 할 수 있게 변경함...updateQuery 오버로드
     */
    public int updateQuery(String table_name, HashMap values, String appendSetStr, String where) {
        int  errorCode = 1;
        int result = FAIL;

        Connection con = null;
        PreparedStatement pstmt = null;

        StringBuffer query = new StringBuffer("update "+table_name);

        Set set = null;
        Object[] col_name = null;

        int col_num = 0;

        query.append(" set ");

        if(values != null) {

            //HashMap key values를 Set으로 돌려준다. (HashMap 키값을 column name으로 했기때문에 column names 담긴다.)
            set = values.keySet();
            //Set 을 배열로 돌려준다.(컬럼이름이 담긴다.)
            col_name = set.toArray();

            //columns count..
            col_num = col_name.length;

            // column name & values append at query
            for(int i=0; i<col_num; i++) {
                query.append(col_name[i].toString()+"= ?");
                if(i != col_num-1)
                    query.append(",");
            }
        }

        if(appendSetStr != null) {
            if(values != null)
                query.append(", "+appendSetStr);
            else
                query.append(appendSetStr);
        }
        query.append(" "+where);

        //System.out.println("update | "+query.toString());

        try {
            con = UtilDB.getConnection("jdbc/tourds");
            //con.setAutoCommit(false);

            pstmt = con.prepareStatement(query.toString());

            for(int i=1 ; i<=col_num; i++)
                pstmt.setObject(i, values.get(col_name[i-1]).toString());

            //System.out.println(query.toString());
            pstmt.executeUpdate();

            //con.commit();

            result = SUCCESS;
        } catch( SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            /*
            try {
                con.rollback();
            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                e1.printStackTrace();
            }
            */
        } finally {
            /*
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            */
            UtilDB.closeConnection(con, pstmt);
        }

        return result;
    }

    /**
     * 	쿼리로만 실행 하고 싶을때 사용
     */
    public int insertQuery(String query) {
        int  errorCode = 1;
        int result = FAIL;

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = UtilDB.getConnection("jdbc/tourds");
           // con.setAutoCommit(false);

            pstmt = con.prepareStatement(query.toString());
            pstmt.executeUpdate();

            //con.commit();

            result = SUCCESS;

        } catch( SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            /*
            try {
                con.rollback();
            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                e1.printStackTrace();
            }
            */
        } finally {
            /*
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            */
            UtilDB.closeConnection(con, pstmt);
        }

        return result;
    }

    /**
     * 	테이블 명과 HashMap(컬럼명과 컬럼에 들어갈 값 저장) 을 가지고 실행
     */
    public int insertQuery(String table_name, HashMap values) {
        int  errorCode = 1;
        int result = FAIL;
        	
        Connection con = null;
        PreparedStatement pstmt = null;
        //HashMap key values를 Set으로 돌려준다. (HashMap 키값을 column name으로 했기때문에 column names 담긴다.)
        Set set = values.keySet();

        StringBuffer query = new StringBuffer("insert into " + table_name);

        //Set 을 배열로 돌려준다.(컬럼이름이 담긴다.)
        Object[] col_name = set.toArray();

        int col_num = col_name.length;

        //columns name append at query.
        query.append(" (");
        for(int i=0; i<col_num; i++) {
            query.append(col_name[i].toString());

            if(i != col_num-1)
                query.append(",");
        }

        query.append(")");

        //vaules append at query.
        query.append(" values(");

        for(int i=0; i<col_num; i++) {
            query.append("?");
            if(i != col_num-1)
                query.append(",");
        }

        query.append(")");

        System.out.println("###################### query: "+query.toString());

        try {
            con = UtilDB.getConnection("jdbc/tourds");
            //con.setAutoCommit(false);

            pstmt = con.prepareStatement(query.toString());

            for(int i=1 ; i<=col_num; i++)
                pstmt.setObject(i, values.get(col_name[i-1]).toString());

            pstmt.executeUpdate();

           //con.commit();

            result = SUCCESS;

        } catch( SQLException e) {
            e.printStackTrace();
            /*
            try {
                con.rollback();
            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                e1.printStackTrace();
            }
            */
        } finally {
            /*
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            */
            UtilDB.closeConnection(con, pstmt);
        }

        return result;
    }

    /**
     * 	데이터 존재 여부 체크
     */
    public boolean isExist(String table_name, String column_name, String values) {
        boolean result = false;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        StringBuffer query = new StringBuffer("select "+column_name+" from "+table_name+" where ");
        query.append(column_name+" like ?");

        try {
            con =UtilDB.getConnection("jdbc/tourds");
            pstmt = con.prepareStatement(query.toString());
            pstmt.setString(1, values);
            rset = pstmt.executeQuery();

            //System.out.println(query.toString());

            if(rset.next())
                result = true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            UtilDB.closeConnection(con, pstmt, rset);
        }

        return result;
    }

    /**
     * 	데이터 존재 여부 체크
     */
    public boolean isExist(String table_name, String column_name, int values) {
        boolean result = false;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        StringBuffer query = new StringBuffer("select "+column_name+" from "+table_name+" where ");
        query.append(column_name+" = ?");

        try {
            con =UtilDB.getConnection("jdbc/tourds");
            pstmt = con.prepareStatement(query.toString());
            pstmt.setInt(1, values);
            rset = pstmt.executeQuery();

            //System.out.println(query.toString());

            if(rset.next())
                result = true;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            UtilDB.closeConnection(con, pstmt, rset);
        }

        return result;
    }

    /**
     * 쿼리의 row 수
     */
    public int getRowCount(String query){
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result=0;

        try{
            con = UtilDB.getConnection("jdbc/tourds");
            pstmt = con.prepareStatement(query);
            rs = pstmt.executeQuery();
            if(rs.next()){
                result = rs.getInt(1);
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }finally{
            UtilDB.closeConnection(con, pstmt, rs);
        }
        //System.out.println(result);
        return result;
    }

}
