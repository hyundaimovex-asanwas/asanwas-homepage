<!--
***********************************************************************
* @source      : misa010_ED_03.jsp
* @description : 부서별 인원현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/12      이승욱        최초작성.
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
    String gbn_case = request.getParameter("GBN_CASE");
    String gbn_cd   = request.getParameter("GBN_CD");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (gbn_case.equals("HEAD_CD")){
        sb1.append(" AND P.HEAD_CD  IN ('" + gbn_cd + "')");
    } else if (gbn_case.equals("GBN2_TAG")){
        sb1.append(" AND C.GBN2_TAG = '" + gbn_cd + "'");
    } else {
	    sb1.append("");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb1.toString()
    };

    /** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

    sql = XmlSqlUtils.getSQL("mis", "MISA010_SHR_03");
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    
      Object[] bind = null;

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("DPT_CD");
    hnwExtQuery.AddField("TOT_CNT");
    hnwExtQuery.AddField("SORT_NO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("GBN_NM"));
            hnwExtQuery.AddData(vo.getString("GBN_CD"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("SORT_NO"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);


%>                           
