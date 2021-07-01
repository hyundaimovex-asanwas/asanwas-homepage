<!--
***********************************************************************
* @source      : pird010_ED_PR04.jsp
* @description : 인사기록표-자격면허/입사전경력/근태 조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/10      이승욱        최초작성.
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
    String occ_cd   = request.getParameter("OCC_CD");
    String prt_selt = request.getParameter("PRT_SELT");
    String no_shr   = request.getParameter("NO_SHR");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (occ_cd.equals("A")){
        sb1.append("'%'");
    } else {
    	sb1.append("'"+occ_cd+"'");
    }

    /** DynamicSQL을 적용하는 부분 [2] **/
    if (no_shr.equals("")){
        sb2.append(" AND (RET_YMD is NULL OR RET_YMD >= SYSDATE)");
    } else if (prt_selt.equals("1")){
        sb2.append(" AND ENO_NO = '" + no_shr + "'");
    } else if (prt_selt.equals("2")){
        sb2.append(" AND DPT_CD = '" + no_shr + "' AND (RET_YMD is NULL OR RET_YMD >= SYSDATE)");
    } else if (prt_selt.equals("3")){
        sb2.append(" AND JOB_CD = '" + no_shr + "' AND (RET_YMD is NULL OR RET_YMD >= SYSDATE)");
    }

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb1.toString(),
			sb2.toString()

    };

    /** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

    Object[] bind = null;

    sql  = XmlSqlUtils.getSQL("pir", "PIRD010_SHR_PR10"); // 입사후경력
    sql  = SqlUtils.replaceQuery(sql, sqlParam);
    AbstractDAO aaa1= new AbstractDAO("default");
    DynamicValueObject voList1 = aaa1.selectProcessDvo(sql, bind);

    sql  = XmlSqlUtils.getSQL("pir", "PIRD010_SHR_PR07"); // 입사전경력
    sql  = SqlUtils.replaceQuery(sql, sqlParam);
    AbstractDAO aaa2= new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql, bind);

    sql  = XmlSqlUtils.getSQL("pir", "PIRD010_SHR_PR08"); // 근태
    sql  = SqlUtils.replaceQuery(sql, sqlParam);
    AbstractDAO aaa3= new AbstractDAO("default");
    DynamicValueObject voList3 = aaa3.selectProcessDvo(sql, bind);

    sql  = XmlSqlUtils.getSQL("pir", "PIRD010_SHR_PR09"); // 어학
    sql  = SqlUtils.replaceQuery(sql, sqlParam);
    AbstractDAO aaa4= new AbstractDAO("default");
    DynamicValueObject voList4 = aaa4.selectProcessDvo(sql, bind);


    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("GRP_GBN");
    hnwExtQuery.AddField("ENO_NO");
    hnwExtQuery.AddField("A");
    hnwExtQuery.AddField("B");
    hnwExtQuery.AddField("C");
    hnwExtQuery.AddField("D");
    hnwExtQuery.AddField("E");
    hnwExtQuery.AddField("F");
    hnwExtQuery.AddField("Q_RANK");

    hnwExtQuery.SendField(response);

    if (voList1.size() > 0)
    {
        for (int i=0; i<voList1.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList1.get(i);

            hnwExtQuery.AddData(vo.getString("GRP_GBN"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("A"));
            hnwExtQuery.AddData(vo.getString("B"));
            hnwExtQuery.AddData(vo.getString("C"));
            hnwExtQuery.AddData(vo.getString("D"));
            hnwExtQuery.AddData(vo.getString("E"));
            hnwExtQuery.AddData(vo.getString("F"));
            hnwExtQuery.AddData(vo.getString("Q_RANK"));

            hnwExtQuery.SendData(response);
        }
    }


    if (voList2.size() > 0)
    {
        for (int i=0; i<voList2.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList2.get(i);

            hnwExtQuery.AddData(vo.getString("GRP_GBN"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("A"));
            hnwExtQuery.AddData(vo.getString("B"));
            hnwExtQuery.AddData(vo.getString("C"));
            hnwExtQuery.AddData(vo.getString("D"));
            hnwExtQuery.AddData(vo.getString("E"));
            hnwExtQuery.AddData(vo.getString("F"));
            hnwExtQuery.AddData(vo.getString("Q_RANK"));

            hnwExtQuery.SendData(response);
        }
    }


    if (voList3.size() > 0)
    {
        for (int i=0; i<voList3.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList3.get(i);

            hnwExtQuery.AddData(vo.getString("GRP_GBN"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("A"));
            hnwExtQuery.AddData(vo.getString("B"));
            hnwExtQuery.AddData(vo.getString("C"));
            hnwExtQuery.AddData(vo.getString("D"));
            hnwExtQuery.AddData(vo.getString("E"));
            hnwExtQuery.AddData(vo.getString("F"));
            hnwExtQuery.AddData(vo.getString("Q_RANK"));

            hnwExtQuery.SendData(response);
        }
    }

    if (voList4.size() > 0)
    {
        for (int i=0; i<voList4.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList4.get(i);

            hnwExtQuery.AddData(vo.getString("GRP_GBN"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("A"));
            hnwExtQuery.AddData(vo.getString("B"));
            hnwExtQuery.AddData(vo.getString("C"));
            hnwExtQuery.AddData(vo.getString("D"));
            hnwExtQuery.AddData(vo.getString("E"));
            hnwExtQuery.AddData(vo.getString("F"));
            hnwExtQuery.AddData(vo.getString("Q_RANK"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
