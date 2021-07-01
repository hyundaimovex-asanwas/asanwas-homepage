<!--
***********************************************************************
* @source      : misb260_ED.jsp
* @description : 장애인근로자명부 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/01      이승욱        최초작성.
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
    String str_ymd  = request.getParameter("STR_YMD");
    String end_ymd  = request.getParameter("END_YMD");
    String cd_gbn    = request.getParameter("CD_GBN");
    String dpt_cd    = request.getParameter("DPT_CD");
System.out.println(cd_gbn);

    String sql = null;
	StringBuffer sb1 = new StringBuffer();
	StringBuffer sb2 = new StringBuffer();

	/** DynamicSQL을 적용하는 부분 [1] **/
    if (cd_gbn.equals("B2")){
        sb1.append(" AND HEAD_CD = '" + dpt_cd + "'");
        sb2.append(", SF_GET_COMMNAME('01','" + cd_gbn + "', '" + dpt_cd + "') as DPT_NM");
    } else if (cd_gbn.equals("A4")){
        sb1.append(" AND DPT_CD = '"  + dpt_cd + "'");
        sb2.append(", SF_GET_COMMNAME('01','" + cd_gbn + "', '" + dpt_cd + "')  as DPT_NM");
    }
    else {
    	sb2.append(", SF_GET_DPTNAME('01','A4', a.dpt_cd)  as DPT_NM");
    }

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb2.toString(),
			sb1.toString()
	};

	/** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

    sql = XmlSqlUtils.getSQL("mis", "MISB260_SHR");
    sql = SqlUtils.replaceQuery(sql, sqlParam);

      Object[] bind = null;
      bind = new Object[] {
//           str_ymd, end_ymd, str_ymd, end_ymd
    		  str_ymd, end_ymd
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("ENO_NO");
    hnwExtQuery.AddField("ENO_NM");
    hnwExtQuery.AddField("CET_NO");
    hnwExtQuery.AddField("TRG_CD");
    hnwExtQuery.AddField("JHDC_CD");
    hnwExtQuery.AddField("JHDC_GRA");
    hnwExtQuery.AddField("SER_STS");
    hnwExtQuery.AddField("JAN_YMD");
    hnwExtQuery.AddField("HIR_YMD");
    hnwExtQuery.AddField("RET_YMD");
    hnwExtQuery.AddField("JOB_OCC");
    hnwExtQuery.AddField("SAL_AMT");
    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("JOB_CD");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));
            hnwExtQuery.AddData(vo.getString("TRG_CD"));
            hnwExtQuery.AddData(vo.getString("JHDC_CD"));
            hnwExtQuery.AddData(vo.getString("JHDC_GRA"));
            hnwExtQuery.AddData(vo.getString("SER_STS"));
            hnwExtQuery.AddData(vo.getString("JAN_YMD"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("JOB_OCC"));
            hnwExtQuery.AddData(vo.getString("SAL_AMT"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
