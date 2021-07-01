<!--
***********************************************************************
* @source      : saga100_ED.jsp
* @description : 급여지급내역(전월대비표) PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/03      이승욱        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.support.vo.* "%>
<%@page import ="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>

<%
	String pis_ymd = request.getParameter("PIS_YMD");

	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("sag", "SAGA100_PRN");

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
		  pis_ymd, pis_ymd,  pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd,
		  pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd,
		  pis_ymd, pis_ymd,  pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd,
		  pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd,
		  pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd,  pis_ymd, pis_ymd,
		  pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd,
		  pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd,
		  pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd, pis_ymd
	};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String  colStr  =   "OCC_NM, OCC_CD, PRE_CNT,PRE_SUM_SAL,PRE_LUN_SUM,PRE_AMT_SUM,CNT,SUM_SAL,LUN_SUM,AMT_SUM,TOT_CNT,TOT_SUM,";
   	        colStr +=   "IN_CNT,IN_SUM,OUT_CNT,OUT_SUM,LSEV_CNT,LSEV_SUM,WEL_CNT,WEL_SUM,SCH_CNT,SCH_SUM,HOL_CNT,HOL_SUM,";
   	        colStr +=   "NIGHT_CNT,NIGHT_SUM,SPECIAL_CNT,SPECIAL_SUM,ETC_CNT,ETC_SUM,REMARK";

   	String[] values = colStr.split(",");
   	for( int x = 0; x < values.length; x++ ){
   		hnwExtQuery.AddField(values[x]);
   	}
       hnwExtQuery.SendField(response);

       if (voList.size() > 0)
       {
           for (int i=0; i<voList.size(); i++)
           {
               DynamicValueObject vo = (DynamicValueObject)voList.get(i);

           	for( int x = 0; x < values.length; x++ ){
                   hnwExtQuery.AddData(vo.getString(values[x]));
           	}
               hnwExtQuery.SendData(response);
           }
       }
       else
       {
       	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
       	for( int x = 0; x < values.length; x++ ){
               hnwExtQuery.AddData("");
       	}
           hnwExtQuery.SendData(response);

       }

%>
