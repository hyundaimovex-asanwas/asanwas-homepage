<!--
***********************************************************************
* @source      : eisc020_ED.jsp
* @description : 해외지사현황 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11      이승욱        최초작성.
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
    String pis_yy   = request.getParameter("PIS_YY");
    String disptch  = request.getParameter("DISPTCH");

    String sql = null;
    sql = XmlSqlUtils.getSQL("eis", "EISC020_SHR");

    StringBuffer sb = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (disptch.equals("1")){
        sb.append("(D.END_YMD  is null OR D.END_YMD >= TO_CHAR(SYSDATE,'YYYYMMDD'))");
    } else if (disptch.equals("2")){
        sb.append("D.END_YMD BETWEEN '"+pis_yy+"'||'0101' AND TO_CHAR(SYSDATE-1,'YYYYMMDD')");
    }
    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
        sb.toString()
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("DPC_NM");
    hnwExtQuery.AddField("ENO_NO");
    hnwExtQuery.AddField("ENO_NM");
    hnwExtQuery.AddField("STR_YMD");
    hnwExtQuery.AddField("END_YMD");
    hnwExtQuery.AddField("BIGO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("DPC_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("STR_YMD"));
            hnwExtQuery.AddData(vo.getString("END_YMD"));
            hnwExtQuery.AddData(vo.getString("BIGO"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           

