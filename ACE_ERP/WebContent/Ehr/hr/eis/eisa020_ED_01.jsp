<!--
***********************************************************************
* @source      : eisa020_ED_01.jsp
* @description : 직위별입퇴사자현황 PAGE
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

    //String pis_ymd_fr   = request.getParameter("PIS_YMD_FR");
    //String pis_ymd_to   = request.getParameter("PIS_YMD_TO");
    String pis_yy   = request.getParameter("PIS_YY");
    String occ_cd   = request.getParameter("OCC_CD");

    String head_cd = "";

    if ( !box.get("SESSION_ROLE_CD").equals("1001") && !box.get("SESSION_ROLE_CD").equals("1002")
            && box.get("SESSION_L3_AUTHO").equals("M") ) {//본부장권한 추가함. 해당본부장만 보이게
        head_cd = box.get("SESSION_HEADCD");
    }

    String sql = null;
    sql = XmlSqlUtils.getSQL("eis", "EISA020_SHR_01");

  	Object[] bind = null;
  	bind = new Object[] {
  			pis_yy,
  			head_cd,
  			pis_yy,
  			head_cd,
  			pis_yy,
  			pis_yy,
  			head_cd,
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("JOB_NM");
	hnwExtQuery.AddField("JOB_CD");
	hnwExtQuery.AddField("TOT_CNT");
	hnwExtQuery.AddField("HIR_CNT");
	hnwExtQuery.AddField("RET_CNT");
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
            hnwExtQuery.AddData(vo.getString("HIR_CNT"));
            hnwExtQuery.AddData(vo.getString("RET_CNT"));
            hnwExtQuery.AddData(vo.getString("SORT_NO"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>
