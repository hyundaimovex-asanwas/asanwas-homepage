<!--
***********************************************************************
* @source      : crua010_ED02.jsp
* @description : 입사지원서 가족사항 조회 
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/18      이승욱        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.core.exception.CException"%>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import="com.shift.gef.gauce.utility.TrBox"%>
<%@page import="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

    String REGYY      = request.getParameter("REGYY");
    String REGCH      = request.getParameter("REGCH");
    String REG_STR    = request.getParameter("REG_STR");
    String REG_END    = request.getParameter("REG_END");
    String SCHOOL     = request.getParameter("SCHOOL");
    String SPLIT_FLAG = request.getParameter("SPLIT_FLAG");
    String PASSTAG    = request.getParameter("PASSTAG");

    StringBuffer sb1  = new StringBuffer(); // 수허번호 From 
    if ( !REG_STR.equals("")) {
        sb1.append("AND M.REG_NO >= '"+REG_STR+"' \n");
    }
    StringBuffer sb2  = new StringBuffer(); // 수험전호 To 
    if ( !REG_END.equals("")) {
        sb2.append("AND M.REG_NO <= '"+REG_END+"' \n");
    }

    StringBuffer sb3  = new StringBuffer(); // 학력 
    if ( SCHOOL.equals("2")) {
        sb3.append("AND (S.UNAME1 IS NOT NULL OR S.GSNAME1 IS NOT NULL) \n");
    } else if ( SCHOOL.equals("3")) {
        sb3.append("AND (S.UNAME1 IS NULL AND S.GSNAME1 IS NULL) \n");
    }

    StringBuffer sb4  = new StringBuffer();
    if ( PASSTAG.equals("2")) {
        sb4.append("AND M.PASSTAG1 = 'Y' \n");
    } else if  ( PASSTAG.equals("3")) {
        sb4.append("AND M.PASSTAG2 = 'Y' \n");
    } else if  ( PASSTAG.equals("4")) {
        sb4.append("AND M.PASSTAG3 = 'Y' \n");
    } else if  ( PASSTAG.equals("5")) {
        sb4.append("AND M.PASSTAG4 = 'Y' \n");
    }

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb1.toString(),
			sb2.toString(),
			sb3.toString(),
			sb4.toString()
	};

    String sql = null;
    sql = XmlSqlUtils.getSQL("cru", "CRUA010_PR02");

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    Object[] bind = new Object[] {
    REGYY, REGCH, SPLIT_FLAG
    };
    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("REG_NO");
    hnwExtQuery.AddField("SEQ_NO");
    hnwExtQuery.AddField("REG_ENO_NM");
    hnwExtQuery.AddField("FREL");
    hnwExtQuery.AddField("FENO_NM");
    hnwExtQuery.AddField("FAGE");
    hnwExtQuery.AddField("FSCH");
    hnwExtQuery.AddField("FJOB");
    hnwExtQuery.AddField("FJOBNM");
    hnwExtQuery.AddField("FJOBPST");
    hnwExtQuery.AddField("FJOBSEC");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("REG_NO"));
            hnwExtQuery.AddData(vo.getString("SEQ_NO"));
            hnwExtQuery.AddData(vo.getString("REG_ENO_NM"));
            hnwExtQuery.AddData(vo.getString("FREL"));
            hnwExtQuery.AddData(vo.getString("FENO_NM"));
            hnwExtQuery.AddData(vo.getString("FAGE"));
            hnwExtQuery.AddData(vo.getString("FSCH"));
            hnwExtQuery.AddData(vo.getString("FJOB"));
            hnwExtQuery.AddData(vo.getString("FJOBNM"));
            hnwExtQuery.AddData(vo.getString("FJOBPST"));
            hnwExtQuery.AddData(vo.getString("FJOBSEC"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);
%>
