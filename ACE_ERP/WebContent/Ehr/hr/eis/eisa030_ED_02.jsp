<!--
***********************************************************************
* @source      : eisa030_ED_02.jsp
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

    String pis_yy_c0 = request.getParameter("PIS_YY_C0");
    String pis_yy_c1 = request.getParameter("PIS_YY_C1");
    String pis_yy_c2 = request.getParameter("PIS_YY_C2");
    String pis_yy_c3 = request.getParameter("PIS_YY_C3");
    String pis_yy_c4 = request.getParameter("PIS_YY_C4");

    String sql = null;
    sql = XmlSqlUtils.getSQL("eis", "EISA030_SHR_02");

    String head_cd = "";
    
    if ( !box.get("SESSION_ROLE_CD").equals("1001") && !box.get("SESSION_ROLE_CD").equals("1002")
            && box.get("SESSION_L3_AUTHO").equals("M") ) {//본부장권한 추가함. 해당본부장만 보이게(20071221, 김우태 대리)
        head_cd = box.get("SESSION_HEADCD");
    }

    
  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy_c4,
		  pis_yy_c0,
		  head_cd,
		  pis_yy_c4,
		  pis_yy_c4,
		  pis_yy_c4,
		  head_cd,
		  pis_yy_c3,
		  pis_yy_c3,
		  pis_yy_c3,
		  head_cd,
		  pis_yy_c2,
		  pis_yy_c2,
		  pis_yy_c2,
		  head_cd,
		  pis_yy_c1,
		  pis_yy_c1,
		  pis_yy_c1,
		  head_cd,
		  pis_yy_c0,
		  pis_yy_c0,
		  pis_yy_c0,
		  head_cd,
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
	hnwExtQuery.AddField("HIR_YY");
    hnwExtQuery.AddField("TOT_CNT");
	hnwExtQuery.AddField("RET_CNT");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("HIR_YY"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("RET_CNT"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           
