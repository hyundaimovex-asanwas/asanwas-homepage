<!--
***********************************************************************
* @source      : eisa010_ED_01.jsp
* @description : 년간월별근태현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      이승욱        최초작성.
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
    String pis_mm   = request.getParameter("PIS_MM");
    String head_cd  = request.getParameter("HEAD_CD");
    String att_cd   = request.getParameter("ATT_CD");

    String sql = null;
	StringBuffer sb1 = new StringBuffer();
	StringBuffer sb2 = new StringBuffer();
	StringBuffer sb3 = new StringBuffer();
	StringBuffer sb4 = new StringBuffer();

	/** DynamicSQL을 적용하는 부분 [1],[2] **/
	if (att_cd.equals("ATT_A")){
	    sb1.append("(NVL(ATT_A,0) + NVL(ATT_B,0))");
	    sb2.append("(NVL(ATT_A,0) + NVL(ATT_B,0))");
	} else if (att_cd.equals("ATT_C")){
	    sb1.append("NVL(ATT_C,0)");
	    sb2.append("NVL(ATT_C,0)");
	} else if (att_cd.equals("ATT_E")){
	    sb1.append("NVL(ATT_E,0)");
	    sb2.append("NVL(ATT_E,0)");
	} else if (att_cd.equals("ATT_H")){
	    sb1.append("(NVL(ATT_H,0) + (NVL(ATT_P,0) + NVL(ATT_R,0) + NVL(ATT_V,0))/2 + NVL(ATT_J,0) + NVL(ATT_Z,0) + NVL(ATT_Q,0))");
	    sb2.append("(NVL(ATT_H,0) + (NVL(ATT_P,0) + NVL(ATT_R,0) + NVL(ATT_V,0))/2 + NVL(ATT_J,0) + NVL(ATT_Z,0) + NVL(ATT_Q,0))");
	}

	/** DynamicSQL을 적용하는 부분 [3] **/
	if (pis_mm.equals("0") || pis_mm.equals("00") ){
	    sb3.append(" AND PIS_MM > '00'");
	} else {
	    sb3.append(" AND PIS_MM = '" + pis_mm + "'");
	}

	/** DynamicSQL을 적용하는 부분 [4] **/
	if (head_cd.equals("")){
	    sb4.append("");
	} else {
	    sb4.append(" AND A.HEAD_CD = '" + head_cd + "'");
	}

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb1.toString(),
			sb2.toString(),
			sb3.toString(),
			sb4.toString()
	};

	/** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

    sql = XmlSqlUtils.getSQL("eis", "EISA010_SHR_01");
    sql = SqlUtils.replaceQuery(sql, sqlParam);

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy,
		  pis_yy,
		  pis_yy
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

	hnwExtQuery.AddField("HEAD_CD");
	hnwExtQuery.AddField("HEAD_NM");
	hnwExtQuery.AddField("HEAD_SEQ");
	hnwExtQuery.AddField("SORT_NO");
	hnwExtQuery.AddField("DPT_CD");
	hnwExtQuery.AddField("DPT_NM");
	hnwExtQuery.AddField("ENO_NO");
	hnwExtQuery.AddField("JOB_CD");
	hnwExtQuery.AddField("JOB_NM");
	hnwExtQuery.AddField("JOB_SEQ");
	hnwExtQuery.AddField("ENO_NM");
	hnwExtQuery.AddField("H_CNT");


    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("HEAD_CD"));
            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("HEAD_SEQ"));
            hnwExtQuery.AddData(vo.getString("SORT_NO"));
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_SEQ"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("H_CNT"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);


%>
