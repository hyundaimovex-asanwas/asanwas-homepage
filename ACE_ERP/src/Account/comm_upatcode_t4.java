package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class comm_upatcode_t4 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				/*****************************************************************
         		 �������� : 2010.04.16
				 �������� : 1. ����, �ݰ��� ������ ��� ���̿� ��
				                        �����̿������׿����� �����͸� ������������ ������.
							GENENLED, TOTALBAL, MTOTALBAL
							�����׸��� �������� �ʴ´�.
                         2. ���̿��� ��ü ���̿��� ����.
							�� �������� ���̿��� �ؾ���. 
         	         �� �� �� : JYS
         	     ---------------------------------------------------------------   
         	         �������� : 2013.11.28
				 �������� : 1. DB2->ORACLE 
				                  �μ�,���� NULL ���� ���� ������ ó����.            
         	         �� �� �� : JYS    
         	     ---------------------------------------------------------------   
         	         �������� : 2015.02.06
				 �������� : ���̿� �������� �⺻������ MTOTALBAL�� TOTALBAL���� ����������, 
				                  �ݰ��� ��ȭ�� ���� MTOTALBAL���� �����ͼ� UPDATE.  				                           
         	         �� �� �� : JYS       
				******************************************************************/

				String strYYMM = reqGauce.getParameter("v_str1");     //���س��
				String strFDCODE = reqGauce.getParameter("v_str2");   //����
		        String strFDCODE1 = strFDCODE;
				
		        int YY = Integer.parseInt(strYYMM.substring(0,4));
		        int yy1 = YY-1;
		        
		        String curYYMMDD   = YY +"0100";
		        String curYYMM     = YY +"00";
		        String befsYYMMDD  = yy1+"0100";
		        String befeYYMMDD  = yy1+"1231";
		        String befsYYMM    = yy1+"01";
		        String befeYYMM    = yy1+"12";

				String strAtcode ="";
				String strDivcd  ="";
				String strDeptcd ="";       
				
				/*�Ѱ������� �ͳ��ڷ� ����*/
				String  sql001 = " DELETE FROM ACCOUNT.GENENLED "
									  	 + "  WHERE FDCODE = '"+strFDCODE+"' "
									  	 + "    AND ACTDAT = '"+curYYMMDD+"'  ";
				
				GauceStatement gsmt001 = conn.getGauceStatement(sql001);
				gsmt001.executeUpdate();
				gsmt001.close();

				/*�Ѱ������� �ͳ��ڷ� ����*/
		        String  sql002 = "\n INSERT INTO ACCOUNT.GENENLED                                                                                            "
		                       + "\n             (FDCODE,ACTDAT,ATCODE,COCODE,FSDAT,FSNBR,FSSEQ,DEAMT,CRAMT,DECASH,                                          "
		                       + "\n              CRCASH,EDECASH,ECRCASH,SSDAT,SSNBR,FODEAMT,FOCRAMT,FODECASH,FOCRCASH,FOEDECASH,                            "
		                       + "\n              FOECRCASH,EXRATE,EXRATEDT,EXRATEGB)                                                                        "
		                       + "\n SELECT A.FDCODE,	/*�����*/                                                                                             "
		                       + "\n        '"+curYYMMDD+"',                                                                                                 "
		                       + "\n        A.ATCODE,                                                                                                        "
		                       + "\n        A.COCODE,	/*�����*/                                                                                             "
		                       + "\n        'A'||'"+curYYMMDD+"',                                                                                            "
		                       + "\n        '000001',                                                                                                        "
		                       + "\n        '00001',                                                                                                         "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DEAMT - A.CRAMT ELSE 0 END END),0),         "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRAMT - A.DEAMT END END),0),         "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DECASH - A.CRCASH ELSE 0 END END),0),       "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRCASH - A.DECASH END END),0),       "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.EDECASH - A.ECRCASH ELSE 0 END END),0),     "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.ECRCASH - A.EDECASH END END),0),     "
		                       + "\n        '',                                                                                                              "
		                       + "\n        '',                                                                                                              "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODEAMT - A.FOCRAMT ELSE 0 END END),0),     "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRAMT - A.FODEAMT END END),0),     "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODECASH - A.FOCRCASH ELSE 0 END END),0),   "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRCASH - A.FODECASH END END),0),   "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FOEDECASH - A.FOECRCASH ELSE 0 END END),0), "
		                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOECRCASH - A.FOEDECASH END END),0), "
		                       + "\n        0,                                                                                                               "
		                       + "\n        '',                                                                                                              "
		                       + "\n        ''                                                                                                               "
		                       + "\n   FROM ACCOUNT.GENENLED A, ACCOUNT.ACTCODE B                                                                            "
		                       + "\n  WHERE A.FDCODE = '"+strFDCODE+"'	/*�����*/                                                                           "
		                       + "\n    AND A.ATCODE = B.ATCODE                                                                                              "
		                       + "\n    AND A.ACTDAT >= '"+befsYYMMDD+"'                                                                                     "
		                       + "\n    AND A.ACTDAT <= '"+befeYYMMDD+"'                                                                                     "
		                       + "\n    AND A.ATCODE >= '1000000'                                                                                            "
		                       + "\n    AND A.ATCODE <= '3999999'                                                                                            "
		                       + "\n    AND A.ATCODE NOT IN ('3302210' , '3302200' , '3302220','1110690','3302240')    /* �̼�������� �߰�*/                       "
		                       + "\n GROUP BY A.FDCODE,A.ATCODE,A.COCODE                                                                                              ";
			
		        GauceStatement gsmt002 = conn.getGauceStatement(sql002);
				gsmt002.executeUpdate();
				gsmt002.close();

		        /**************************************************
		                 ����, �ݰ����� ��� 
				 �����̿������׿����� ������������ �ѱ�.
				 ( 3302210 ==> 1240000 ) 
				**************************************************/
		        if(strFDCODE.equals("03")||strFDCODE.equals("04")){
		
				    String  sql003 = "\n INSERT INTO ACCOUNT.GENENLED                                                                                               "
		                           + "\n (FDCODE,ACTDAT,ATCODE,COCODE,FSDAT,FSNBR,FSSEQ,DEAMT,CRAMT,DECASH,                                                         "
		                           + "\n  CRCASH,EDECASH,ECRCASH,SSDAT,SSNBR,FODEAMT,FOCRAMT,FODECASH,FOCRCASH,FOEDECASH,                                           "
		                           + "\n  FOECRCASH,EXRATE,EXRATEDT,EXRATEGB)                                                                                       "
								   + "\n SELECT X.FDCODE ,'"+curYYMMDD+"','1240000','02', 'A'||'"+curYYMMDD+"','000002','00001', 0, SUM(X.CRAMT) - SUM(X.DRAMT),0,  "
		                           + "\n        0,0,0,'','',0,0,0,0,0,0,0,'',''                                                                                     "
		                           + "\n FROM(                                                                                                                      "
		                           + "\n SELECT FDCODE,                                                                                                             "
		                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0)AS DRAMT,  "
		                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0)AS CRAMT   "
		                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
		                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
		                           + "\n    AND A.FDCODE ='"+strFDCODE+"'                                                                                           "
		                           + "\n    AND A.ACTDAT >='"+befsYYMMDD+"'                                                                                         "
		                           + "\n    AND A.ACTDAT <='"+befeYYMMDD+"'                                                                                         "
		                           + "\n    AND A.ATCODE  IN ('4300000','4400000','4520000','4540000','4550000')                                                    "
		                           + "\n    GROUP BY A.FDCODE                                                                                                       "
		                           + "\n UNION ALL                                                                                                                  "
		                           + "\n SELECT FDCODE,                                                                                                             "
		                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0) AS DRAMT, "
		                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0) AS CRAMT  "
		                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
		                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
		                           + "\n    AND A.FDCODE ='"+strFDCODE+"'                                                                                           "
		                           + "\n    AND A.ACTDAT >= '"+befsYYMMDD+"'                                                                                        "
		                           + "\n    AND A.ACTDAT <= '"+befeYYMMDD+"'                                                                                        "
		                           + "\n    AND A.ATCODE  IN ('4100000','4510000','4530000','3302210','3302240')                                                    "
		                           + "\n    GROUP BY A.FDCODE                                                                                                       "
		                           + "\n       )X                                                                                                                   "
		                           + "\n GROUP BY FDCODE                                                                                                            ";
		          GauceStatement gsmt003 = conn.getGauceStatement(sql003);
		          gsmt003.executeUpdate();
				}

				/*���հ��ܾ� �ͳ��ڷ� ����*/
		        String  sql004 = "\n DELETE FROM ACCOUNT.TOTALBAL      " 
		                       + "\n  WHERE FDCODE = '"+strFDCODE+"'   " 
		                       + "\n    AND ACTDAT = '"+curYYMMDD+"' ";
				GauceStatement gsmt004 = conn.getGauceStatement(sql004);
				gsmt004.executeUpdate();
				gsmt004.close();
				/*���հ��ܾ� �ͳ��ڷ� ����*/
		        String  sql005 = "\n DELETE FROM ACCOUNT.MTOTALBAL    " 
		                       + "\n  WHERE FDCODE = '"+strFDCODE+"'  " 
		                       + "\n    AND ACTYYMM = '"+curYYMM+"' ";
				GauceStatement gsmt005 = conn.getGauceStatement(sql005);
				gsmt005.executeUpdate();
				gsmt005.close();
				/*���հ��ܾ� �ͳ��ڷ� ����*/
		        String  sql006 =  "\n INSERT INTO ACCOUNT.TOTALBAL                                                                                                " 
		                       +  "\n             (FDCODE,ACTDAT,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT,DECASH,CRCASH,                                           " 
		                       +  "\n              EDECASH,ECRCASH,DEUPTOT,CRUPTOT,DEUPCASH,CRUPCASH,FODETOT,FOCRTOT,FODECASH,FOCRCASH,                           " 
		                       +  "\n              FOEDECASH,FOECRCASH,FODEUPTOT,FOCRUPTOT,FODEUPCASH,FOCRUPCASH,EXRATE,EXRATEDT,EXRATEGB)                        " 
		                       +  "\n SELECT A.FDCODE,	/*�����*/                                                                                                  " 
		                       +  "\n        '"+curYYMMDD+"',                                                                                                     " 
		                       +  "\n        A.ATCODE,                                                                                                            " 
		                       +  "\n        A.COCODE,		/*�����*/                                                                                                " 
		                       +  "\n        ACCOUNT.FN_DIVCD_FIND(NVL(RTRIM(A.DEPTCD),'9999')),                                                        "
		                       +  "\n        NVL(RTRIM(A.DEPTCD),'9999'),                                                                               " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0),             " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0),             " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DECASH - A.CRCASH ELSE 0 END END),0),           " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRCASH - A.DECASH END END),0),           " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.EDECASH - A.ECRCASH ELSE 0 END END),0),         " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.ECRCASH - A.EDECASH END END),0),         " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DEUPTOT - A.CRUPTOT ELSE 0 END END),0),         " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRUPTOT - A.DEUPTOT END END),0),         " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DEUPCASH - A.CRUPCASH ELSE 0 END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRUPCASH - A.DEUPCASH END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODETOT - A.FOCRTOT ELSE 0 END END),0),         " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRTOT - A.FODETOT END END),0),         " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODECASH - A.FOCRCASH ELSE 0 END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRCASH - A.FODECASH END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FOEDECASH - A.FOECRCASH ELSE 0 END END),0),     " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOECRCASH - A.FOEDECASH END END),0),     " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODEUPTOT - A.FOCRUPTOT ELSE 0 END END),0),     " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRUPTOT - A.FODEUPTOT END END),0),     " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODEUPCASH - A.FOCRUPCASH ELSE 0 END END),0),   " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRUPCASH - A.FODEUPCASH END END),0),   " 
		                       +  "\n        0,                                                                                                                   " 
		                       +  "\n        '',                                                                                                                  " 
		                       +  "\n        ''                                                                                                                   " 
		                       +  "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                                " 
		                       +  "\n  WHERE A.FDCODE = '"+strFDCODE+"'	/*�����*/                                                                                " 
		                       +  "\n    AND A.ATCODE = B.ATCODE                                                                                                  " 
		                       +  "\n    AND A.ACTDAT >= '"+befsYYMMDD+"'                                                                                         " 
		                       +  "\n    AND A.ACTDAT <= '"+befeYYMMDD+"'                                                                                         " 
		                       +  "\n    AND A.ATCODE >= '1000000'                                                                                                " 
		                       +  "\n    AND A.ATCODE <= '3999999'                                                                                                " 
		                       +  "\n    AND A.ATCODE NOT IN ('3302210' , '3302200' , '3302220','1110690','3302240')                                                                                " 
		                       +  "\n GROUP BY A.FDCODE,A.ATCODE,A.COCODE,A.DEPTCD                                                                                         ";
					
		            GauceStatement gsmt006 = conn.getGauceStatement(sql006);
					gsmt006.executeUpdate();
					gsmt006.close();
				
		/*���հ��ܾ� ���⸻��ó�������׿��� �ͳ��ڷ� ����*/
		/*2009.03.07 �����̿������׿��ݿ� 3302240 ��������(���ս�) ����. - ����, �ݰ��꿡 ������ ��ǥ�� ���������ϹǷ� */
        /*****
				 2010.04.16 ����
        if(strFDCODE.equals("%")){
          String  sql007_2 = "\n INSERT INTO ACCOUNT.TOTALBAL                                                                                               "
                           + "\n              (FDCODE,ACTDAT,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)                                                         "
                           + "\n SELECT '02' ,'"+curYYMMDD+"','3302210',X.FDCODE , '', '2930', 0,                                                       "
                           + "\n        SUM(X.CRAMT) - SUM(X.DRAMT)                                                                                         "
                           + "\n FROM(                                                                                                                      "
                           + "\n SELECT FDCODE,                                                                                                             "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0)AS DRAMT,  "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0)AS CRAMT   "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '02%'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4300000','4400000','4520000','4540000','4550000')                                                    "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n UNION ALL                                                                                                                  "
                           + "\n SELECT FDCODE,                                                                                                               "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0) AS DRAMT, "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0) AS CRAMT  "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '02%'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4100000','4510000','4530000','3302210','3302240')                                                                    "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n       )X                                                                                                                   "
                           + "\n GROUP BY FDCODE                                                                                                            ";
          GauceStatement gsmt007_2 = conn.getGauceStatement(sql007_2);
          gsmt007_2.executeUpdate();
          gsmt007_2.close();

          String  sql007_3 = "\n INSERT INTO ACCOUNT.TOTALBAL                                                                                               "
                           + "\n              (FDCODE,ACTDAT,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)                                                         "
                           + "\n SELECT '03' ,'"+curYYMMDD+"','3302210',X.FDCODE , '', '2930', 0,                                                       "
                           + "\n        SUM(X.CRAMT) - SUM(X.DRAMT)                                                                                         "
                           + "\n FROM(                                                                                                                      "
                           + "\n SELECT FDCODE,                                                                                                             "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0)AS DRAMT,  "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0)AS CRAMT   "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '03%'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4300000','4400000','4520000','4540000','4550000')                                                    "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n UNION ALL                                                                                                                  "
                           + "\n SELECT FDCODE,                                                                                                                "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0) AS DRAMT, "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0) AS CRAMT  "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '03%'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4100000','4510000','4530000','3302210','3302240')                                                                   "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n       )X                                                                                                                   "
                           + "\n GROUP BY FDCODE                                                                                                            ";
          GauceStatement gsmt007_3 = conn.getGauceStatement(sql007_3);
          gsmt007_3.executeUpdate();
          gsmt007_3.close();
        }else{
          String  sql007_2 = "\n INSERT INTO ACCOUNT.TOTALBAL                                                                                               "
                           + "\n              (FDCODE,ACTDAT,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)                                                         "
                           + "\n SELECT X.FDCODE ,'"+curYYMMDD+"','3302210',X.FDCODE , '', '2930', 0,                                                       "
                           + "\n        SUM(X.CRAMT) - SUM(X.DRAMT)                                                                                         "
                           + "\n FROM(                                                                                                                      "
                           + "\n SELECT FDCODE,                                                                                                             "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0)AS DRAMT,  "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0)AS CRAMT   "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '"+strFDCODE+"'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4300000','4400000','4520000','4540000','4550000')                                                    "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n UNION ALL                                                                                                                  "
                           + "\n SELECT '"+strFDCODE1+"' FDCODE,                                                                                                                "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0) AS DRAMT, "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0) AS CRAMT  "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '"+strFDCODE+"'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4100000','4510000','4530000','3302210','3302240')                                                                      "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n       )X                                                                                                                   "
                           + "\n GROUP BY FDCODE                                                                                                            ";
          GauceStatement gsmt007_2 = conn.getGauceStatement(sql007_2);
          gsmt007_2.executeUpdate();
          gsmt007_2.close();
        }

        *****/

			if(strFDCODE.equals("02")){//�����ϰ��
				strAtcode="3302210";
		        strDivcd ="XXXX";
		        strDeptcd="2930";
			}else{                     //�ݰ���, ���� ������ �ΰ��
				strAtcode="1240000";
				if(strFDCODE.equals("03")){
		          strDivcd ="F000";
		          strDeptcd="0000";
				}else if(strFDCODE.equals("04")){
				  strDivcd ="J000";
				  strDeptcd="0000";     
				}
			}

			 	String  sql007_2 = "\n INSERT INTO ACCOUNT.TOTALBAL                                                                                                "
								 + "\n              (FDCODE,ACTDAT,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)                                                       "
								 + "\n SELECT X.FDCODE ,'"+curYYMMDD+"','"+strAtcode+"','02','"+strDivcd+"','"+strDeptcd+"', 0, SUM(X.CRAMT) - SUM(X.DRAMT)       "
								 + "\n FROM(                                                                                                                      "
								 + "\n SELECT A.FDCODE,                                                                                                           "
								 + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0)AS DRAMT,  "
								 + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0)AS CRAMT   "
								 + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
								 + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
								 + "\n    AND A.FDCODE = '"+strFDCODE+"'                                                                                          "
								 + "\n    AND A.ACTDAT >= '"+befsYYMMDD+"'                                                                                        "
								 + "\n    AND A.ACTDAT <= '"+befeYYMMDD+"'                                                                                        "
								 + "\n    AND A.ATCODE  IN ('4300000','4400000','4520000','4540000','4550000')                                                    "
								 + "\n    GROUP BY A.FDCODE                                                                                                       "
								 + "\n UNION ALL                                                                                                                  "
								 + "\n SELECT A.FDCODE,                                                                                                           "
								 + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0) AS DRAMT, "
								 + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0) AS CRAMT  "
								 + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
								 + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
								 + "\n    AND A.FDCODE = '"+strFDCODE+"'                                                                                          "
								 + "\n    AND A.ACTDAT >= '"+befsYYMMDD+"'                                                                                        "
								 + "\n    AND A.ACTDAT <= '"+befeYYMMDD+"'                                                                                        "
								 + "\n    AND A.ATCODE  IN ('4100000','4510000','4530000','3302210','3302240')                                                    "
								 + "\n    GROUP BY A.FDCODE                                                                                                       "
								 + "\n       )X                                                                                                                   "
								 + "\n GROUP BY FDCODE                                                                                                            ";
				
			 	GauceStatement gsmt007_2 = conn.getGauceStatement(sql007_2);
				gsmt007_2.executeUpdate();
				gsmt007_2.close();


				/*���հ��ܾ� �ͳ��ڷ� ����*/
		        String  sql008 =  "\n INSERT INTO ACCOUNT.MTOTALBAL                                                                                               " 
		                       +  "\n             (FDCODE,ACTYYMM,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT,DECASH,CRCASH,                                          " 
		                       +  "\n              EDECASH,ECRCASH,DEUPTOT,CRUPTOT,DEUPCASH,CRUPCASH,FODETOT,FOCRTOT,FODECASH,FOCRCASH,                           " 
		                       +  "\n              FOEDECASH,FOECRCASH,FODEUPTOT,FOCRUPTOT,FODEUPCASH,FOCRUPCASH,EXRATE,EXRATEDT,EXRATEGB)                        " 
		                       +  "\n SELECT A.FDCODE,	/*�����*/                                                                                                " 
		                       +  "\n        '"+curYYMM+"',                                                                                                       " 
		                       +  "\n        A.ATCODE,                                                                                                            " 
		                       +  "\n        A.COCODE,		/*�����*/                                                                                              " 
		                       +  "\n        ACCOUNT.FN_DIVCD_FIND(NVL(RTRIM(A.DEPTCD),'9999')),                                                        " 
		                       +  "\n        NVL(RTRIM(A.DEPTCD),'9999'),                                                                          " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0),           " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0),           " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DECASH - A.CRCASH ELSE 0 END END),0),         " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRCASH - A.DECASH END END),0),         " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.EDECASH - A.ECRCASH ELSE 0 END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.ECRCASH - A.EDECASH END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DEUPTOT - A.CRUPTOT ELSE 0 END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRUPTOT - A.DEUPTOT END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DEUPCASH - A.CRUPCASH ELSE 0 END END),0),     " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRUPCASH - A.DEUPCASH END END),0),     " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODETOT - A.FOCRTOT ELSE 0 END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRTOT - A.FODETOT END END),0),       " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODECASH - A.FOCRCASH ELSE 0 END END),0),     " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRCASH - A.FODECASH END END),0),     " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FOEDECASH - A.FOECRCASH ELSE 0 END END),0),   " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOECRCASH - A.FOEDECASH END END),0),   " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODEUPTOT - A.FOCRUPTOT ELSE 0 END END),0),   " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRUPTOT - A.FODEUPTOT END END),0),   " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODEUPCASH - A.FOCRUPCASH ELSE 0 END END),0), " 
		                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRUPCASH - A.FODEUPCASH END END),0), " 
		                       +  "\n        0,                                                                                                                 " 
		                       +  "\n        '',                                                                                                                " 
		                       +  "\n        ''                                                                                                                 " 
		                       +  "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                              " 
		                       +  "\n  WHERE A.FDCODE = '"+strFDCODE+"'	/*�����*/                                                                              " 
		                       +  "\n    AND A.ATCODE = B.ATCODE                                                                                                " 
		                       +  "\n    AND A.ACTDAT >= '"+befsYYMMDD+"'                                                                                       " 
		                       +  "\n    AND A.ACTDAT <= '"+befeYYMMDD+"'                                                                                       "
		                       +  "\n    AND A.ATCODE >= '1000000'                                                                                              " 
		                       +  "\n    AND A.ATCODE <= '3999999'                                                                                              " 
		                       +  "\n    AND A.ATCODE NOT IN ('3302210' , '3302200' , '3302220' ,'1110690','3302240')                                           " 
		                       +  "\n GROUP BY A.FDCODE,A.ATCODE,A.COCODE,A.DEPTCD                                                                              " ;
		            GauceStatement gsmt008 = conn.getGauceStatement(sql008);
					gsmt008.executeUpdate();
					gsmt008.close();
					
					//2015.02.05 JYS////////////////////////////////////////////////// 
					//������ ȯ�� �� ���̿� �����Ϳ� ���� �ݾ� �������� 
					//���⵵�� 00���� ������, ���س⵵ ��ǥ�� ���� ���� ���⵵ 00 �ݾ��� �����;���.
					//�ݰ��� ��ȭ�� ���   MTOTALBAL--> MTOTALBAL���� �������� 
					//////////////////////////////////////////////////////////////////
					//System.out.println("strFDCODE : " + strFDCODE);	
					
					if(strFDCODE.equals("03")){
						
						Statement stmt00 = conn.createStatement(); 
						StringBuffer sql00 = new StringBuffer();
						StringBuffer sql01 = null;
						GauceStatement gsmt01 = null;
						
						//sql00.append( " SELECT A.FDCODE,  A.ATCODE, A.COCODE, A.DIVCD, A.DEPTCD,                                                            \n");
						//sql00.append( " SELECT A.FDCODE,  A.ATCODE, A.COCODE,  CASE WHEN TRIM(A.DIVCD) IS NULL THEN ACCOUNT.FN_DIVCD_FIND(NVL(RTRIM(A.DIVCD),'9999')) ELSE A.DIVCD END DIVCD,  A.DEPTCD,                                                            \n");
						//sql00.append( " SELECT A.FDCODE,  A.ATCODE, A.COCODE,  CASE WHEN A.DEPTCD ='F000' THEN 'K000' ELSE A.DIVCD END DIVCD,  A.DEPTCD,              \n");
						sql00.append( " SELECT A.FDCODE,  A.ATCODE, A.COCODE,  A.DEPTCD,                                                            \n");
						sql00.append( "        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODETOT - A.FOCRTOT ELSE 0 END END),0) FODETOT, \n");
						sql00.append( "        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRTOT - A.FODETOT END END),0) FOCRTOT  \n");
						sql00.append( "   FROM ACCOUNT.MTOTALBAL A, ACCOUNT.ACTCODE B                                                                                 \n");
						sql00.append( "  WHERE A.FDCODE ='03'                                                                                                         \n");
						sql00.append( "    AND A.ACTYYMM LIKE '"+yy1+"%'                                                                                                 \n");
						sql00.append( "    AND (A.EXRATEGB = '9' AND A.ATCODE <>'1240000')                                                                            \n");
						sql00.append( "    AND A.ATCODE =B.ATCODE                                                                                                     \n");
						//sql00.append( "    AND A.ATCODE ='1220290'                                                                                                     \n");
						sql00.append( "  GROUP BY A.FDCODE,  A.ATCODE, A.COCODE,  A.DEPTCD                                                          \n");

						//System.out.println("sql00::"+sql00.toString());
						ResultSet rs00 = stmt00.executeQuery(sql00.toString()); 
				
						while(rs00.next()){
					
							sql01 = null;
							gsmt01 = null;
							
							sql01 = new StringBuffer();
							sql01.append( " UPDATE ACCOUNT.MTOTALBAL SET  " );
							sql01.append( "        FODETOT = "+rs00.getDouble("FODETOT")+"," );
							sql01.append( "        FOCRTOT = "+rs00.getDouble("FOCRTOT")+"" );
							sql01.append( "  WHERE FDCODE = '03' " );
							sql01.append( "    AND ACTYYMM = '"+curYYMM+"'"  );
							sql01.append( "    AND ATCODE = '"+rs00.getString("ATCODE")+"'"  );
							sql01.append( "    AND COCODE = '"+rs00.getString("COCODE")+"'"  );
							sql01.append( "    AND DEPTCD = '"+rs00.getString("DEPTCD")+"'"  );
						          
							//System.out.println("sql01::"+sql01.toString());
							gsmt01 = conn.getGauceStatement(sql01.toString());
							gsmt01.executeUpdate();
							gsmt01.close();
						
						}
						rs00.close();
						stmt00.close(); 
					}
					
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
					
					
					
 
		/*���հ��ܾ� ���⸻��ó�������׿��� �ͳ��ڷ� ����*/
		/*2009.03.07 �����̿������׿��ݿ� ��������(���ս�) ����. - ����, �ݰ��꿡 ������ ��ǥ�� ���������ϹǷ� */
        /***    
				 2010.04.16 ����
        if(strFDCODE.equals("%")){
          String  sql009_2 = "\n INSERT INTO ACCOUNT.MTOTALBAL                                                                                               "
                           + "\n              (FDCODE,ACTYYMM,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)                                                         "
                           + "\n SELECT '02' ,'"+curYYMM+"','3302210',X.FDCODE , '', '2930', 0,                                                       "
                           + "\n        SUM(X.CRAMT) - SUM(X.DRAMT)                                                                                         "
                           + "\n FROM(                                                                                                                      "
                           + "\n SELECT FDCODE,                                                                                                             "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0)AS DRAMT,  "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0)AS CRAMT   "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '02%'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4300000','4400000','4520000','4540000','4550000')                                                    "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n UNION ALL                                                                                                                  "
                           + "\n SELECT FDCODE,                                                                                                               "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0) AS DRAMT, "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0) AS CRAMT  "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '02%'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4100000','4510000','4530000','3302210','3302240')                                                                       "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n       )X                                                                                                                   "
                           + "\n GROUP BY FDCODE                                                                                                            ";
          GauceStatement gsmt009_2 = conn.getGauceStatement(sql009_2);
          gsmt009_2.executeUpdate();
          gsmt009_2.close();

          String  sql009_3 = "\n INSERT INTO ACCOUNT.MTOTALBAL                                                                                               "
                           + "\n              (FDCODE,ACTYYMM,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)                                                         "
                           + "\n SELECT '03' ,'"+curYYMM+"','3302210',X.FDCODE , '', '2930', 0,                                                       "
                           + "\n        SUM(X.CRAMT) - SUM(X.DRAMT)                                                                                         "
                           + "\n FROM(                                                                                                                      "
                           + "\n SELECT FDCODE,                                                                                                             "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0)AS DRAMT,  "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0)AS CRAMT   "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '03%'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4300000','4400000','4520000','4540000','4550000')                                                    "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n UNION ALL                                                                                                                  "
                           + "\n SELECT FDCODE,                                                                                                                "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0) AS DRAMT, "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0) AS CRAMT  "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '03%'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4100000','4510000','4530000','3302210','3302240')                                                                        "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n       )X                                                                                                                   "
                           + "\n GROUP BY FDCODE                                                                                                            ";
          GauceStatement gsmt009_3 = conn.getGauceStatement(sql009_3);
          gsmt009_3.executeUpdate();
          gsmt009_3.close();
        }else{
          String  sql009_2 = "\n INSERT INTO ACCOUNT.MTOTALBAL                                                                                               "
                           + "\n              (FDCODE,ACTYYMM,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)                                                         "
                           + "\n SELECT X.FDCODE ,'"+curYYMM+"','3302210',X.FDCODE , '', '2930', 0,                                                       "
                           + "\n        SUM(X.CRAMT) - SUM(X.DRAMT)                                                                                         "
                           + "\n FROM(                                                                                                                      "
                           + "\n SELECT FDCODE,                                                                                                             "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0)AS DRAMT,  "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0)AS CRAMT   "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '"+strFDCODE+"'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4300000','4400000','4520000','4540000','4550000')                                                    "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n UNION ALL                                                                                                                  "
                           + "\n SELECT '"+strFDCODE1+"' FDCODE,                                                                                                                "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0) AS DRAMT, "
                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0) AS CRAMT  "
                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
                           + "\n    AND  FDCODE LIKE '"+strFDCODE+"'                                                                                                   "
                           + "\n    AND ACTDAT >= '"+befsYYMMDD+"'                                                                                          "
                           + "\n    AND ACTDAT <= '"+befeYYMMDD+"'                                                                                          "
                           + "\n    AND A.ATCODE  IN ('4100000','4510000','4530000','3302210','3302240')                                                                        "
                           + "\n    GROUP BY A.FDCODE                                                                                                       "
                           + "\n       )X                                                                                                                   "
                           + "\n GROUP BY FDCODE                                                                                                            ";
          GauceStatement gsmt009_2 = conn.getGauceStatement(sql009_2);
          gsmt009_2.executeUpdate();
          gsmt009_2.close();
        }
        
				***/
     
				 String  sql009_2 = "\n INSERT INTO ACCOUNT.MTOTALBAL                                                                                               "
		                           + "\n              (FDCODE,ACTYYMM,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)                                                      "
		                           + "\n SELECT X.FDCODE ,'"+curYYMM+"','"+strAtcode+"','02','"+strDivcd+"','"+strDeptcd+"', 0,  SUM(X.CRAMT) - SUM(X.DRAMT)        "
		                           + "\n FROM(                                                                                                                      "
		                           + "\n SELECT A.FDCODE,                                                                                                           "
		                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0)AS DRAMT,  "
		                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0)AS CRAMT   "
		                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
		                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
		                           + "\n    AND A.FDCODE = '"+strFDCODE+"'                                                                                          "
		                           + "\n    AND A.ACTDAT >= '"+befsYYMMDD+"'                                                                                        "
		                           + "\n    AND A.ACTDAT <= '"+befeYYMMDD+"'                                                                                        "
		                           + "\n    AND A.ATCODE  IN ('4300000','4400000','4520000','4540000','4550000')                                                    "
		                           + "\n    GROUP BY A.FDCODE                                                                                                       "
		                           + "\n UNION ALL                                                                                                                  "
		                           + "\n SELECT A.FDCODE,                                                                                                           "
		                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0) AS DRAMT, "
		                           + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0) AS CRAMT  "
		                           + "\n   FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                                               "
		                           + "\n  WHERE A.ATCODE = B.ATCODE                                                                                                 "
		                           + "\n    AND A.FDCODE = '"+strFDCODE+"'                                                                                          "
		                           + "\n    AND A.ACTDAT >= '"+befsYYMMDD+"'                                                                                        "
		                           + "\n    AND A.ACTDAT <= '"+befeYYMMDD+"'                                                                                        "
		                           + "\n    AND A.ATCODE  IN ('4100000','4510000','4530000','3302210','3302240')                                                    "
		                           + "\n    GROUP BY A.FDCODE                                                                                                       "
		                           + "\n       )X                                                                                                                   "
		                           + "\n GROUP BY FDCODE                                                                                                            ";
		          
				  GauceStatement gsmt009_2 = conn.getGauceStatement(sql009_2);
		          gsmt009_2.executeUpdate();
		          gsmt009_2.close();
		          
		          /*�ϰ����׸����� �ͳ��ڷ� ����*/
		          String  sql010 = "\n DELETE FROM ACCOUNT.FSREFTOT       "  
		                         + "\n  WHERE FDCODE = '"+strFDCODE+"'    "  
		                         + "\n    AND ACTDAT = '"+curYYMMDD+"'    " ;
				  GauceStatement gsmt010 = conn.getGauceStatement(sql010);
				  gsmt010.executeUpdate();
				  gsmt010.close();
				  /*�ϰ����׸����� �ͳ��ڷ� ����*/
				  String  sql011 =  "\n INSERT INTO ACCOUNT.FSREFTOT                                                                                              "  
			                       +  "\n             (FDCODE,ACTDAT,ATCODE,COCODE,DIVCD,DEPTCD,FSREFCD,FSREFVAL,DETOT,CRTOT,                                       "  
			                       +  "\n              DEUPTOT,CRUPTOT,FODETOT,FOCRTOT,FODEUPTOT,FOCRUPTOT,EXRATE,EXRATEDT,EXRATEGB)                                "  
			                       +  "\n SELECT A.FDCODE,	/*�����*/                                                                                                "  
			                       +  "\n        '"+curYYMMDD+"',                                                                                                   "  
			                       +  "\n        A.ATCODE,                                                                                                          "  
			                       +  "\n        A.COCODE,	/*�����*/                                                                                                "  
			                       +  "\n        ACCOUNT.FN_DIVCD_FIND(NVL(RTRIM(A.DEPTCD),'9999')),                                                        " 
			                       //+  "\n        'XXXX',                                                        "
			                       +  "\n        NVL(RTRIM(A.DEPTCD),'9999'),                                                                          " 
			                       +  "\n        A.FSREFCD,                                                                                                         "  
			                       +  "\n        A.FSREFVAL,                                                                                                        "  
			                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0),           "  
			                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0),           "  
			                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DEUPTOT - A.CRUPTOT ELSE 0 END END),0),       "  
			                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRUPTOT - A.DEUPTOT END END),0),       "  
			                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODETOT - A.FOCRTOT ELSE 0 END END),0),       "  
			                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRTOT - A.FODETOT END END),0),       "  
			                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODEUPTOT - A.FOCRUPTOT ELSE 0 END END),0),   "  
			                       +  "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRUPTOT - A.FODEUPTOT END END),0),   "  
			                       +  "\n        0,                                                                                                                 "  
			                       +  "\n        '',                                                                                                                "  
			                       +  "\n        ''                                                                                                                 "  
			                       +  "\n   FROM ACCOUNT.FSREFTOT A, ACCOUNT.ACTCODE B                                                                              "  
			                       +  "\n  WHERE A.FDCODE = '"+strFDCODE+"'	/*�����*/                                                                          "  
			                       +  "\n    AND A.ATCODE = B.ATCODE                                                                                                "  
			                       +  "\n    AND A.ACTDAT >= '"+befsYYMMDD+"'                                                                                       "  
			                       +  "\n    AND A.ACTDAT <= '"+befeYYMMDD+"'                                                                                       "  
			                       +  "\n    AND A.ATCODE >= '1000000'                                                                                              "  
			                       +  "\n    AND A.ATCODE <= '3999999'                                                                                              "  
			                       +  "\n    AND A.ATCODE NOT IN ('3302210' , '3302200' , '3302220' ,'1110690')                                                     "  
			                       +  "\n GROUP BY A.FDCODE,A.ATCODE,A.COCODE,A.DEPTCD,A.FSREFCD,A.FSREFVAL                                                        ";
					
				    GauceStatement gsmt011 = conn.getGauceStatement(sql011);
					gsmt011.executeUpdate();
					gsmt011.close();

					/*�������׸����� �ͳ��ڷ� ����*/
			        String  sql013 = "\n DELETE FROM ACCOUNT.MFSREFTOT       "  
			                       + "\n  WHERE FDCODE = '"+strFDCODE+"'     "  
			                       + "\n      AND ACTYYMM = '"+curYYMM+"'  " ;
					GauceStatement gsmt013 = conn.getGauceStatement(sql013);
					gsmt013.executeUpdate();
					gsmt013.close();
					/*�������׸����� �ͳ��ڷ� ����*/
			        String  sql014 = "\n INSERT INTO ACCOUNT.MFSREFTOT                                                                                            " 
			                       + "\n             (FDCODE,ACTYYMM,ATCODE,COCODE,DIVCD,DEPTCD,FSREFCD,FSREFVAL,DETOT,CRTOT,                                     " 
			                       + "\n              DEUPTOT,CRUPTOT,FODETOT,FOCRTOT,FODEUPTOT,FOCRUPTOT,EXRATE,EXRATEDT,EXRATEGB)                               " 
			                       + "\n SELECT A.FDCODE,	/*�����*/                                                                                              " 
			                       + "\n        '"+curYYMM+"',                                                                                                    " 
			                       + "\n        A.ATCODE,                                                                                                         " 
			                       + "\n        A.COCODE,	/*�����*/                                                                                              " 
			                       + "\n        ACCOUNT.FN_DIVCD_FIND(NVL(RTRIM(A.DEPTCD),'9999')),                                                        " 
			                       //+  "\n        'XXXX',                                                        "
			                       + "\n        NVL(RTRIM(A.DEPTCD),'9999'),                                                                          " 
			                       + "\n        A.FSREFCD,                                                                                                        " 
			                       + "\n        A.FSREFVAL,                                                                                                       " 
			                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DETOT - A.CRTOT ELSE 0 END END),0),          " 
			                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRTOT - A.DETOT END END),0),          " 
			                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.DEUPTOT - A.CRUPTOT ELSE 0 END END),0),      " 
			                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.CRUPTOT - A.DEUPTOT END END),0),      " 
			                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODETOT - A.FOCRTOT ELSE 0 END END),0),      " 
			                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRTOT - A.FODETOT END END),0),      " 
			                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '1' THEN CASE B.ATDECR WHEN '1' THEN A.FODEUPTOT - A.FOCRUPTOT ELSE 0 END END),0),  " 
			                       + "\n        COALESCE(SUM(CASE B.ATDECR WHEN '2' THEN CASE B.ATDECR WHEN '1' THEN 0 ELSE A.FOCRUPTOT - A.FODEUPTOT END END),0),  " 
			                       + "\n        0,                                                                                                                " 
			                       + "\n        '',                                                                                                               " 
			                       + "\n        ''                                                                                                                " 
			                       + "\n   FROM ACCOUNT.MFSREFTOT A, ACCOUNT.ACTCODE B                                                                            " 
			                       + "\n  WHERE A.FDCODE = '"+strFDCODE+"'	/*�����*/                                                                            " 
			                       + "\n    AND A.ATCODE = B.ATCODE                                                                                               " 
			                       + "\n    AND A.ACTYYMM >= '"+befsYYMM+"'                                                                                       " 
			                       + "\n    AND A.ACTYYMM <= '"+befeYYMM+"'                                                                                       "
			                       + "\n    AND A.ATCODE >= '1000000'                                                                                             " 
			                       + "\n    AND A.ATCODE <= '3999999'                                                                                             " 
			                       + "\n    AND A.ATCODE NOT IN ('3302210' , '3302200' , '3302220' ,'1110690')                                                    " 
			                       + "\n GROUP BY A.FDCODE,A.ATCODE,A.COCODE,A.DEPTCD,A.FSREFCD,A.FSREFVAL                                                        ";
					
			        GauceStatement gsmt014 = conn.getGauceStatement(sql014);
					gsmt014.executeUpdate();
					gsmt014.close();
		
        /**
        
				//������ ��� �����̿� �����׿����� 0 ���� �ϰ� �� �ݾ��� ������������ �ű�
				//2010.04.09 jys
				if(strFDCODE.equals("04")){
					//
				 String  sql015_1 = "\n INSERT INTO ACCOUNT.TOTALBAL                                             "
													 + "\n              (FDCODE,ACTDAT,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)     "
													 + "\n  SELECT FDCODE, ACTDAT, '1240000', COCODE, 'J000', DEPTCD, DETOT, CRTOT  "
													 + "\n    FROM ACCOUNT.TOTALBAL                                                 "
													 + "\n   WHERE FDCODE= '"+strFDCODE+"'                                          "
													 + "\n     AND ATCODE='3302210'                                                 "
													 + "\n     AND ACTDAT = '"+curYYMMDD+"'                                       ";

					GauceStatement gsmt015_1 = conn.getGauceStatement(sql015_1);
					gsmt015_1.executeUpdate();
					gsmt015_1.close();


					String  sql015_2 = "\n INSERT INTO ACCOUNT.MTOTALBAL                                             "
													 + "\n              (FDCODE,ACTYYMM,ATCODE,COCODE, DIVCD,DEPTCD,DETOT,CRTOT)     "
													 + "\n  SELECT FDCODE, ACTYYMM, '1240000', COCODE, 'J000', DEPTCD, DETOT, CRTOT  "
													 + "\n    FROM ACCOUNT.MTOTALBAL                                                 "
													 + "\n   WHERE FDCODE= '"+strFDCODE+"'                                          "
													 + "\n     AND ATCODE='3302210'                                                 "
													 + "\n     AND ACTYYMM = '"+curYYMM+"'                                       ";

					GauceStatement gsmt015_2 = conn.getGauceStatement(sql015_2);
					gsmt015_2.executeUpdate();
					gsmt015_2.close();

          
				}
				**/

			} //try
			catch(Exception e){
				conn.rollback();
				//logger.err.println(this,"errno::"+strErrorNo);
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}
    
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}