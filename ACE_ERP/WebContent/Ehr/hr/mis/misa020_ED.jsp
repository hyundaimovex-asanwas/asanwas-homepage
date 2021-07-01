<!--
***********************************************************************
* @source      : misa020_ED.jsp
* @description : 직위별 인원현황 PAGE
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
    StringBuffer sb2 = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (gbn_case.equals("GBN2_TAG")){
        sb1.append(", T_CM_COMMON C");
    } else {
        sb1.append("");
    }

    /** DynamicSQL을 적용하는 부분 [2] **/
    if (gbn_case.equals("HEAD_CD")){
        sb2.append(" AND HEAD_CD IN ('" + gbn_cd + "')");  
    } else if (gbn_case.equals("GBN2_TAG")){
        sb2.append(" AND P.DPT_CD = C.COMM_CD AND C.SORT_NO > 0 AND C.CD_GBN  = 'A4' AND C.GBN2_TAG  = '" + gbn_cd + "'");  
    } else if (gbn_case.equals("DPT_CD")){
        sb2.append(" AND DPT_CD  = '" + gbn_cd + "'");  
    } else {
        sb2.append("");  
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb1.toString(),
            sb2.toString()
    };

    /** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

    sql = XmlSqlUtils.getSQL("mis", "MISA020_SHR");
    sql = SqlUtils.replaceQuery(sql, sqlParam);
    
      Object[] bind = null;

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("JOB_NM");
    hnwExtQuery.AddField("JOB_CD");
    hnwExtQuery.AddField("TOT_CNT");
    hnwExtQuery.AddField("SORT_NO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("SORT_NO"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);


%>                           
