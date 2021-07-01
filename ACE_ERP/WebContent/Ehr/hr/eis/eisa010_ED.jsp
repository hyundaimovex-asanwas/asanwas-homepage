<!--
***********************************************************************
* @source      : eisa010_ED.jsp
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
	
    String pis_yy   = request.getParameter("PIS_YY");

    String sql = null;
    sql = XmlSqlUtils.getSQL("eis", "EISA010_SHR");

    String head_cd = "";
    
    if ( !box.get("SESSION_ROLE_CD").equals("1001") && !box.get("SESSION_ROLE_CD").equals("1002")
    		&& box.get("SESSION_L3_AUTHO").equals("M") ) {//본부장권한 추가함. 해당본부장만 보이게(20071221, 김우태 대리)
    	head_cd = box.get("SESSION_HEADCD");
    }
    
  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy,
		  pis_yy,
		  pis_yy,
		  pis_yy,
		  pis_yy,
		  head_cd
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
	hnwExtQuery.AddField("HEAD_NM");
    hnwExtQuery.AddField("HEAD_CD");
	hnwExtQuery.AddField("HEAD_SEQ");
	hnwExtQuery.AddField("H_CNT");

    hnwExtQuery.AddField("ATT_A");
    hnwExtQuery.AddField("ATT_C");
    hnwExtQuery.AddField("ATT_E"); 
    hnwExtQuery.AddField("ATT_H"); 

    hnwExtQuery.AddField("ATT_A01");
    hnwExtQuery.AddField("ATT_C01");
    hnwExtQuery.AddField("ATT_E01"); 
    hnwExtQuery.AddField("ATT_H01"); 

    hnwExtQuery.AddField("ATT_A02");
    hnwExtQuery.AddField("ATT_C02");
    hnwExtQuery.AddField("ATT_E02"); 
    hnwExtQuery.AddField("ATT_H02"); 

    hnwExtQuery.AddField("ATT_A03");
    hnwExtQuery.AddField("ATT_C03");
    hnwExtQuery.AddField("ATT_E03"); 
    hnwExtQuery.AddField("ATT_H03"); 

    hnwExtQuery.AddField("ATT_A04");
    hnwExtQuery.AddField("ATT_C04");
    hnwExtQuery.AddField("ATT_E04"); 
    hnwExtQuery.AddField("ATT_H04"); 

    hnwExtQuery.AddField("ATT_A05");
    hnwExtQuery.AddField("ATT_C05");
    hnwExtQuery.AddField("ATT_E05"); 
    hnwExtQuery.AddField("ATT_H05"); 

    hnwExtQuery.AddField("ATT_A06");
    hnwExtQuery.AddField("ATT_C06");
    hnwExtQuery.AddField("ATT_E06"); 
    hnwExtQuery.AddField("ATT_H06"); 

    hnwExtQuery.AddField("ATT_A07");
    hnwExtQuery.AddField("ATT_C07");
    hnwExtQuery.AddField("ATT_E07"); 
    hnwExtQuery.AddField("ATT_H07"); 

    hnwExtQuery.AddField("ATT_A08");
    hnwExtQuery.AddField("ATT_C08");
    hnwExtQuery.AddField("ATT_E08"); 
    hnwExtQuery.AddField("ATT_H08"); 

    hnwExtQuery.AddField("ATT_A09");
    hnwExtQuery.AddField("ATT_C09");
    hnwExtQuery.AddField("ATT_E09"); 
    hnwExtQuery.AddField("ATT_H09"); 

    hnwExtQuery.AddField("ATT_A10");
    hnwExtQuery.AddField("ATT_C10");
    hnwExtQuery.AddField("ATT_E10"); 
    hnwExtQuery.AddField("ATT_H10"); 

    hnwExtQuery.AddField("ATT_A11");
    hnwExtQuery.AddField("ATT_C11");
    hnwExtQuery.AddField("ATT_E11"); 
    hnwExtQuery.AddField("ATT_H11"); 

    hnwExtQuery.AddField("ATT_A12");
    hnwExtQuery.AddField("ATT_C12");
    hnwExtQuery.AddField("ATT_E12"); 
    hnwExtQuery.AddField("ATT_H12"); 

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("HEAD_CD"));
            hnwExtQuery.AddData(vo.getString("HEAD_SEQ"));
            hnwExtQuery.AddData(vo.getString("H_CNT"));

            hnwExtQuery.AddData(vo.getString("ATT_A"));
            hnwExtQuery.AddData(vo.getString("ATT_C"));
            hnwExtQuery.AddData(vo.getString("ATT_E"));
            hnwExtQuery.AddData(vo.getString("ATT_H"));

            hnwExtQuery.AddData(vo.getString("ATT_A01"));
            hnwExtQuery.AddData(vo.getString("ATT_C01"));
            hnwExtQuery.AddData(vo.getString("ATT_E01"));
            hnwExtQuery.AddData(vo.getString("ATT_H01"));

            hnwExtQuery.AddData(vo.getString("ATT_A02"));
            hnwExtQuery.AddData(vo.getString("ATT_C02"));
            hnwExtQuery.AddData(vo.getString("ATT_E02"));
            hnwExtQuery.AddData(vo.getString("ATT_H02"));

            hnwExtQuery.AddData(vo.getString("ATT_A03"));
            hnwExtQuery.AddData(vo.getString("ATT_C03"));
            hnwExtQuery.AddData(vo.getString("ATT_E03"));
            hnwExtQuery.AddData(vo.getString("ATT_H03"));

            hnwExtQuery.AddData(vo.getString("ATT_A04"));
            hnwExtQuery.AddData(vo.getString("ATT_C04"));
            hnwExtQuery.AddData(vo.getString("ATT_E04"));
            hnwExtQuery.AddData(vo.getString("ATT_H04"));

            hnwExtQuery.AddData(vo.getString("ATT_A05"));
            hnwExtQuery.AddData(vo.getString("ATT_C05"));
            hnwExtQuery.AddData(vo.getString("ATT_E05"));
            hnwExtQuery.AddData(vo.getString("ATT_H05"));

            hnwExtQuery.AddData(vo.getString("ATT_A06"));
            hnwExtQuery.AddData(vo.getString("ATT_C06"));
            hnwExtQuery.AddData(vo.getString("ATT_E06"));
            hnwExtQuery.AddData(vo.getString("ATT_H06"));

            hnwExtQuery.AddData(vo.getString("ATT_A07"));
            hnwExtQuery.AddData(vo.getString("ATT_C07"));
            hnwExtQuery.AddData(vo.getString("ATT_E07"));
            hnwExtQuery.AddData(vo.getString("ATT_H07"));

            hnwExtQuery.AddData(vo.getString("ATT_A08"));
            hnwExtQuery.AddData(vo.getString("ATT_C08"));
            hnwExtQuery.AddData(vo.getString("ATT_E08"));
            hnwExtQuery.AddData(vo.getString("ATT_H08"));

            hnwExtQuery.AddData(vo.getString("ATT_A09"));
            hnwExtQuery.AddData(vo.getString("ATT_C09"));
            hnwExtQuery.AddData(vo.getString("ATT_E09"));
            hnwExtQuery.AddData(vo.getString("ATT_H09"));

            hnwExtQuery.AddData(vo.getString("ATT_A10"));
            hnwExtQuery.AddData(vo.getString("ATT_C10"));
            hnwExtQuery.AddData(vo.getString("ATT_E10"));
            hnwExtQuery.AddData(vo.getString("ATT_H10"));

            hnwExtQuery.AddData(vo.getString("ATT_A11"));
            hnwExtQuery.AddData(vo.getString("ATT_C11"));
            hnwExtQuery.AddData(vo.getString("ATT_E11"));
            hnwExtQuery.AddData(vo.getString("ATT_H11"));

            hnwExtQuery.AddData(vo.getString("ATT_A12"));
            hnwExtQuery.AddData(vo.getString("ATT_C12"));
            hnwExtQuery.AddData(vo.getString("ATT_E12"));
            hnwExtQuery.AddData(vo.getString("ATT_H12"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           

