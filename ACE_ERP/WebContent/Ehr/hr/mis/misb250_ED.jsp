<!--
***********************************************************************
* @source      : misb250_ED.jsp
* @description : ���� �ο� ��Ȳ ��ȸPAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/20      �̽¿�        �����ۼ�.
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
    String str_ym   = request.getParameter("STR_YM");
    String end_ym   = request.getParameter("END_YM");
    String cd_gbn    = request.getParameter("CD_GBN");
    String dpt_cd    = request.getParameter("DPT_CD");

    String sql = null;
	StringBuffer sb1 = new StringBuffer();

	/** DynamicSQL�� �����ϴ� �κ� [1] **/
    if (cd_gbn.equals("B2")){
        sb1.append(" AND HEAD_CD = '" + dpt_cd + "'");
    } else if (cd_gbn.equals("A4")){
        sb1.append(" AND DPT_CD = '"  + dpt_cd + "'");
    }

	/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
	Object[] sqlParam = new Object[] {
			sb1.toString(),
			sb1.toString(),
			sb1.toString()
	};

	/** [1] ~ [4] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/

    sql = XmlSqlUtils.getSQL("mis", "MISB250_SHR");
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    
      Object[] bind = null;
      bind = new Object[] {
           str_ym, end_ym
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("REG_YM");
    hnwExtQuery.AddField("REG_YMD");
    hnwExtQuery.AddField("TRANS_BUSI");
    hnwExtQuery.AddField("SMALL_GOODS");
    hnwExtQuery.AddField("DISPATCH_ABR");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("REG_YM"));
            hnwExtQuery.AddData(vo.getString("REG_YMD"));
            hnwExtQuery.AddData(vo.getString("TRANS_BUSI"));
            hnwExtQuery.AddData(vo.getString("SMALL_GOODS"));
            hnwExtQuery.AddData(vo.getString("DISPATCH_ABR"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
