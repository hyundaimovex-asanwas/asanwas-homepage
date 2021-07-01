/*
 * Created on 2006. 4. 20.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */ 
package kr.co.imjk.board.dao;

import kr.co.imjk.util.DAOHome;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import java.io.PrintWriter;
import java.util.*;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


import kr.co.imjk.util.Util;
import kr.co.imjk.util.HTTPUtil;
import kr.co.imjk.util.Config;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.board.bean.Tbrd_board_ma_bean;
import kr.co.imjk.board.bean.Tbrd_attach_file_de_bean;
/**
 * @author ������
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CommonBoard extends DAOHome{ 
    
    
    /**
     * ���̺� ������ �Խù� ��ü �� ����
     * @param boardType String �Խ��� ����
     * @param part String �˻��� ����÷�
     * @param keyword  String �˻��� �ܾ�
     * @return rtnValue int �Ѱ���
     * @throws DbException
     * @throws Exception
     * @author ������
     */
	public int getTotalCount(String boardType, String part, String keyword ) throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

		String query = "";
        String subSql =" ";

		int totalCount = 0;
		
		if(!keyword.equals("")){
			if(part.equals("1")){
				subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
			}else{
				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				subSql = " AND CONTENT LIKE '%"+keyword+"%' \n";
			}
            
        }	

		query = new StringBuffer()
			.append(" SELECT COUNT(*) as TOTAL \n")
			.append(" from asan.TBRD_BOARD_MA \n")
			.append(" WHERE BOARD_TYPE = ? AND USE_YN ='1' \n")
			.append(subSql).toString(); 

		try {         
            pstmt = dbconn.prepareStatement(query);
            // ���� ���ε�
			pstmt.setString(1, boardType);  // ����������
			rs = pstmt.executeQuery();

			if(rs.next()){
				totalCount = rs.getInt("TOTAL");
			}

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return totalCount;

	 }
	
	
	/**
     * ���̺� ������ �Խù� ��ü �� ����(������ �Խù����� ī��Ʈ)
     * @param boardType String �Խ��� ����
     * @param part String �˻��� ����÷�
     * @param keyword  String �˻��� �ܾ�
     * @return rtnValue int �Ѱ���
     * @throws DbException
     * @throws Exception
     * @author �ڻ��
     */
	public int getFrontTotalCount(String boardType, String part, String keyword ) throws  Exception{
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

		String query = "";
        String subSql =" ";

		int totalCount = 0;
		
		if(!keyword.equals("")){
			if(part.equals("1")){
				subSql = " AND TITLE LIKE '%"+keyword+"%' \n";
			}else{
				//subSql = " AND dbms_lob.instr(CONTENT_CLOB,'"+keyword+"') > 0  \n";
				subSql = " AND CONTENT LIKE '%"+keyword+"%' \n";
			}
            
        }	

		query = new StringBuffer()
			.append(" SELECT COUNT(*) as TOTAL \n")
			.append(" from asan.TBRD_BOARD_MA \n")
			.append(" WHERE BOARD_TYPE = ? \n")
			.append(subSql).toString(); 

		try {         
            pstmt = dbconn.prepareStatement(query);
            // ���� ���ε�
			pstmt.setString(1, boardType);  // ����������
			rs = pstmt.executeQuery();

			if(rs.next()){
				totalCount = rs.getInt("TOTAL");
			}

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return totalCount;

	 }
	 
    /**
     * ���� �����̸�(�Ϸù�ȣ) �������� 
     * @return rtnValue int �Ϸù�ȣ
     * @throws DbException
     * @throws Exception
     * @author ������
     */
    public String  getVirtualFileName() throws  DbException , Exception  { 
        
	    Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "";
        String subSql =" ";
        String tempPart = "";
        String rtnValue = "";

        
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT LPAD(VIRTUAL_FILE_NAME_SEQ.NEXTVAL, 10, '0') FROM DUAL ");

 
	    
       // System.out.println("getTotalCount  --  query  => \n"+sql);
       
		try{
	           pstmt = dbconn.prepareStatement(sql.toString());
	           
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()){
	                rtnValue = rs.getString(1);
	            }
	             
	            rs.close();
	            pstmt.close();
		} catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
         
        return rtnValue;
    }  
     

    /**
     * �Խù� ��õ Ƚ�� ���� 
     * @param board_seq  int ���� �Խ��� �Ϸù�ȣ
     * @return exe int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     */
    public int  updateRecomm(String user_id,int board_seq) throws  DbException , Exception  { 
        
	    Connection dbconn = getConnection();
	    dbconn.setAutoCommit(false);
        PreparedStatement pstmt = null;
        int exe = 0;
        
        StringBuffer sql = new StringBuffer();
        sql.append(" UPDATE asan.TBRD_BOARD_MA SET RECOMM_NUM = RECOMM_NUM+1 WHERE BOARD_SEQ = ?  ");

        //System.out.println("getTotalCount  --  query  => \n"+sql);
       
		try{
	           pstmt = dbconn.prepareStatement(sql.toString());
	           pstmt.setInt(1, board_seq);
	           exe = pstmt.executeUpdate();
	            
	           pstmt.close();
	           
	           exe = insertRecomm(dbconn , user_id,board_seq);
	           
	           if(exe<=0){
	        	   dbconn.rollback();
	           }else{
	        	   dbconn.commit();
	           }
	           
		} catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{ 
            release(pstmt);
            freeConnection(dbconn);
        }

        return exe;
    }  
    

    /**
     * �Խù� ��õ �α� ���̺�  �߰� 
     * @param board_seq  int ���� �Խ��� �Ϸù�ȣ
     * @return exe int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     */
    public int  insertRecomm(Connection dbconn, String user_id, int board_seq) throws  DbException , Exception  { 
        
	   
        PreparedStatement pstmt = null;
        int exe = 0;
        
        StringBuffer sql = new StringBuffer();
        sql.append(" INSERT INTO  asan.TBRD_RECOMMEND_HS  ");
        sql.append(" (USER_ID, BOARD_SEQ)  ");
        sql.append(" values (?, ? )  ");
        //System.out.println("getTotalCount  --  query  => \n"+sql);
        
		try{
	           pstmt = dbconn.prepareStatement(sql.toString());
	           pstmt.setString(1, user_id);
	           pstmt.setInt(2, board_seq);
	           exe = pstmt.executeUpdate();
	            
	           pstmt.close();

		} catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{ 
            release(pstmt);
        }

        return exe;
    }   
    

    /**
     * �Խù� �ڸ�Ʈ  Ƚ�� ���� 
     * @param board_seq  int ���� �Խ��� �Ϸù�ȣ
     * @return exe int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     */
    public int  updateCommentNum(Connection dbconn, int board_seq) throws  DbException , Exception  { 
        
        PreparedStatement pstmt = null;
        int exe = 0;
        
        StringBuffer sql = new StringBuffer();
        sql.append(" UPDATE asan.TBRD_BOARD_MA SET COMMENT_NUM = COMMENT_NUM+1 WHERE BOARD_SEQ = ?  ");

        //System.out.println("getTotalCount  --  query  => \n"+sql);
        System.out.println("UPDATE sql==========>"+sql);
		try{
	           pstmt = dbconn.prepareStatement(sql.toString());
	           pstmt.setInt(1, board_seq);
	           exe = pstmt.executeUpdate();
	            
	           pstmt.close();
		} catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{ 
            release(pstmt);
        }

        return exe;
    }  
    
    
    /**
     * �������� �Խñ� ���� ���� 
     * @param seqList String �Խñ� �Ϸù�ȣ��. ex) "45,23,12"
     * @return exe int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     */
    public  int deleteList(String seqList) 
        throws DbException , Exception 
    {
        //System.out.println("seqList => \n"+seqList);
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
       
        // SQL
        String sql = new StringBuffer()
           .append("DELETE FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ IN ("+seqList+") ").toString();
        int exe = 0;
        System.out.println("getTotalCount  --  query  => \n"+sql);
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // ���� ���ε�
            //pstmt.setString(1,seqList);
            exe = pstmt.executeUpdate();
            System.out.println("exe => \n"+exe);
            pstmt.close();
            dbconn.commit();
        } catch (SQLException e) {
            // Rollback
            rollback(dbconn);
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return exe ;
    }  
    

    /**
     * �Խù� ���� Ƚ�� ���� 
     * @param board_seq  int ���� �Խ��� �Ϸù�ȣ
     * @return exe int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     */
    public  int updateReadnum(int board_seq) 
        throws DbException , Exception 
    {
        // Get connection(auto commit false)            
        Connection dbconn = getConnection(false);
        PreparedStatement pstmt = null;
        
        // SQL
        String sql = new StringBuffer()
           .append(" UPDATE asan.TBRD_BOARD_MA set READ_NUM=READ_NUM+1 ")
           .append(" WHERE  BOARD_SEQ=?").toString();
        int exe = 0;
        try {
            pstmt = dbconn.prepareStatement(sql); 
            // ���� ���ε�            

            pstmt.setInt(1, board_seq);
            
            exe = pstmt.executeUpdate();
            pstmt.close();
            dbconn.commit();
        } catch (SQLException e) {
            // Rollback
            rollback(dbconn);
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return exe ;
    }
    
    
    
    /**
     * �ڷ��� �Խ�����  ���� �Խù��� ����,���� �Խù��� ���
     * @param board_seq  int ���� �Խ��� �Ϸù�ȣ
     * @return Tbrd_board_ma_bean[]
     * @throws DbException
     * @throws Exception
     */
    public Tbrd_board_ma_bean[] getPrevAndNextBoard(int board_seq ) 
    throws  DbException , Exception {
        //System.out.println("getList () requestedPage:"+requestedPage+"/rowsPerPage:"+rowsPerPage);
        //System.out.println("getList () part:"+part+"/keyword:"+keyword);
        
        
        Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Tbrd_board_ma_bean bean = null;
        Collection list = null; 
 
       //      SQL  
        StringBuffer sql = new StringBuffer();
        sql.append(" SELECT  'NOW' GUBUN, BOARD_SEQ , 					        \n");
		sql.append(" TITLE, CONTENT, READ_NUM, REG_DATE ,RECOMM_NUM				\n");
		sql.append(" FROM  asan.TBRD_BOARD_MA								    \n");
		sql.append(" WHERE BOARD_TYPE ='03' and BOARD_SEQ = ?			        \n");
		sql.append(" UNION ALL												    \n");
        sql.append(" SELECT 'NEXT' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,			\n");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				            \n");
		sql.append(" FROM asan.TBRD_BOARD_MA 								    \n");
		sql.append(" WHERE BOARD_SEQ = (			                            \n");
		sql.append("     SELECT  MIN(BOARD_SEQ) AS BOARD_SEQ			        \n");
		sql.append("     FROM asan.TBRD_BOARD_MA 			                    \n");
		sql.append("     WHERE BOARD_TYPE ='03' AND  BOARD_SEQ > ?		        \n");
		sql.append(" )	UNION ALL		                                        \n");	
        sql.append(" SELECT 'PREV' GUBUN, BOARD_SEQ ,TITLE , CONTENT ,			\n");
		sql.append(" READ_NUM ,REG_DATE , RECOMM_NUM 				            \n");
		sql.append(" FROM asan.TBRD_BOARD_MA 								    \n");
		sql.append(" WHERE BOARD_SEQ = (			                            \n");
		sql.append("     SELECT  MAX(BOARD_SEQ) AS BOARD_SEQ			        \n");
		sql.append("     FROM asan.TBRD_BOARD_MA 			                    \n");
		sql.append("     WHERE BOARD_TYPE ='03' AND  BOARD_SEQ < ?		        \n");
		sql.append(" )		                                                    \n");

        try {         
            pstmt = dbconn.prepareStatement(sql.toString());
            // ���� ���ε�
            pstmt.setInt(1, board_seq);  
            pstmt.setInt(2, board_seq);  
            pstmt.setInt(3, board_seq);  
           
            // ��� ���
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Tbrd_board_ma_bean());
           
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Tbrd_board_ma_bean [])list.toArray(new Tbrd_board_ma_bean[0]);

        
    }
    
    /**
     * ÷������ ���� ����
     * @param vir_name String ÷������ ���� �̸�
     * @return result int 1:���� , 0:����
     * @throws DbException
     * @throws Exception
     */
	 public int deleteAttachFile(String vir_name) throws DbException , Exception {
		Connection dbconn = getConnection();	
       PreparedStatement pstmt = null;
       ResultSet rs = null;        
       int result			= 0;
		
		StringBuffer sql = new StringBuffer();
		try { 

			sql.append(" DELETE FROM asan.TBRD_ATTACH_FILE_DE WHERE VIRTUAL_NAME=? ");	
			pstmt = dbconn.prepareStatement(sql.toString());
			pstmt.setString(1,vir_name);
			
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
       	e.printStackTrace();
           throw new DbException(e.getMessage());
       }finally{
           release(pstmt);
           freeConnection(dbconn);
       }
		return result;
	 }
	 
	  
	  /**
	     * ÷������ ���� �ʱ�ȭ 
	     * @param int attach_seq
	     * @return result int 1:���� , 0:����
	     * @throws DbException
	     * @throws Exception
	     */
		 public int resetAttachFile(int attach_seq) throws DbException , Exception {
			Connection dbconn = getConnection();	
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;        
	       int result			= 0;
			
			StringBuffer sql = new StringBuffer();
			try { 

				sql.append(" UPDATE  asan.TBRD_ATTACH_FILE_DE   ");	
				sql.append("  set VIRTUAL_NAME='' ,  REAL_NAME = '' ");
				sql.append("  WHERE ATTACH_FILE_SEQ=? ");	
				pstmt = dbconn.prepareStatement(sql.toString());
				pstmt.setInt(1,attach_seq);
				
				
				result = pstmt.executeUpdate();
			} catch (SQLException e) {
	       	e.printStackTrace();
	           throw new DbException(e.getMessage());
	       }finally{
	           release(pstmt);
	           freeConnection(dbconn);
	       }
			return result;
		 }
	  
	 /**
	     * �Խ����� ��ü �̹��� ���� 
	     * @param board_seq  
	     * @return Tbrd_board_ma_bean[]
	     * @throws DbException
	     * @throws Exception
	     * @author ������
	     */
		public Tbrd_attach_file_de_bean[]  getAttachFileList(int board_seq) throws  DbException , Exception  { 
	        
		    Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        Tbrd_attach_file_de_bean bean = null;
	        Collection list = null; 
	   
	       
	         
	        StringBuffer sql = new StringBuffer();
	        sql.append(" SELECT ATTACH_FILE_SEQ, REAL_NAME, VIRTUAL_NAME, BOARD_SEQ  from asan.TBRD_ATTACH_FILE_DE ");
	        sql.append(" WHERE BOARD_SEQ=? ");
 
	        try {         
	            pstmt = dbconn.prepareStatement(sql.toString());
	            // ���� ���ε�
	            pstmt.setInt(1, board_seq);  // ����������
	          
	            //System.out.println(" start :"+((requestedPage * rowsPerPage) - rowsPerPage) + 1 + "/end:"+requestedPage * rowsPerPage);
	            // ��� ���
	            rs = pstmt.executeQuery();
	            list = Selecter.execute(rs, new Tbrd_attach_file_de_bean());
	           
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return (Tbrd_attach_file_de_bean [])list.toArray(new Tbrd_attach_file_de_bean[0]);
	    }  
 

		 /**
	     *  TBRD_BOARD_MA �� �Խ��� ������  NEXT SEQ �� ���ϱ� 
	     * @param Connection dbconn  
	     * @param String board_type �Խ��� ����  
	     * @return int nextSeq �ִ밪+1
	     * @throws DbException
	     * @throws Exception
	     * @author ������
	     */ 
		public int getBoardMaNextSeq(Connection dbconn) 
	        throws DbException , Exception  
	    {
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String count = "0";
	        int nextSeq = 0;

	        String query = "SELECT MAX(BOARD_SEQ) count FROM asan.TBRD_BOARD_MA ";
	       
	        try {         
	            pstmt = dbconn.prepareStatement(query);
	            // ��� ���
	            rs = pstmt.executeQuery();
	            
	            
	            if(rs.next()){
	            	
	            	count = rs.getString(1);
	            	
	            	 if(count == null){
	            		
	            		 nextSeq = 1;
	                 }else{
	                	
	                	 nextSeq = Integer.parseInt(count);
	                 }
	            }else{	      
	            	
	            	nextSeq = 1;
	            }
	            
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	        }
	        return nextSeq+1;
	    } 
		
		/**
	     *  TBRD_COMMENT_DE   NEXT SEQ �� ���ϱ� 
	     * @param Connection dbconn  
	     * @param String board_type �Խ��� ����   
	     * @return int nextSeq �ִ밪+1
	     * @throws DbException
	     * @throws Exception
	     * @author ������
	     */
		public int getCommendDeNextSeq(Connection dbconn) 
	        throws DbException , Exception 
	    {
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String count = "0";
	        int nextSeq = 0;

	        String query = "SELECT MAX(COMMENT_SEQ) count FROM asan.TBRD_COMMENT_DE ";
	         
	        try {         
	            pstmt = dbconn.prepareStatement(query);
	            // ��� ���
	            rs = pstmt.executeQuery();
	            if(rs.next()){
	            	count = rs.getString(1);
	            	 if(count == null){
	            		 nextSeq = 1;
	                 }else{
	                	 nextSeq = Integer.parseInt(count);
	                 }
	            }else{	      
	            	
	            	nextSeq = 1;
	            }
	            
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	        }
	        return nextSeq+1;
	    } 
		
		/**
	     *  TBRD_ATTACH_FILE_DE   NEXT SEQ �� ���ϱ� 
	     * @param Connection dbconn  
	     * @param String board_type �Խ��� ����   
	     * @return int result �ִ밪+1
	     * @throws DbException
	     * @throws Exception
	     * @author ������
	     */
		public int getAttachFileNextSeq(Connection dbconn) 
	        throws DbException , Exception 
	    {
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String count = "0";
	        int nextSeq = 0;

	        String query = "SELECT MAX(ATTACH_FILE_SEQ) count FROM asan.TBRD_ATTACH_FILE_DE ";
	         
	        try {         
	            pstmt = dbconn.prepareStatement(query);
	            // ��� ���
	            rs = pstmt.executeQuery();
	            if(rs.next()){
	            	count = rs.getString(1);
	            	 if(count == null){
	            		 nextSeq = 1;
	                 }else{
	                	 nextSeq = Integer.parseInt(count);
	                 }
	            }else{	      
	            	
	            	nextSeq = 1;
	            }
	            
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	        }
	        return nextSeq+1;
	    } 
		
		

	    /**
	     * �������� �߼�
	     */
		
   
		/**
	     * ���� �߼� 
	     * @param String title ���� ����   
	     * @param StringBuffer bodyContent ���� ���� 
	     * @param StringBuffer senderMail ������ ��� �̸��� 
	     * @param StringBuffer senderName ������ ��� �̸� 
	     * @param StringBuffer receiverMail �޴� ��� �̸��� 
	     * @param StringBuffer receiverName �޴� ��� �̸�  
	     * @return int result ���� �߼� Ƚ�� 
	     * @author ������
	     */
	    public int SendMail(String title, StringBuffer bodyContent, String senderMail, String senderName,
	    		  String receiverMail ,String receiverName) {
	    	
	    	int result = 0;

	        try {
	            senderName = Util.getString(senderName,"����ƻ�");
	            senderMail = Util.getString(senderMail,"webmaster@hmm21.com");
	            receiverName = Util.getString(receiverName, "�׽���");
	            receiverMail = Util.getString(receiverMail, "");
	            title = Util.getString(title, "����ƻ� ���� ���� �Դϴ�.");

	            Properties props = System.getProperties();
	            props.put("mail.smtp.host", "localhost");

	            Session ss = Session.getDefaultInstance(props, null);
	            System.out.println("Session==>"+ss);
	            Message msg = new MimeMessage(ss);
                     
	            System.out.println("msg==>"+msg);

	            msg.setFrom(new InternetAddress(senderMail, senderName));
	            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(receiverMail, false));

	            msg.setSubject(title);
	            msg.setText(bodyContent.toString());
	            msg.setHeader("Content-Type", "text/html;charset=EUC-KR");
	            msg.setSentDate(new java.util.Date());
	                
	            System.out.println("msg.setSentDate==>2");
	            try {
	                    Transport.send(msg);
	                    System.out.println("msg ==> ok");
	                    result ++;
	            } catch ( Exception e1) {
	                System.out.println("msg ==> false");
	                System.out.println(e1.getMessage());
	                e1.printStackTrace();
	            }
 
	        } catch (Exception e){
	            System.out.println(e.getMessage());
	            e.printStackTrace();
	        }
	        
	        return result;
	    }

		/**
	     * QnA �亯 ���� �߼� 
	     * @param HttpServletRequest request 
	     * @param HttpServletResponse response 
	     * @author ������
	     */
	    public void SendMailQnA(HttpServletRequest request, HttpServletResponse response) {
	    	
	        int yes = 0;
	        int no = 0;

	        int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 1);
	        String name    = Util.getString(request.getParameter("name"),"����ƻ�");
	        String from    = Util.getString(request.getParameter("from"),"asan@hmm21.com");
	        String to_name    = Util.getString(request.getParameter("user_name"),"");
	        String to_email    = Util.getString(request.getParameter("email"),"");
	        String mailTitle    = Util.getString(request.getParameter("mailTitle"),"����ƻ� ���� ���� �Դϴ�.");
            
	        System.out.println("board_seq===>"+board_seq);
	        System.out.println("to_name===>"+to_name);
	        System.out.println("to_email===>"+to_email);
	        try {
                // ���� ���� ���� 
	        	String contentsub = 
	        			"asanway/tour/tour_question_mailsend.jsp?board_seq="+board_seq;
	            String rootServer = Config.getInstance().getProperty("imjkmd","rootServer");
	        	StringBuffer bodyContent = new StringBuffer().append(HTTPUtil.getHtml(rootServer+contentsub));
	        	//System.out.println("bodyContent==>"+bodyContent);
	            Properties props = System.getProperties();
	            props.put("mail.smtp.host", "localhost");

	            Session ss = Session.getDefaultInstance(props, null);
	            System.out.println("Session==>"+ss);
	            Message msg = new MimeMessage(ss);
                     
	            System.out.println("msg==>"+msg);
	            msg.setFrom(new InternetAddress(from, name));
	            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to_email, false));

	            msg.setSubject(mailTitle);
	            msg.setText(bodyContent.toString());
	            msg.setHeader("Content-Type", "text/html;charset=EUC-KR");
	            msg.setSentDate(new java.util.Date());
	            
	            //System.out.println("msg.setSentDate================>2");
	            try {
	                Transport.send(msg);
	                //System.out.println("msg ========================> ok");
	                ++yes;
	            } catch ( Exception e1) {
	             	 //System.out.println("msg ==================> false");
	                 ++no;
	                 //System.out.println(e1.getMessage());
	                 e1.printStackTrace();
	            }
 
	              
	            request.setAttribute("yes", String.valueOf(yes));
	            request.setAttribute("no", String.valueOf(no));
	            request.setAttribute("content", bodyContent.toString());


	        } catch (Exception e){
	            System.out.println(e.getMessage());
	            e.printStackTrace();
	        }
	    }
	    
	    
	    
	    /**
	     *  �Խ����� PASSWORD �� ��ġ�ϴ� �˾ƺ���.
	     * @param int board_seq �Խ��� seq
	     * @param String password �˻��غ� ��й�ȣ 
	     * @return boolean 
	     * @throws DbException
	     * @throws Exception
	     * @author ������
	     */
		public boolean getPasswordYn(int board_seq, String password) 
	        throws DbException , Exception 
	    {
			Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String oriPassword = "";
	        boolean result = false;

	        String query = "SELECT PASSWORD  FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ ="+board_seq;
	         
	        try {         
	            pstmt = dbconn.prepareStatement(query);
	            // ��� ���
	            rs = pstmt.executeQuery();
	            if(rs.next()){
	            	oriPassword = rs.getString(1);
	            	 if(oriPassword != null){
	            		 if(oriPassword.equals(password)) result = true;
	                 }else{
	                 }
	            }else{	      
	            }
	            
	            rs.close();
	            pstmt.close();
	        } catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	        return result;
	    } 

		
	    /**
	     *  �Խñ� ���� ����  ���� 
	     * @param board_seq ���� �Խ��� �Ϸù�ȣ
	     * @return exe int 1:���� , 0:����
	     * @throws DbException
	     * @throws Exception
	     */
	 public int deleteComplete(int board_seq) throws DbException , Exception {
		Connection dbconn = getConnection();	
     PreparedStatement pstmt = null;
     ResultSet rs = null;        
     int result  = 0;

		StringBuffer sql = new StringBuffer();

		try { 
			sql = new StringBuffer();
			sql.append(" DELETE FROM asan.TBRD_BOARD_MA WHERE BOARD_SEQ=?			");
			
			pstmt = dbconn.prepareStatement(sql.toString());
			pstmt.setInt(1,board_seq);
			
			
			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (SQLException e) {
     	    e.printStackTrace();
         throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
     return result;

	 }
	 
	 
	   /**
	     * �Խ��� �Ϸù�ȣ(board_seq) �� ����� ID(user_id) �� �̿��ؼ� ��õ �ߴ��� �˾� ���� 
	     * @paramr int board_seq  �Ϸù�ȣ
	     * @paramr String user_id  
	     * @return boolean
	     * @throws DbException
	     * @throws Exception
	     * @author ������
	     */
	    public boolean  doneRecomm(String user_id, int board_seq) throws  DbException , Exception  { 
	    	Connection dbconn = getConnection();
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        int count = 0;

	        
	        StringBuffer sql = new StringBuffer();
	        sql.append(" SELECT count(*) count FROM asan.TBRD_RECOMMEND_HS  ");
	        sql.append(" WHERE BOARD_SEQ=? AND USER_ID=? ");

	 
		    
	       // System.out.println("getTotalCount  --  query  => \n"+sql);
	       
			try{
		           pstmt = dbconn.prepareStatement(sql.toString());
		           pstmt.setInt(1,board_seq);
		           pstmt.setString(2,user_id);
		            rs = pstmt.executeQuery();
		            
		            while(rs.next()){
		            	count = rs.getInt(1);
		            }
		             
		            rs.close();
		            pstmt.close();
			} catch (SQLException e) {
	            throw new DbException(e.getMessage());
	        }finally{
	            release(pstmt);
	            freeConnection(dbconn);
	        }
	         
	        return count>0;
	    }  
}
