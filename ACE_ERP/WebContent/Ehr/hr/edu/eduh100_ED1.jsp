<!--
***********************************************************************
* @Source         : eduh100_ED.jsp                                                    *
* @Description    : ������Ȳ���� PAGE         
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/02      ���м�        �����ۼ�.        
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

    String edu_cd = request.getParameter("edu_cd");
    String seq_no = request.getParameter("seq_no");


    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("edu", "EDUH100_SHR_01");
 
    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
        
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        edu_cd, seq_no
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�н�����");
    hnwExtQuery.AddField("�н����");
    hnwExtQuery.AddField("�ҿ���");
    hnwExtQuery.AddField("ȯ�޿���");
    hnwExtQuery.AddField("�Ǻ��");
    hnwExtQuery.AddField("�н�����");
   
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0) 
    {
        for ( i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("EDU_NM"));
            hnwExtQuery.AddData(vo.getString("CHASU_TAG"));
            hnwExtQuery.AddData(vo.getString("PLACE_NM"));
            hnwExtQuery.AddData(vo.getString("EDU_STR_YMD") + " ~ " + vo.getString("EDU_END_YMD"));
            hnwExtQuery.AddData(vo.getString("INT_NAM"));
            hnwExtQuery.AddData(vo.getString("COST_AMT"));
            hnwExtQuery.AddData(vo.getString("INS_NM"));
            hnwExtQuery.AddData(vo.getString("SUM_AMT"));
            hnwExtQuery.AddData(vo.getString("CONTENT_TXT")); 
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
      
        hnwExtQuery.SendData(response);
    }

%>