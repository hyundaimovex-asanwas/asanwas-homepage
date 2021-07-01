<!--
***********************************************************************
* @source      : eisc030_ED_01.jsp
* @description : 직위별학력현황 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/06      이승욱        최초작성.
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
	
    String pis_ym   = request.getParameter("PIS_YM");

    String sql = null;
    sql = XmlSqlUtils.getSQL("eis", "EISC030_SHR_01");

    String head_cd = "";
    
    if ( !box.get("SESSION_ROLE_CD").equals("1001") && !box.get("SESSION_ROLE_CD").equals("1002")
            && box.get("SESSION_L3_AUTHO").equals("M") ) {//본부장권한 추가함. 해당본부장만 보이게(20071221, 김우태 대리)
        head_cd = box.get("SESSION_HEADCD");
    }
    
  	Object[] bind = null;
  	bind = new Object[] {
		  pis_ym,
		  pis_ym,
		  head_cd,
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
	hnwExtQuery.AddField("JOB_NM");
    hnwExtQuery.AddField("TOT_CNT");
	hnwExtQuery.AddField("A");
	hnwExtQuery.AddField("B");
    hnwExtQuery.AddField("C");
    hnwExtQuery.AddField("C_1");
    hnwExtQuery.AddField("D");
    hnwExtQuery.AddField("E"); 

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("A"));
            hnwExtQuery.AddData(vo.getString("B"));
            hnwExtQuery.AddData(vo.getString("C"));
            hnwExtQuery.AddData(vo.getString("C_1"));
            hnwExtQuery.AddData(vo.getString("D"));
            hnwExtQuery.AddData(vo.getString("E"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           

