
<!--
***********************************************************************
* @source      : edui030_ED.jsp
* @description : ��������� ��Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     �漮ȣ        �����ۼ�.
* 2007/05/10     ���м�        ����.
*----------------------------------------------------------------------
* �˻�����(��������)�� ���� ��������� �ڵ带 ��ȸ ��, ��ȸ�� �ڵ� ����
  ��ŭ for������ ���� �ش米������� �ڵ忡 �´� ����(������)�� 
  ���� ����� ���������� �������� �������.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
	String JPR_YMD_SHR	= request.getParameter("JPR_YMD_SHR").replaceAll("-", "");
	
    String OCC_CD_SHR   = request.getParameter("OCC_CD_SHR");

	String GBN_CD       = request.getParameter("GBN_CD");
	String DPT_CD_SHR   = request.getParameter("DPT_CD_SHR");
    String EDU_CD_SHR   = request.getParameter("EDU_CD_SHR");
    String JOB_CD_SHR   = request.getParameter("JOB_CD_SHR");

    String sort1 = "";
    String sort2 = "";
    String EDU_VAL = "";

    if ( EDU_CD_SHR == null ) {
        EDU_CD_SHR = "";
    }
	/** ��ȸ ���ǿ� ���� ó�� **/


    if ( GBN_CD.equals("2") ) {
	    sort1 = "V1.COMM_NM";
        sort2 = "V2.COMM_NM";
	} else {
	    sort2 = "V1.COMM_NM";
        sort1 = "V2.COMM_NM";
    }
    
    if ( EDU_CD_SHR.equals("") || EDU_CD_SHR == null ) {
        EDU_VAL = "";
    } else {
        EDU_VAL = "AND COMM_CD = '"+EDU_CD_SHR+"'";
    }
    int i = 0;
//---------------------------------------------------------------���ǿ� ���� ��������� �ڵ带 ��ȸ�Ѵ�
	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("edu", "EDUI030_SHR1");
        
    
	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
	};

	StringBuffer sb = new StringBuffer();

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
        EDU_VAL
	};

	/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    String[] EDU_CD_ARR  = new String[voList.size()];
    String[] EDU_NM_ARR  = new String[voList.size()];
//    String[][] arr_temp  = new String[voList.size()][100];

    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            EDU_CD_ARR[i] = vo.getString("COMM_CD");
            EDU_NM_ARR[i] = vo.getString("COMM_NM");
        }
    }

//--------------------------------------------------------------------------------------------------------

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("SORT1");
    hnwExtQuery.AddField("SORT2");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�Ի���");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("����");

    hnwExtQuery.SendField(response);

    int j = 0;
	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql2 = "";
        
 
