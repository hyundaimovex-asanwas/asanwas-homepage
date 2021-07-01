<!--
***********************************************************************
* @source      : memb120_ED.jsp
* @description : ��ü�� �İ߻�� ��Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/30      ���м�        �����ۼ�.        
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
    String PMT_YMD_SHR = request.getParameter("PMT_YMD_SHR");
    String OCC_CD_SHR  = request.getParameter("OCC_CD_SHR");

    String title_occ = "";
    StringBuffer sb = new StringBuffer();

    if( OCC_CD_SHR.equals("A") ){ 
        title_occ = "�� 2006�� ��������� ���(�繫��/���޺�)";
    } else if ( OCC_CD_SHR.equals("M") ){ 
        title_occ = "�� 2006�� ��������� ���(�ù���/���޺�)";
    } else if ( OCC_CD_SHR.equals("0") ){ 
        title_occ = "�� 2006�� ��������� ���(��ü/���޺�)";
    }

    /** ��ȸ ���ǿ� ���� ó�� **/
    if( ! OCC_CD_SHR.equals("0") ){ 
        sb.append("WHERE OCC_CD = '"+OCC_CD_SHR+"' \n");
    }

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("pro", "PROA070_SHR");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
        sb.toString()
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        PMT_YMD_SHR
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�μ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("ȣ��");
    hnwExtQuery.AddField("�������");
    hnwExtQuery.AddField("�Ի���");
    hnwExtQuery.AddField("�׷��Ի���");
    hnwExtQuery.AddField("��ű�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����������");
    hnwExtQuery.AddField("���������Ⱓ");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("title");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    String pre_JOBNM = "";
    String r_val     = "";
    String gubun_val = "";

    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            
            if ( pre_JOBNM.equals(vo.getString("JOB_NM")) ) {
                hnwExtQuery.AddData("");
            } else {
                gubun_val = vo.getString("JOB_NM") + " (" + vo.getString("R") + "��)";
                hnwExtQuery.AddData(gubun_val);
            }
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("HOB_NM"));
            hnwExtQuery.AddData(vo.getString("BIR_YMD"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("HIRG_YMD"));
            hnwExtQuery.AddData(vo.getString("SCH_NM"));
            hnwExtQuery.AddData(vo.getString("MAJ_NM"));
            hnwExtQuery.AddData(vo.getString("JPR_YMD"));
            hnwExtQuery.AddData(vo.getString("JPR_CON"));
            hnwExtQuery.AddData(vo.getString("REMARK"));
            hnwExtQuery.AddData(title_occ);

            hnwExtQuery.SendData(response);
            pre_JOBNM = vo.getString("JOB_NM");
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
            
            hnwExtQuery.SendData(response);
    }

%>