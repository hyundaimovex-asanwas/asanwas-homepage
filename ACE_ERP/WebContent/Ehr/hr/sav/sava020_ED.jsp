<!--
***********************************************************************
* @source      : sava020.jsp										  *
* @description : ����ݰ������� PAGE 	
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/07      ���м�        �����ۼ�.        
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
    String DED_YM_SHR = request.getParameter("DED_YM_SHR").replaceAll("-", "");
    String OCC_CD_SHR = request.getParameter("OCC_CD_SHR");
    String DPT_CD_SHR = request.getParameter("DPT_CD_SHR");
    String JOB_CD_SHR = request.getParameter("JOB_CD_SHR");
    String BNK_CD_SHR = request.getParameter("BNK_CD_SHR");

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("sav", "SAVA020_SHR");

    /** ��ȸ ���ǿ� ���� ó�� **/
    StringBuffer sb = new StringBuffer();
    
    if ( !DED_YM_SHR.equals("") ) {
        sb.append("A.DED_YM = '"+DED_YM_SHR+"' \n");
    }else{
        sb.append("1=1 \n");
    }
    if( ! OCC_CD_SHR.equals("0") ){
        sb.append("AND B.OCC_CD = '"+OCC_CD_SHR+"' \n");
    }
    if( ! DPT_CD_SHR.equals("") ){
        sb.append("AND B.DPT_CD = '"+DPT_CD_SHR+"' \n");
    }
    if( ! JOB_CD_SHR.equals("") ){
        sb.append("AND B.JOB_CD = '"+JOB_CD_SHR+"' \n");
    }
    if( ! BNK_CD_SHR.equals("") ){
        sb.append("AND A.BNK_CD = '"+BNK_CD_SHR+"' \n");
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

    hnwExtQuery.AddField("�Ҽ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����Ƚ��");
    hnwExtQuery.AddField("�����Ծ�");
    hnwExtQuery.AddField("���Դ���");
    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("������");

    hnwExtQuery.AddField("���¹�ȣ");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("BNK_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("PIN_CNT"));
            hnwExtQuery.AddData(vo.getString("PYM_AMT"));
            hnwExtQuery.AddData(vo.getString("SUM_SAV"));
            hnwExtQuery.AddData(vo.getString("CON_YMD"));
            hnwExtQuery.AddData(vo.getString("DUE_YMD"));

            hnwExtQuery.AddData(vo.getString("ACC_NO"));
           
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

        hnwExtQuery.SendData(response);
    }

%>