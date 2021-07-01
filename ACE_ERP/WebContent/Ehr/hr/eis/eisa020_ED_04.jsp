<!--
***********************************************************************
* @source      : eisa020_ED_04.jsp
* @description : 본부별입퇴사자현황 상세PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/04      이승욱        최초작성.
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
    String gbn_case     = request.getParameter("GBN_CASE");
    String gbn_cd       = request.getParameter("GBN_CD");
    String occ_cd   = request.getParameter("OCC_CD");    

    String sql = null;
	StringBuffer sb1 = new StringBuffer();

	/** DynamicSQL을 적용하는 부분 [1] **/
	if (!gbn_cd.equals("")){
	    sb1.append(" AND D.UPDPT_CD = '" + gbn_cd + "'");
	}

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb1.toString()
	};

	/** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

  	Object[] bind = null;

	if (gbn_case.equals("TOT_CNT")){
	    sql = XmlSqlUtils.getSQL("eis", "EISA020_SHR_21");
        bind = new Object[] {
        		occ_cd, pis_yy, pis_yy
        };
	} else if (gbn_case.equals("HIR_CNT")){
	    sql = XmlSqlUtils.getSQL("eis", "EISA020_SHR_22");
        bind = new Object[] {
        		occ_cd, pis_yy
        };
	} else if (gbn_case.equals("RET_CNT")){
	    sql = XmlSqlUtils.getSQL("eis", "EISA020_SHR_23");
        bind = new Object[] {
        		pis_yy, occ_cd
        };
	}

    sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

	hnwExtQuery.AddField("HEAD_CD");
	hnwExtQuery.AddField("HEAD_NM");
	hnwExtQuery.AddField("HEAD_SEQ");
	hnwExtQuery.AddField("DPT_SEQ");
	hnwExtQuery.AddField("DPT_CD");
	hnwExtQuery.AddField("DPT_NM");
	hnwExtQuery.AddField("ENO_NO");
	hnwExtQuery.AddField("JOB_CD");
	hnwExtQuery.AddField("JOB_NM");
	hnwExtQuery.AddField("JOB_SEQ");
	hnwExtQuery.AddField("ENO_NM");
	hnwExtQuery.AddField("HIR_YMD");
	hnwExtQuery.AddField("RET_YMD");


    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("HEAD_CD"));
            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("HEAD_SEQ"));
            hnwExtQuery.AddData(vo.getString("DPT_SEQ"));
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_SEQ"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("RET_YMD"));

            hnwExtQuery.SendData(response);
        }
    }
    hnwExtQuery.EndData(response);


%>
