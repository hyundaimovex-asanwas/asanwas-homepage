<!--
***********************************************************************
* @source      : eisa020_ED_03.jsp
* @description : 직위별입퇴사자현황 상세PAGE
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

<%@page import ="com.shift.gef.support.collection.CollectionUtility"%>
<%@page import ="com.shift.gef.support.utility.SessionUtil"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>
<%
	CBox box = CollectionUtility.getGauceDataBox(request);
	box  = SessionUtil.getSession(request, box);

	String pis_yy   = request.getParameter("PIS_YY");
    String gbn_case     = request.getParameter("GBN_CASE");
    String gbn_cd       = request.getParameter("GBN_CD");
    //System.out.println("gbn_cd = " + gbn_cd);

    String head_cd = "";

    if ( !box.get("SESSION_ROLE_CD").equals("1001") && !box.get("SESSION_ROLE_CD").equals("1002")
            && box.get("SESSION_L3_AUTHO").equals("M") ) {//본부장권한 추가함. 해당본부장만 보이게(20071221, 김우태 대리)
        head_cd = box.get("SESSION_HEADCD");
    }

    String sql = null;
	StringBuffer sb1 = new StringBuffer();
	StringBuffer sb2 = new StringBuffer();

	/** DynamicSQL을 적용하는 부분 [1] **/
	if (gbn_cd.equals("etc")){
	    sb1.append(" AND GBN2_TAG NOT IN ('00','10','20','30','40','50')");
	    sb2.append(" AND H.OCC_CD = 'A' ");
	} else if (gbn_cd.equals("etc_m")){
		sb1.append("");
		sb2.append(" AND H.OCC_CD = 'M' ");
	} else if (!gbn_cd.equals("")){
	    sb1.append(" AND GBN2_TAG IN ('" + gbn_cd + "')");
	    sb2.append(" AND H.OCC_CD = 'A' ");
	} else
	{
		sb1.append("");
		sb2.append("");
	}

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb1.toString(),sb2.toString()
	};

	/** [1] ~ [4] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/

  	Object[] bind = null;

	if (gbn_case.equals("TOT_CNT")){
	    sql = XmlSqlUtils.getSQL("eis", "EISA020_SHR_11");
        bind = new Object[] {
        		pis_yy,
        		pis_yy,
        		head_cd,
        };
	} else if (gbn_case.equals("HIR_CNT")){
	    sql = XmlSqlUtils.getSQL("eis", "EISA020_SHR_12");
        bind = new Object[] {
        		pis_yy,
        		head_cd,
        };
	} else if (gbn_case.equals("RET_CNT")){
	    sql = XmlSqlUtils.getSQL("eis", "EISA020_SHR_13");
        bind = new Object[] {
        		pis_yy,
        		head_cd,
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
