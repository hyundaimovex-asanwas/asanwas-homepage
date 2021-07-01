<!--
***********************************************************************
* @source      : misc190_ED.jsp
* @description : 월별근로구분별 인원계획 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/25      이승욱        최초작성.
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
    String str_ymd   = request.getParameter("STR_YMD");
	String n_yy   = Integer.toString(Integer.parseInt(str_ymd) + 1);
	//str_ymd   = Integer.toString(Integer.parseInt(str_ymd) - 1);

    String sql = null;
	StringBuffer sb1 = new StringBuffer();

    sql = XmlSqlUtils.getSQL("mis", "MISC190_SHR_PRINT");

      Object[] bind = null;
      bind = new Object[] {
    		  str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  n_yy,str_ymd,n_yy,str_ymd,n_yy,str_ymd,   str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  n_yy,str_ymd,n_yy,str_ymd,n_yy,str_ymd,   str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  n_yy,str_ymd,n_yy,str_ymd,n_yy,str_ymd,   str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,str_ymd,
    		  
    		  n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,
    		  n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,
    		  n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy,n_yy   		  

      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


    hnwExtQuery.AddField("MONTH");
    hnwExtQuery.AddField("CNT1_A");
    hnwExtQuery.AddField("CNT1_M");
    hnwExtQuery.AddField("CNT1_SUM");
    hnwExtQuery.AddField("CNT2_A");
    
    hnwExtQuery.AddField("CNT_A");
    hnwExtQuery.AddField("CNT_M");
    hnwExtQuery.AddField("CNT_SUM");
    hnwExtQuery.AddField("AVR_A");
    hnwExtQuery.AddField("AVR_M");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);


            hnwExtQuery.AddData(vo.getString("MONTH"));
            hnwExtQuery.AddData(vo.getString("CNT1_A"));
            hnwExtQuery.AddData(vo.getString("CNT1_M"));
            hnwExtQuery.AddData(vo.getString("CNT1_SUM"));
            hnwExtQuery.AddData(vo.getString("CNT2_A"));
            
            hnwExtQuery.AddData(vo.getString("CNT_A"));
            hnwExtQuery.AddData(vo.getString("CNT_M"));
            hnwExtQuery.AddData(vo.getString("CNT_SUM"));
            hnwExtQuery.AddData(vo.getString("AVR_A"));
            hnwExtQuery.AddData(vo.getString("AVR_M"));

            hnwExtQuery.SendData(response);
        }
    }
    
            hnwExtQuery.EndData(response);

%>
