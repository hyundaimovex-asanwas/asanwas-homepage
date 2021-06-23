
/**
 * @author jwpark
 *
 * ���� IDTECK DB�� ���� ����
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

    //Exception ó���� ���Ͽ� int value�� return �Ѵ�
    // return value int = 0  ------ ����ó��(true)
    // return value int = 1 ------- ������ó��(false)

    static final int SUCCESS = 1;
    static final int FAIL = 0;

    Utility utility = new Utility();

    /**
     * �����θ� ����� ���
     */
    public ArrayList selectQuery(String query) {

        //table�� ��ü row ������ ���� �ڷ���
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

                //table�� �ϳ��� row ���� ��� ��ü bean(xxxRec) ��� ���
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
                //row ���� ����ִ� HashMap ���� ArrayList �� ��´�.
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
     * ����¡�� �� list select�� ��� curpage :���� ������ ��ȣ rows : �������� �� row��
     */
    public ArrayList selectQuery(String query,int curpage, int rows) {

        //table�� ��ü row ������ ���� �ڷ���
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

                //table�� �ϳ��� row ���� ��� ��ü bean(xxxRec) ��� ���
                HashMap entity = new HashMap(colnum);

                for(int i=1; i<= colnum; i++) {
                    Object value = rset.getObject(i);
                    if(value != null) {
                        entity.put(rmeta.getColumnName(i), Utility.en(value.toString()));
                    } else {
                        entity.put(rmeta.getColumnName(i), null);
                    }

                }
                //row ���� ����ִ� HashMap ���� ArrayList �� ��´�.
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
     * �����θ� ����� ���, ���θ� �� HashMap�� ��´�
     * �ڵ�, �ڵ���� �ҷ� �ö� �ַ� ���, �ڵ带 Ű�� �ڵ���� ������ ���
     */
    public HashMap selectQueryHashMap(String query) {

        //table�� ��ü row ������ ���� �ڷ���
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
     * ���� ���� ����
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

            //����ó���� commit ��Ų��.
            //con.commit();

            result = SUCCESS;

        } catch(SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();

            //������ ó���� rollback
            /*
            try {
                con.rollback();
            } catch (SQLException e1) {
                System.out.println(e1.getMessage());
                e1.printStackTrace();
            }
            */

        } finally {
            //commit �ڵ����� ����
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
     * �����θ� ���� �ϰ� ������ ���
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
     * ���̺��,HashMap(�÷���� �÷��� �� �� ����), �ɼ�(������)�� ����
     */
    public int updateQuery(String table_name, HashMap values, String where) {
        int errorCode = 1;
        int result = FAIL;

        Connection con = null;
        PreparedStatement pstmt = null;
        //HashMap key values�� Set���� �����ش�. (HashMap Ű���� column name���� �߱⶧���� column names ����.)
        Set set = values.keySet();

        StringBuffer query = new StringBuffer("update "+table_name);

        //Set �� �迭�� �����ش�.(�÷��̸��� ����.)
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
     *  ���ڿ��� ������ �� �� �� �ְ� ������...updateQuery �����ε�
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

            //HashMap key values�� Set���� �����ش�. (HashMap Ű���� column name���� �߱⶧���� column names ����.)
            set = values.keySet();
            //Set �� �迭�� �����ش�.(�÷��̸��� ����.)
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
     * 	�����θ� ���� �ϰ� ������ ���
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
     * 	���̺� ��� HashMap(�÷���� �÷��� �� �� ����) �� ������ ����
     */
    public int insertQuery(String table_name, HashMap values) {
        int  errorCode = 1;
        int result = FAIL;
        	
        Connection con = null;
        PreparedStatement pstmt = null;
        //HashMap key values�� Set���� �����ش�. (HashMap Ű���� column name���� �߱⶧���� column names ����.)
        Set set = values.keySet();

        StringBuffer query = new StringBuffer("insert into " + table_name);

        //Set �� �迭�� �����ش�.(�÷��̸��� ����.)
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
     * 	������ ���� ���� üũ
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
     * 	������ ���� ���� üũ
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
     * ������ row ��
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