//************************************** for���� ->  ��ü��ȸ�ϰ�� �տ��� ��ȸ�ؿ� ��� ����������ڵ� ������ ���� ���Ǻ� ��ȸ�� ��.
    
    int k = 0;
    int cnt = 0;
    String d_sql  = "";         //���������ڵ忡 ���� �ش� ����(���) ��ȸ����
    String d_sql2 = "";         //�ҼӺ�, �������� ���� ������
    String d_sql3 = "";         //����������
    Object[] sqlParam2 = null;
    Object[] bind2 = null;
    DynamicValueObject voList2 = null;
    DynamicValueObject vo2 = null;

    String rrr = "";

    if ( voList.size() > 0 ) {
        for ( i=0; i<voList.size(); i++ ) 
        {
            sql2 = XmlSqlUtils.getSQL("edu", "EDUI030_SHR2");

            if ( EDU_CD_ARR[i].equals("MS") ) {                                    /*�濵�������̳�*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('1A','A2','A3')                                  \n";
            } else if ( EDU_CD_ARR[i].equals("C ") ) {                              /*�ְ�濵�ڰ���*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('A4')                                            \n";
            } else if ( EDU_CD_ARR[i].equals("C1") ) {                              /*�濵�ڰ���*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('1B','A6','A5')                                  \n";
            } else if ( EDU_CD_ARR[i].equals("C2") ) {                              /*�߰�濵�ڰ���*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('A4','1B','A6','A5')                             \n";
            } else if ( EDU_CD_ARR[i].equals("ED") ) {                              /*�����̻������*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('1B')                                            \n";
                d_sql += "                AND SUBSTR(M.JPR_YMD,1,4) = SUBSTR('"+JPR_YMD_SHR+"',1,4)         \n";
            } else if ( EDU_CD_ARR[i].equals("10") ) {                              /*���Ӻ������*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('1C')                                            \n";
                d_sql += "                AND SUBSTR(M.JPR_YMD,1,4) = SUBSTR('"+JPR_YMD_SHR+"',1,4)                      \n";
            } else if ( EDU_CD_ARR[i].equals("3 ") ) {                              /*�����������*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('1E')                                            \n";
                d_sql += "                AND SUBSTR(M.JPR_YMD,1,4) = SUBSTR('"+JPR_YMD_SHR+"',1,4)         \n";
            } else if ( EDU_CD_ARR[i].equals("1 ") ) {                              /*���Ӱ������*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('2A','2B','20')                                  \n";
                d_sql += "                AND SUBSTR(M.JPR_YMD,1,4) = SUBSTR('"+JPR_YMD_SHR+"',1,4)         \n";
            } else if ( EDU_CD_ARR[i].equals("V ") ) {                              /*���Ӵ븮����*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('3A','3B','30')                                  \n";
                d_sql += "                AND SUBSTR(M.JPR_YMD,1,4) = SUBSTR('"+JPR_YMD_SHR+"',1,4) ";
            } else if ( EDU_CD_ARR[i].equals("U ") ) {                             /*����������*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('1E')                                            \n";
                d_sql += "                AND (NVL(MONTHS_BETWEEN(TO_DATE(SUBSTR('"+JPR_YMD_SHR+"',1,4)||'1231','YYYYMMDD'), TO_DATE(TO_CHAR(M.JPR_YMD,'YYYYMMDD'),'YYYYMMDD')-1),0)) >= 48  \n";
            } else if ( EDU_CD_ARR[i].equals("S ") ) {                             /*����������*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('20','2A','2B')                                  \n";
                d_sql += "                AND (NVL(MONTHS_BETWEEN(TO_DATE(SUBSTR('"+JPR_YMD_SHR+"',1,4)||'1231','YYYYMMDD'), TO_DATE(TO_CHAR(M.JPR_YMD,'YYYYMMDD'),'YYYYMMDD')-1),0)) >= 60  \n";
            } else if ( EDU_CD_ARR[i].equals("Q ") ) {                             /*����������*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('30','3A','3B')                                  \n";
                d_sql += "                AND (NVL(MONTHS_BETWEEN(TO_DATE(SUBSTR('"+JPR_YMD_SHR+"',1,4)||'1231','YYYYMMDD'), TO_DATE(TO_CHAR(M.JPR_YMD,'YYYYMMDD'),'YYYYMMDD')-1),0)) >= 48  \n";
            } else if ( EDU_CD_ARR[i].equals("B ") ) {                             /*�븮������*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('40','4A','4B')                                  \n";
                d_sql += "                AND (NVL(MONTHS_BETWEEN(TO_DATE(SUBSTR('"+JPR_YMD_SHR+"',1,4)||'1231','YYYYMMDD'), TO_DATE(TO_CHAR(M.JPR_YMD,'YYYYMMDD'),'YYYYMMDD')-1),0)) >= 46  \n";
            } else if ( EDU_CD_ARR[i].equals("T ") ) {                             /*4�� ���Ի��*/
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('40','4A','4B')                                  \n";
                d_sql += "                AND (NVL(MONTHS_BETWEEN(TO_DATE('"+JPR_YMD_SHR+"','YYYYMMDD'), TO_DATE(TO_CHAR(M.JPR_YMD,'YYYYMMDD'),'YYYYMMDD')),0)) <= 12                        \n";
                d_sql  = "                AND M.JPR_YMD = M.HIRG_YMD                                        \n";
            } else if ( EDU_CD_ARR[i].equals("Y ") ) {                             /*5�� ������������*/   
                d_sql3 = ", '"+EDU_NM_ARR[i]+"'       EDU_NM                                                \n";
                d_sql  = "                AND M.JOB_CD IN ('50','5A','5B')                                  \n";
                d_sql += "                AND M.JPR_YMD < TO_CHAR(TO_NUMBER(SUBSTR('"+JPR_YMD_SHR+"',1,4)-4))||'0301'        \n";
            } else {                                      /*������������ ����*/
                d_sql  = "                AND M.JOB_CD IN ('XX')                                            \n";
                d_sql3 = "";
            }

            if ( GBN_CD.equals("2") ) {
                d_sql2  = "                AND (M.RET_YMD IS NULL)                        \n";
                d_sql2 += "                AND M.DPT_CD LIKE '%'||'"+DPT_CD_SHR+"'||'%'                               \n";
                d_sql2 += "                ORDER BY V1.SORT_NO, V2.SORT_NO, M.JPR_YMD, M.ENO_NO              \n";
            } else {
                d_sql2  = "                AND (M.RET_YMD IS NULL)                        \n";
                d_sql2 += "                AND M.JOB_CD LIKE '%'||'"+JOB_CD_SHR+"'||'%'                               \n";
                d_sql2 += "                ORDER BY V2.SORT_NO, M.JPR_YMD, V1.SORT_NO, M.ENO_NO              \n";
            }

            /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
            bind2 = new Object[] {
                JPR_YMD_SHR,JPR_YMD_SHR,JPR_YMD_SHR,JPR_YMD_SHR,JPR_YMD_SHR,
                    JPR_YMD_SHR,JPR_YMD_SHR,JPR_YMD_SHR,JPR_YMD_SHR,JPR_YMD_SHR,
                    JPR_YMD_SHR,JPR_YMD_SHR,JPR_YMD_SHR,JPR_YMD_SHR,JPR_YMD_SHR
            };

            /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
            sqlParam2 = new Object[] {
                sort1, sort2, d_sql3, d_sql, d_sql2
            };


            /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
            sql2 = SqlUtils.replaceQuery(sql2, sqlParam2);

            AbstractDAO aaa2= new AbstractDAO("default");
            voList2 = aaa2.selectProcessDvo(sql2, bind2);

            if ( voList2.size() > 0 ) 
            {
                for ( j=0; j<voList2.size(); j++ ) 
                {
                    cnt = cnt + 1;
                    vo2 = (DynamicValueObject)voList2.get(j);

                    hnwExtQuery.AddData(Integer.toString(cnt));
                    hnwExtQuery.AddData(vo2.getString("SORT1"));
                    hnwExtQuery.AddData(vo2.getString("SORT2"));
                    hnwExtQuery.AddData(vo2.getString("ENO_NM"));
                    hnwExtQuery.AddData(vo2.getString("EDU_NM"));
                    hnwExtQuery.AddData(vo2.getString("HIRG_YMD"));
                    hnwExtQuery.AddData(vo2.getString("JPR_YMD"));
                    hnwExtQuery.AddData(vo2.getString("CHASU"));
                    rrr = rrr + vo2.getString("DPT_NM");
                    hnwExtQuery.SendData(response);
                }
            } else {
                
                if ( k == 0 && j == voList2.size()-1 ) {
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData("");     

                    hnwExtQuery.SendData(response);
                }
                k = 1;
            }

        } 
//***********************************************************************************************************
    }
    hnwExtQuery.EndData(response);
%>
