<!--
***********************************************************************
* @source      : guna110_ED.jsp
* @description : ���κ�����������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      ���м�        �����ۼ�.        
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>                
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>  
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
    
    String occ_cd  = request.getParameter("occ_cd");	//��ȸ����(�繫��,�ù���)
	String str_ymd = request.getParameter("str_ymd");   //��������
    String end_ymd = request.getParameter("end_ymd");   //��������
    String dpt_cd  = request.getParameter("dpt_cd");    //�μ��ڵ�
    String dpt_nm  = request.getParameter("dpt_nm");    //�μ���
    String flag    = request.getParameter("flag");    //�μ���
    String ymd     = request.getParameter("ymd");    //�μ���
    String dpt_nm_val = request.getParameter("dpt_nm_val");    //�μ���

    String str_y = str_ymd.substring(0,4);
    String str_m = str_ymd.substring(5,7);
    String str_d = str_ymd.substring(8,10);
    
    String end_y = end_ymd.substring(0,4);
    String end_m = end_ymd.substring(5,7);
    String end_d = end_ymd.substring(8,10);
    String dpt_cd_val = "";

    int str_no = Integer.parseInt(str_d);    
    int end_no = Integer.parseInt(end_d);    
    int str_no2 = str_no - 1;
    
    String mem_cnt = "";        //���ο�

    if ( dpt_cd.equals("") || dpt_cd.equals(null) ) {
        dpt_cd_val  = "";
    } else {
        dpt_cd_val = " AND AA.DPT_CD = '"+ dpt_cd +"'";
    }
    StringBuffer sb_str1 = new StringBuffer();
    StringBuffer sb_str2 = new StringBuffer();
    StringBuffer sb_end1 = new StringBuffer();
    StringBuffer sb_end2 = new StringBuffer();
    
    int i = 0;
    String sql = "";
    Object[] bind = null;

    if ( str_m.equals(end_m) )
    {
        for ( i = str_no; i <= end_no; i++ )    // ���ۿ�
        {              
            sb_str1.append("when "+ i +" then AT"+ i +"_CD \n");
            sb_end1.append(", AT"+ i +"_CD \n");
        }
        
        sql = XmlSqlUtils.getSQL("gun", "GUNA110_SHR02");
        
        /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
        Object[] sqlParam = new Object[] {
                  dpt_cd_val
                , occ_cd
                , sb_str1.toString()
                , sb_end1.toString()
                , dpt_cd_val
                , occ_cd
                , Integer.toString(str_no2)
                , Integer.toString(end_no)
        };
        
        /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);

        bind = new Object[] {
                str_ymd, str_ymd, str_ymd , end_ymd
        };
    }
    else
    {
        for ( i = str_no; i <= 31; i++ )    // ���ۿ�
        {              
            sb_str1.append("when "+ i +" then AT"+ i +"_CD \n");
            sb_str2.append(", AT"+ i +"_CD \n");
        }
        for ( i = 1; i <= end_no; i++ )    // ������ ��
        {              
            sb_end1.append("when "+ i +" then AT"+ i +"_CD \n");
            sb_end2.append(", AT"+ i +"_CD \n");
        }
        
        sql = XmlSqlUtils.getSQL("gun", "GUNA110_SHR");
        
        /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
        Object[] sqlParam = new Object[] {
                  dpt_cd_val
                , occ_cd
                , sb_str1.toString()
                , sb_str2.toString()
                , dpt_cd_val
                , occ_cd
                , Integer.toString(str_no2)
                , Integer.toString(str_no)
                , dpt_cd_val
                , occ_cd
                , sb_end1.toString()
                , sb_end2.toString()
                , dpt_cd_val
                , occ_cd
                , Integer.toString(end_no)
        };
        
        /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);

        bind = new Object[] {
                str_ymd, str_ymd, str_ymd, str_ymd, str_ymd, str_ymd ,end_ymd, str_ymd , end_ymd
        };
    }

    AbstractDAO aaa= new AbstractDAO("default");
    
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�߻�����");
    hnwExtQuery.AddField("����");

    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("Refresh");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("Ư��");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("��ü�ް�");
    hnwExtQuery.AddField("��Ÿ");

    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�̻�뿬��");
    hnwExtQuery.AddField("���ο�");

    hnwExtQuery.AddField("�μ���");
    hnwExtQuery.AddField("�Ⱓ");


    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList.size() > 0 && flag.equals("Y") ) 
    {
        for ( i = 0; i < voList.size(); i++ ) 
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList.get(voList.size()-1);    //���ϸ������ο��� ���ο����� ������
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("NYRP_CNT"));
            hnwExtQuery.AddData(vo.getString("F"));

            hnwExtQuery.AddData(vo.getString("Q"));
            hnwExtQuery.AddData(vo.getString("H"));
            hnwExtQuery.AddData(vo.getString("Z"));
            hnwExtQuery.AddData(vo.getString("S"));
            hnwExtQuery.AddData(vo.getString("I"));
            hnwExtQuery.AddData(vo.getString("A"));
            hnwExtQuery.AddData(vo.getString("B"));
            hnwExtQuery.AddData(vo.getString("C"));
            hnwExtQuery.AddData(vo.getString("D"));
            hnwExtQuery.AddData(vo.getString("E"));
            hnwExtQuery.AddData(vo.getString("T"));
            hnwExtQuery.AddData(vo.getString("L"));

            hnwExtQuery.AddData(vo.getString("C_YEAR"));
            hnwExtQuery.AddData(vo.getString("H_YEAR"));
            hnwExtQuery.AddData(vo.getString("NYRP_CNT2"));
          
            hnwExtQuery.AddData(vo2.getString("CNT"));
            hnwExtQuery.AddData(dpt_nm_val);
            hnwExtQuery.AddData(ymd);
            
            hnwExtQuery.SendData(response);

        }
    } else {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
                                                  
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
          
            if ( flag.equals("Y") ) hnwExtQuery.AddData("0");
            else hnwExtQuery.AddData("");

            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.SendData(response);
    }
%>