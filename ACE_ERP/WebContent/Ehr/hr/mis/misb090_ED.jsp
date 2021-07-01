<!--
***********************************************************************
* @source      : misb090_ED.jsp
* @description : 노동통계 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/15     방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
  elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
String STR_YMD 	= request.getParameter("STR_YMD").replaceAll("-", "");
String DPT_CD_SHR 	= request.getParameter("DPT_CD_SHR").replaceAll("-", "");

StringBuffer sb1 = new StringBuffer();
StringBuffer sb2 = new StringBuffer();

if (!DPT_CD_SHR.equals("")){
	sb1.append("AND    DPT_CD = '" + DPT_CD_SHR + "' \n");
	sb2.append("AND    A.DPT_CD = '" + DPT_CD_SHR + "' \n");
}


/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
Object[] sqlParam = new Object[] {
		sb1.toString(),
		sb2.toString()
};

String sql = XmlSqlUtils.getSQL("mis", "MISB090_SHR");
sql = SqlUtils.replaceQuery(sql, sqlParam);

	Object[] bind = new Object[] {
			STR_YMD.substring(0,4),
			STR_YMD.substring(4,6)

	};
	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    /** 필드값 세팅 **/
   	String 	colStr  =   "DPT_NM,ENO_NO,JOB_CD,KIP_AMT,SANG_AMT,TOT_AMT,JOB_NM,MF_NM,ENO_NM";

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
