<!--
***********************************************************************
* @source      : edub010_PV.jsp									  	  *
* @description : ���м������� PAGE 	
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/18      ���м�        �����ۼ�.        
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

    String PRO_YMD_STDT_SHR = request.getParameter("PRO_YMD_STDT_SHR").replaceAll("-", "");	
    String PRO_YMD_ENDT_SHR = request.getParameter("PRO_YMD_ENDT_SHR").replaceAll("-", "");
    String ENO_NO_SHR       = request.getParameter("ENO_NO_SHR");	
    String SBJ_CD_SHR       = request.getParameter("SBJ_CD_SHR");
    String JOB_CD_SHR       = request.getParameter("JOB_CD_SHR");	
    String DPT_CD_SHR       = request.getParameter("DPT_CD_SHR");
    String TTL_AVR_SHR      = request.getParameter("TTL_AVR_SHR");	
    String CHECK4           = request.getParameter("CHECK4");

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("edu", "EDUB010_SHR_PRINT");

    /** ��ȸ ���ǿ� ���� ó�� **/
    StringBuffer sb = new StringBuffer();
    if (!PRO_YMD_STDT_SHR.equals("") && !PRO_YMD_ENDT_SHR.equals("")) {
        sb.append("AND A.PRO_YMD >= '"+PRO_YMD_STDT_SHR+"' \n");
        sb.append("AND A.PRO_YMD <= '"+PRO_YMD_ENDT_SHR+"' \n");
    } else if (!PRO_YMD_STDT_SHR.equals("") && PRO_YMD_ENDT_SHR.equals("")) {
        sb.append("AND A.PRO_YMD >= '"+PRO_YMD_STDT_SHR+"' \n");
    } else if (PRO_YMD_STDT_SHR.equals("") && !PRO_YMD_ENDT_SHR.equals("")) {
        sb.append("AND A.PRO_YMD <= '"+PRO_YMD_ENDT_SHR+"' \n");
    }
    // ������� �˻�
    if( !ENO_NO_SHR.equals("") ){
        sb.append("AND A.ENO_NO = '"+ENO_NO_SHR+"' \n");
    }
    // �����ڵ�� �˻�
    if( CHECK4.equals("Y")){ // 4�����
        sb.append("AND (A.SBJ_CD = 'E4' OR A.SBJ_CD = 'C1') \n"); // E4: 4������������, C1:4������������
    }else{
        if( !SBJ_CD_SHR.equals("0") ){
            sb.append("AND A.SBJ_CD = '"+SBJ_CD_SHR+"' \n");
        }
    }
    // ������ �˻�
    if( !JOB_CD_SHR.equals("") ){
        sb.append("AND B.JOB_CD = '"+JOB_CD_SHR+"' \n");
    }
    // �μ��� �˻�
    if( !DPT_CD_SHR.equals("") ){
        sb.append("AND B.DPT_CD = '"+DPT_CD_SHR+"' \n");
    }
    // ���輺������ ����
    if( TTL_AVR_SHR.equals("ASC") ){
        sb.append("ORDER BY DPT_NM, A.PRO_YMD ASC, A.TTL_AVR ASC \n");
    }else{
        sb.append("ORDER BY DPT_NM, A.PRO_YMD ASC, A.TTL_AVR DESC \n");
    }

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
        sb.toString(),
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�ֹε�Ϲ�ȣ");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("����ó");
    hnwExtQuery.AddField("L/C");
    hnwExtQuery.AddField("R/C");
    hnwExtQuery.AddField("���ϱ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("��Ÿ");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("���");
   
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));
            hnwExtQuery.AddData(vo.getString("SBJ_NM"));
            hnwExtQuery.AddData(vo.getString("INT_NAM"));
            hnwExtQuery.AddData(vo.getString("SBJ_LSN"));
            hnwExtQuery.AddData(vo.getString("SBJ_RED"));
            hnwExtQuery.AddData(vo.getString("SBJ_SPC"));
            hnwExtQuery.AddData(vo.getString("SBJ_VOC"));
            hnwExtQuery.AddData(vo.getString("SBJ_IPT"));
            hnwExtQuery.AddData(vo.getString("SBJ_TOT"));
            hnwExtQuery.AddData(vo.getString("SBJ_ETC"));
            hnwExtQuery.AddData(vo.getString("TTL_AVR"));
            hnwExtQuery.AddData(vo.getString("PRO_YMD"));
            hnwExtQuery.AddData(vo.getString("REMARK"));

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
        
        hnwExtQuery.SendData(response);
    }

%>
