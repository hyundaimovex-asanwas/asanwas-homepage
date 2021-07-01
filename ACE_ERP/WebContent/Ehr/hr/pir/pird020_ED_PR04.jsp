<!--
***********************************************************************
* @source      : pird020_ED_PR04.jsp
* @description : 인사기록표-파견사원 자격면허/근태/입사전/후경력/교육참여 조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/15      이승욱        최초작성.
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
<%@page import="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%
    String occ_cd   = request.getParameter("OCC_CD");
    String prt_selt = request.getParameter("PRT_SELT");
    String no_shr   = request.getParameter("NO_SHR");

    String sql1 = null;
    String sql2 = null;
    String sql3 = null;
    String sql4 = null;
    String sql5 = null;
    StringBuffer sb1 = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();

    /** DynamicSQL을 적용하는 부분 [1] **/
    if (occ_cd.equals("A")){
        sb1.append("'A'");
    } else if (occ_cd.equals("M")){
        sb1.append("'M'");
    } else if (occ_cd.equals("AM")){
        sb1.append("'A','M'");
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

    sql1 = XmlSqlUtils.getSQL("pir", "PIRD020_SHR_PR05"); // 자격면허
    sql1 = SqlUtils.replaceQuery(sql1, sqlParam);
    sql2 = XmlSqlUtils.getSQL("pir", "PIRD020_SHR_PR06"); // 근태
    sql2 = SqlUtils.replaceQuery(sql2, sqlParam);
    sql3 = XmlSqlUtils.getSQL("pir", "PIRD020_SHR_PR07"); // 입사전경력
    sql3 = SqlUtils.replaceQuery(sql3, sqlParam);
    sql4 = XmlSqlUtils.getSQL("pir", "PIRD020_SHR_PR08"); // 입사후경력
    sql4 = SqlUtils.replaceQuery(sql4, sqlParam);
    sql5 = XmlSqlUtils.getSQL("pir", "PIRD020_SHR_PR09"); // 교육참여
    sql5 = SqlUtils.replaceQuery(sql5, sqlParam);

    
    Object[] bind = null;

    AbstractDAO aaa1= new AbstractDAO("default");
    AbstractDAO aaa2= new AbstractDAO("default");
    AbstractDAO aaa3= new AbstractDAO("default");
    AbstractDAO aaa4= new AbstractDAO("default");
    AbstractDAO aaa5= new AbstractDAO("default");

    DynamicValueObject voList1 = aaa1.selectProcessDvo(sql1, bind);
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind);
    DynamicValueObject voList3 = aaa3.selectProcessDvo(sql3, bind);
    DynamicValueObject voList4 = aaa4.selectProcessDvo(sql4, bind);
    DynamicValueObject voList5 = aaa5.selectProcessDvo(sql5, bind);

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

            hnwExtQuery.AddData("자격면허");
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

            hnwExtQuery.AddData("근태");
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

            hnwExtQuery.AddData("입사전경력");
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

            hnwExtQuery.AddData("입사후경력");
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
    if (voList5.size() > 0)
    {
        for (int i=0; i<voList5.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList5.get(i);

            hnwExtQuery.AddData("교육참여");
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
